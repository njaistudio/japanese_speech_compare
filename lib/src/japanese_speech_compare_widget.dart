import 'dart:io';
import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:blobs/blobs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:japanese_sentence_similarity/japanese_sentence_similarity.dart';
import 'package:japanese_speech_compare/generated/l10n.dart';
import 'package:japanese_speech_compare/src/speech_recognizer_service.dart';

enum SpeechRecognizerType {
  word,
  sentence
}

enum StatusState {
  prepare,
  ready,
  listening,
  processing,
  correct,
  wrong,
  networkError,
  notSupportError;

  Color getColor(Color? baseColor) {
    switch(this) {
      case StatusState.prepare:
        return Colors.grey.shade800;
      case StatusState.ready:
      case StatusState.listening:
      case StatusState.processing:
        return baseColor ?? Colors.blue.shade300;
      case StatusState.correct:
        return Colors.green.shade300;
      case StatusState.wrong:
      case StatusState.notSupportError:
      case StatusState.networkError:
        return Colors.red.shade300;
    }
  }

  IconData get icon {
    switch(this) {
      case StatusState.prepare:
        return CupertinoIcons.zzz;
      case StatusState.ready:
        return Icons.mic_rounded;
      case StatusState.listening:
        return Icons.stop_rounded;
      case StatusState.processing:
        return CupertinoIcons.waveform;
      case StatusState.correct:
        return Icons.check_rounded;
      case StatusState.wrong:
        return Icons.close_rounded;
      case StatusState.networkError:
        return Icons.network_check_rounded;
      case StatusState.notSupportError:
        return Icons.settings_suggest_rounded;
    }
  }

  List<Effect> get effects {
    switch(this) {
      case StatusState.notSupportError:
      case StatusState.prepare:
      case StatusState.listening:
      case StatusState.processing:
      case StatusState.ready:
        return [];
      case StatusState.correct:
        return [ShakeEffect(duration: 500.ms), ScaleEffect(duration: 500.ms, begin: Offset(1, 1), end: Offset(1.5, 1.5))];
      case StatusState.wrong:
        return [ShakeEffect(duration: 500.ms), ScaleEffect(duration: 500.ms, begin: Offset(1, 1), end: Offset(1.5, 1.5))];
      case StatusState.networkError:
        return [ShakeEffect(duration: 500.ms), ScaleEffect(duration: 500.ms, begin: Offset(1, 1), end: Offset(1.5, 1.5))];
    }
  }
}

class JapaneseSpeechCompareConfig {
  JapaneseSpeechCompareConfig({
    this.answerCorrectEdge = 0.8,
    this.showAnswer = false,
    this.answerTextStyle,
    this.baseColor,
    required this.type,
  });
  final double answerCorrectEdge;
  final bool showAnswer;
  final TextStyle? answerTextStyle;
  final Color? baseColor;
  final SpeechRecognizerType type;
}

class JapaneseSpeechCompareWidget extends StatefulWidget {
  const JapaneseSpeechCompareWidget({
    super.key,
    required this.question,
    this.requiredTexts = const [],
    this.onResult,
    this.onListeningStart,
    this.onListeningEnd,
    required this.config,
  });

  final String question;
  final List<String> requiredTexts;
  final Function(bool)? onResult;
  final Function? onListeningStart;
  final Function? onListeningEnd;
  final JapaneseSpeechCompareConfig config;

  @override
  State<JapaneseSpeechCompareWidget> createState() => _JapaneseSpeechCompareWidgetState();
}

class _JapaneseSpeechCompareWidgetState extends State<JapaneseSpeechCompareWidget> {
  StatusState _statusState = StatusState.prepare;
  double _scale = 0.8;
  String _result = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _setup();
    });
  }

  _setup() async {
    await SpeechRecognizerService.instance.initialize();
    setState(() {
      switch(SpeechRecognizerService.instance.environmentState) {
        case SpeechRecognizerEnvironmentState.none:
          _statusState = StatusState.notSupportError;
        case SpeechRecognizerEnvironmentState.ready:
          _statusState = StatusState.ready;
        case SpeechRecognizerEnvironmentState.notSupportError:
          _statusState = StatusState.notSupportError;
        case SpeechRecognizerEnvironmentState.networkError:
          _statusState = StatusState.networkError;
      }
    });
  }

  _progressResult() async {
    setState(() {
      _statusState = StatusState.processing;
    });

    if(_result.isEmpty) {
      _onWrong();
      return;
    }

    final compareResult = await SentenceComparer.compare(widget.question, _result, requiredTexts: widget.requiredTexts, keepHiragana: widget.config.type == SpeechRecognizerType.word);
    if(compareResult >= widget.config.answerCorrectEdge) {
      _onCorrect();
    } else {
      _onWrong();
    }
  }

  _onCorrect() {
    setState(() {
      _statusState = StatusState.correct;
    });
    widget.onResult?.call(true);
  }

  _onWrong() async {
    setState(() {
      _statusState = StatusState.wrong;
    });
    widget.onResult?.call(false);
    await Future.delayed(const Duration(seconds: 1));
    if(mounted) {
      setState(() {
        _statusState = StatusState.ready;
      });
    }
  }

  @override
  void dispose() {
    SpeechRecognizerService.instance.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraint) {
          final size = min(constraint.maxWidth, constraint.maxHeight);
          final isError = _statusState == StatusState.notSupportError || _statusState == StatusState.networkError;
          return AspectRatio(
            aspectRatio: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(_result.isNotEmpty && widget.config.showAnswer) DefaultTextStyle(
                  key: ValueKey(_result),
                  style: widget.config.answerTextStyle ?? const TextStyle(
                    fontSize: 16.0,
                  ),
                  child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText(_result),
                    ],
                  ),
                ),
                if(_statusState != StatusState.prepare) TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0.8, end: _scale),
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOut,
                  builder: (context, scale, child) {
                    return Transform.scale(
                      scale: scale,
                      child: child,
                    );
                  },
                  child: GestureDetector(
                    onTap: () async {
                      if(_statusState != StatusState.ready && _statusState != StatusState.listening) return;

                      if(SpeechRecognizerService.instance.isListening) {
                        await SpeechRecognizerService.instance.stopListening();
                        setState(() {
                          _statusState = StatusState.ready;
                        });
                        return;
                      }
                      Duration? estimatePronounceDuration;
                      if(Platform.isIOS) {
                        estimatePronounceDuration = await _estimateKanjiPronounceDuration(widget.question, widget.config.type);
                      }
                      SpeechRecognizerService.instance.startListening(
                        listenDuration: estimatePronounceDuration,
                        onSoundLevelChanged: (level) {
                          if(_scale == 1 && level == 1) {
                            return;
                          }
                          setState(() {
                            _scale = 1 + level / 2;
                          });
                        },
                        onFinalResult: (text) {
                          setState(() {
                            _result = text;
                          });
                          _progressResult();
                        },
                        onListeningStart: () {
                          widget.onListeningStart?.call();
                          setState(() {
                            _scale = 1;
                            _result = "";
                            _statusState = StatusState.listening;
                          });
                        },
                        onListeningEnd: () async {
                          widget.onListeningEnd?.call();
                          setState(() {
                            _scale = 0.8;
                          });
                        },
                      );
                    },
                    child: Blob.animatedRandom(
                      size: size / (isError ? 2 : 1.7),
                      edgesCount: 9,
                      minGrowth: 9,
                      loop: true,
                      duration: Duration(milliseconds: 500),
                      styles: BlobStyles(
                        color: _statusState.getColor(widget.config.baseColor),
                      ),
                      child: Center(
                        child: Animate(
                          effects: _statusState.effects,
                          child: Icon(
                            _statusState.icon,
                            size: size / 6,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if(_statusState == StatusState.notSupportError) Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      Text(
                        Platform.isAndroid ? JapaneseSpeechCompareS.current.jscAndroidPermissionError : JapaneseSpeechCompareS.current.jscIOSPermissionError,
                        textAlign: TextAlign.center,
                        style: widget.config.answerTextStyle?.copyWith(fontSize: size / 7),
                      ),
                      SizedBox(height: 8,),
                      ElevatedButton(
                        onPressed: () {
                          _setup();
                        },
                        child: Text(JapaneseSpeechCompareS.current.jscRetry),
                      )
                    ],
                  ),
                ),
                if(_statusState == StatusState.networkError) Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      Text(
                        JapaneseSpeechCompareS.current.jscNetworkError,
                        textAlign: TextAlign.center,
                        style: widget.config.answerTextStyle?.copyWith(fontSize: size / 8),
                      ),
                      SizedBox(height: 8,),
                      ElevatedButton(
                        onPressed: () {
                          _setup();
                        },
                        child: Text(JapaneseSpeechCompareS.current.jscRetry),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        }
    );
  }

  int _countMora(String romaji) {
    romaji = romaji.toLowerCase().replaceAll(RegExp(r'[^a-z]'), '');
    int mora = 0;

    for (int i = 0; i < romaji.length; i++) {
      String c = romaji[i];

      if ('aeiou'.contains(c)) {
        mora++;
      }

      else if (c == 'n') {
        if (i + 1 >= romaji.length || !'aeiou'.contains(romaji[i + 1])) {
          mora++;
        }
      }

      else if (i + 1 < romaji.length && romaji[i] == romaji[i + 1] && !'aeiou'.contains(c)) {
        mora++;
        i++;
      }
    }

    return mora;
  }

  Duration _estimateRomajiPronounceDuration(String romaji, {double timePerMora = 0.5}) {
    int mora = _countMora(romaji);
    return Duration(milliseconds: max(3000, (mora * timePerMora * 1000).round()));
  }

  Future<Duration> _estimateKanjiPronounceDuration(String kanji, SpeechRecognizerType type, {double timePerMora = 0.5}) async {
    switch(type) {
      case SpeechRecognizerType.word:
        return Duration(milliseconds: 3000);
      case SpeechRecognizerType.sentence:
        final questionRomaji = await JssStringUtils.getTransliteratedRomaji(widget.question);
        return _estimateRomajiPronounceDuration(questionRomaji, timePerMora: timePerMora);;
    }
  }
}
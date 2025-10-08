import 'dart:io';

import 'package:japanese_speech_compare/src/network_utils.dart';
import 'package:speech_to_text/speech_to_text.dart';

typedef OnSpeechResult = void Function(String text);
typedef OnStatusChange = void Function();

enum SpeechRecognizerEnvironmentState  {
  none,
  ready,
  notSupportError,
  networkError,
}

class SpeechRecognizerService {
  static final SpeechRecognizerService instance = SpeechRecognizerService._internal();
  SpeechRecognizerService._internal();
  SpeechRecognizerEnvironmentState _environmentState = SpeechRecognizerEnvironmentState.none;

  final SpeechToText _speechToText = SpeechToText();
  bool _isListening = false;

  bool get isListening => _isListening;
  SpeechRecognizerEnvironmentState get environmentState => _environmentState;

  Future<void> initialize() async {
    final isOnline = await NetworkUtils.isDeviceOnline();
    if(!isOnline) {
      _environmentState = SpeechRecognizerEnvironmentState.networkError;
      return;
    }

    final isAvailable = await _speechToText.initialize();
    if(isAvailable) {
      _environmentState = SpeechRecognizerEnvironmentState.ready;
    } else {
      _environmentState = SpeechRecognizerEnvironmentState.notSupportError;
    }
  }

  void startListening({
    String localeId = "ja_JP",
    Function(double)? onSoundLevelChanged,
    Duration? listenDuration,
    OnStatusChange? onListeningStart,
    OnStatusChange? onListeningEnd,
    OnSpeechResult? onPartialResult,
    OnSpeechResult? onFinalResult,
  }) {
    if (_environmentState != SpeechRecognizerEnvironmentState.ready) {
      return;
    }

    if(_isListening) {
      stopListening();
      startListening(
        localeId: localeId,
        onSoundLevelChanged: onSoundLevelChanged,
        listenDuration: listenDuration,
        onListeningStart: onListeningStart,
        onListeningEnd: onListeningEnd,
        onPartialResult: onPartialResult,
        onFinalResult: onFinalResult,
      );
      return;
    }

    _isListening = true;
    onListeningStart?.call();
    if(listenDuration != null) {
      Future.delayed(listenDuration).then((_) {
        stopListening();
      });
    }

    _speechToText.listen(
      localeId: localeId,
      onSoundLevelChange: (level) {
        onSoundLevelChanged?.call(_normalizeSoundLevel(level));
      },
      onResult: (result) {
        if (result.finalResult) {
          onFinalResult?.call(result.recognizedWords);
        } else {
          onPartialResult?.call(result.recognizedWords);
        }
      },
    );

    _speechToText.statusListener = (status) {
      if ((status == 'done' || status == 'notListening') && _isListening) {
        _isListening = false;
        onListeningEnd?.call();
      }
    };

    _speechToText.errorListener = (error) {
      onFinalResult?.call("");
    };
  }

  stopListening() async {
    if (_isListening) {
      await _speechToText.stop();
    }
  }

  double _normalizeSoundLevel(double level) {
    if (Platform.isIOS) {
      return level.clamp(0.0, 1.0);
    }
    if (Platform.isAndroid) {
      return (level / 10).clamp(0.0, 1.0);
    }

    return 0;
  }
}
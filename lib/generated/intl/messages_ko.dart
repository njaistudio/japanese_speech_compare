// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ko locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ko';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "jscAndroidPermissionError": MessageLookupByLibrary.simpleMessage(
      "앱에서 음성 인식을 위해 마이크 및 Google Speech 서비스 권한이 필요합니다. 설정에서 권한을 허용해주세요.",
    ),
    "jscIOSPermissionError": MessageLookupByLibrary.simpleMessage(
      "앱에서 음성 인식을 위해 마이크 권한이 필요합니다. 설정에서 권한을 허용해주세요.",
    ),
    "jscNetworkError": MessageLookupByLibrary.simpleMessage(
      "이 기능을 사용하려면 네트워크 연결이 필요합니다. 연결을 확인하고 다시 시도해주세요.",
    ),
    "jscRetry": MessageLookupByLibrary.simpleMessage("다시 시도"),
  };
}

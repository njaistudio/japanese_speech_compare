// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a hi locale. All the
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
  String get localeName => 'hi';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "jscAndroidPermissionError": MessageLookupByLibrary.simpleMessage(
      "वॉयस पहचान के लिए ऐप को माइक्रोफोन और Google Speech Services की अनुमति चाहिए। कृपया सेटिंग्स में अनुमति दें।",
    ),
    "jscIOSPermissionError": MessageLookupByLibrary.simpleMessage(
      "वॉयस पहचान के लिए ऐप को माइक्रोफोन अनुमति चाहिए। कृपया सेटिंग्स में अनुमति दें।",
    ),
    "jscNetworkError": MessageLookupByLibrary.simpleMessage(
      "इस सुविधा के लिए नेटवर्क कनेक्शन आवश्यक है। कृपया कनेक्शन जांचें और पुनः प्रयास करें।",
    ),
    "jscRetry": MessageLookupByLibrary.simpleMessage("पुनः प्रयास करें"),
  };
}

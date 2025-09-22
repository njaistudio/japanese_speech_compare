// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a my locale. All the
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
  String get localeName => 'my';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "jscAndroidPermissionError": MessageLookupByLibrary.simpleMessage(
      "အသံဖော်ပြမှုအတွက် မိုက်ခရိုဖုန်းနှင့် Google Speech Services ခွင့်ပြုချက်လိုအပ်သည်။ ဆက်တင်များတွင်ခွင့်ပြုချက်ပေးပါ။",
    ),
    "jscIOSPermissionError": MessageLookupByLibrary.simpleMessage(
      "အသံဖော်ပြမှုအတွက် မိုက်ခရိုဖုန်းခွင့်ပြုချက်လိုအပ်သည်။ ဆက်တင်များတွင်ခွင့်ပြုချက်ပေးပါ။",
    ),
    "jscNetworkError": MessageLookupByLibrary.simpleMessage(
      "ဤအင်္ဂါစိတ်သည် ကွန်ယက်ချိတ်ဆက်မှုလိုအပ်သည်။ ချိတ်ဆက်မှုအားစစ်ဆေးပြီး ထပ်မံကြိုးစားပါ။",
    ),
    "jscRetry": MessageLookupByLibrary.simpleMessage("ထပ်မံကြိုးစားပါ"),
  };
}

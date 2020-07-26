import 'package:get/get.dart';

class AppTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {'greeting': 'Hey %s!'},
        'en_IN': {'greeting': 'Hello %s!'},
        'hn_IN': {'greeting': 'नमस्ते %s'},
        'gj_IN': {'greeting': 'કેમ છો %s'},
      };
}

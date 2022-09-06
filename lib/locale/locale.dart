import 'package:get/get.dart';

class MyLocale extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'ar': {
      'login': 'دخول',
      'home':'الصفحة الرئيسية'
    },
    'en': {
      'login': 'Login',
      'home':'Home Screen'
    }
  };
}
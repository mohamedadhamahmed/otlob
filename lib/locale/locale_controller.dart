

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyLocaleController extends GetxController{
  void changeLocale(String lang){
    Locale locale =Locale(lang);
    Get.updateLocale(locale);
  }
}
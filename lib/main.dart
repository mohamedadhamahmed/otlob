import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:untitled/view/Auth/login.dart';
import 'package:untitled/view/Auth/register.dart';
import 'package:untitled/view/home.dart';
import 'All_Bindings/bindings.dart';
import 'controller/AuthController.dart';
import 'locale/locale.dart';

void main() async{
  //await Firebase.initializeApp();

  WidgetsFlutterBinding.ensureInitialized();
 await  Firebase.initializeApp();
  String? token = await FirebaseMessaging.instance.getToken();
  print(token);



  runApp(const MyApp());

}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/second',
      locale: Get.deviceLocale,
translations: MyLocale(),
      getPages: [
        GetPage(name: '/', page: () => Home(),binding: HomeBinding()),
         GetPage(name: '/second', page: () => Login()),
        GetPage(
            name: '/third',
            page: () => Register(),
            transition: Transition.zoom
        ),
      ],);
  }

}


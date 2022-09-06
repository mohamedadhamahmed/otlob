import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/homeController.dart';

class Home extends StatelessWidget {

  @override
  Widget build(context) {

    // Instantiate your class using Get.put() to make it available for all "child" routes there.
   // final  c = Get.find();

    return Scaffold(
      // Use Obx(()=> to update Text() whenever count is changed.
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
            title: Icon(Icons.manage_accounts_rounded,color: Colors.grey,),
        actions: [Padding(
          padding: const EdgeInsets.all(10.0),
          child: Badge(
            badgeContent: Text('3'),
            child: Icon(Icons.notification_important_outlined,color: Colors.grey,),
          ),
        )],),


        // Replace the 8 lines Navigator.push by a simple Get.to(). You don't need context
        body: Center(child: ElevatedButton(
            child: Text("Go to Other"), onPressed: () => Get.to(Other()))),
        );
  }
}

class Other extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.
  final  c = Get.find();

  @override
  Widget build(context){
    // Access the updated count variable
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}
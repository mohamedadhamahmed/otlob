import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/AuthController.dart';
import '../SharedWidgets/textfield.dart';



class Login extends StatelessWidget {


  AuthController authController = new AuthController();
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    GlobalKey<FormState> form_login_key = GlobalKey<FormState>();
    TextEditingController textpassword = TextEditingController();
    TextEditingController textemail = TextEditingController();
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: height * 0.85,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/background.png'),
                          fit: BoxFit.fill)),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: width * 0.05,
                        width: 80,
                        height: height * 0.18,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/images/light-1.png'))),
                        ),
                      ),
                      Positioned(
                          left: width * 0.19,
                          width: 80,
                          height: height * 0.15,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-2.png'))),
                          )),
                      Positioned(
                          right: width * 0.08,
                          top: 40,
                          width: 50,
                          height: 150,
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/clock.png'))),
                          )),

                      Positioned(
                          right: width * 0.12,
                          left: width * 0.12,
                          top: height * 0.3,
                          bottom: 0,
                          child: Container(
                            height: height * 0.6,
                            width: width * 0.75,
                            child: Form(
                                      key: form_login_key,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                                bottom: height * 0.07),
                                            width: width * 0.30,
                                            child: Center(
                                                child: Text(
                                              "Login",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                          ),
                                          Container(
                                            padding: EdgeInsets.all(5),
                                            width: width * 0.75,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, .2),
                                                      blurRadius: 20.0,
                                                      offset: Offset(0, 10))
                                                ]),
                                            child: Column(
                                              children: <Widget>[
                                                Custom_TextField(
                                                    "Email or Phone number",
                                                    textemail,
                                                    height * 0.08,
                                                    true),
                                                Custom_TextField(
                                                    "Password",
                                                    textpassword,
                                                    height * 0.08,
                                                    false),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: 15,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              if (form_login_key.currentState!
                                                  .validate()) {

                                                form_login_key.currentState!
                                                    .save();
                                                authController
                                                    .changeToLoading();
                                                var data =
                                                    await authController
                                                        .signIn(textemail.text, textpassword.text);
                                                authController
                                                    .changeToUnLoad();
                                                if(data['access_token']==null){
                                                  textemail.clear();
                                                  textpassword.clear();
                                                  Get.snackbar(
                                                      'Password or email incorrect',
                                                      'Enter the correct password and email',
                                                      snackPosition: SnackPosition.TOP,
                                                  colorText: Colors.black,
                                                  backgroundColor: Colors.white);

                                                }
                                              else{

                                                 textemail.clear();
                                                  textpassword.clear();
                                                var   userdata=data['user'];
                                                  if(userdata['verify_phone_number']==1){
                                                    Get.offAllNamed('/');

                                                  }
                                                  else{
                                                    Get.snackbar(
                                                        'Verify',
                                                        'Please verify your phone number',
                                                        snackPosition: SnackPosition.TOP,
                                                        colorText: Colors.black,
                                                        backgroundColor: Colors.white);
                                                  }
                                                }
                                              }
                                            },
                                            child: Container(
                                              height: 40,
                                              width: width * 0.75,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Color.fromRGBO(
                                                        143, 148, 251, 1),
                                                    Color.fromRGBO(
                                                        143, 148, 251, .6),
                                                  ])),
                                              child: Center(
                                                child: Text(
                                                  "Login",
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          InkWell(
                                            onTap: () async {
                                              authController
                                                  .changeToLoading();
                                                await authController.signInWithGoogle();
                                              authController
                                                  .changeToUnLoad();
                                              },
                                            child: Container(
                                              height: 40,
                                              width: width * 0.75,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  gradient:
                                                      LinearGradient(colors: [
                                                    Color.fromRGBO(
                                                        143, 148, 251, 1),
                                                    Color.fromRGBO(
                                                        143, 148, 251, .6),
                                                  ])),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      height: 40,
                                                      width: 50,
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: AssetImage(
                                                                  'assets/images/logo2.png'))),
                                                    ),
                                                    Text(
                                                      "Google",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 22),
                                                    ),
                                                  ],
                                                ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 12,
                                          ),
                                          Container(
                                            height: 23,
                                            width: width * 0.75,

                                            child: InkWell(
                                                onTap: () {
                                                  Get.toNamed('/third');
                                                },
                                                child: Text(
                                                  "Create Account ?",textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                      color: Color.fromRGBO(
                                                          143, 148, 251, 1),
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                Obx(() => authController.loading == 1?
                           Positioned(
                    right: width * 0.2,
                    left: width * 0.2,
                    top: height * 0.4,
                               bottom: height*0.2,
                               child: Container(
                                 decoration: BoxDecoration(
                                     borderRadius:
                                     BorderRadius.circular(10),
                                   color:Colors.grey.withOpacity(0.4)
                                     ),
                             child:  Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 new CircularProgressIndicator(
                                   strokeWidth:4,
                                   color: Colors.green,
                                 ),
                                 SizedBox(height: 10,),
                                 new Text("Loading"),
                               ],
                             ),
                           ) ):Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }




}
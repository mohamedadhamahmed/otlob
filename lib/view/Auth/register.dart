import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controller/AuthController.dart';
import '../SharedWidgets/textfield.dart';

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = Get.height;
    double width = Get.width;
    GlobalKey<FormState> form_login_key = GlobalKey<FormState>();
    TextEditingController textpassword = TextEditingController();
    TextEditingController textemail = TextEditingController();
    TextEditingController textname = TextEditingController();
    TextEditingController textphone = TextEditingController();
    TextEditingController textconfirm = TextEditingController();
    AuthController authController = new AuthController();
    String otp='';
    String result_verify='';

    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                Container(
                  height: height * 0.9,
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
                        top: height * 0.25,
                        bottom: 0,
                        child: Container(
                          height: height * 0.6,
                          width: width * 0.75,
                          child: Form(
                            key: form_login_key,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin:
                                      EdgeInsets.only(bottom: height * 0.07),
                                  width: width * 0.30,
                                  child: Center(
                                      child: Text(
                                    "Register",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                  )),
                                ),
                                Container(
                                  padding: EdgeInsets.all(5),
                                  width: width * 0.75,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: Color.fromRGBO(
                                                143, 148, 251, .2),
                                            blurRadius: 20.0,
                                            offset: Offset(0, 10))
                                      ]),
                                  child: Column(
                                    children: <Widget>[
                                      Custom_TextField("Name", textname,
                                          height * 0.08, true),
                                      Custom_TextField("Email", textemail,
                                          height * 0.08, true),
                                      Custom_TextField("Phone Number +2001011223306",
                                          textphone, height * 0.08, true),
                                      Custom_TextField("Password", textpassword,
                                          height * 0.08, true),
                                      Custom_TextField("Confirm Password",
                                          textconfirm, height * 0.08, false),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  height: 37,
                                  width: width * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      gradient: LinearGradient(colors: [
                                        Color.fromRGBO(143, 148, 251, 1),
                                        Color.fromRGBO(143, 148, 251, .6),
                                      ])),
                                  child: Center(
                                    child: InkWell(
                                        onTap: () async {

                                          if (form_login_key.currentState!
                                              .validate()) {
                                            print(form_login_key.currentState!
                                                .validate());
                                            authController.changeToLoading();
                                            var data =
                                                await authController.signUp(
                                                    textemail.text,
                                                    textpassword.text,
                                                    textname.text,textphone.text);

                                            if (data["message"] ==
                                                "User successfully registered") {
                                              textemail.clear();
                                              textpassword.clear();
                                              textemail.clear();
                                              textpassword.clear();
                                              textphone.clear();
                                              textname.clear();
                                              textconfirm.clear();
                                            await  authController.verifyPhoneNumber('+2001013448806');
                                              authController.changeToUnLoad();
                                              Get.defaultDialog(
                                                      title: "Verify Code",

                                                      backgroundColor: Colors.grey,
                                                      titleStyle: TextStyle(color: Colors.white),
                                                      middleTextStyle: TextStyle(color: Colors.white),

                                                      textCancel: "Cancel",
                                                      textConfirm: 'Confirm',
                                                      onConfirm: ()async{
                                                        authController.changeToLoading();
                                                        result_verify=await authController.verifyOTP(otp);
                                                        Get.back();

                                                      },
                                                      cancelTextColor: Colors.white,
                                                      confirmTextColor: Colors.white,
                                                      buttonColor: Colors.green,
                                                      barrierDismissible: false,
                                                      radius: 15,
                                                      content: Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                         children: [
                                                           Text("Enter the number to send to you ",style: TextStyle(color: Colors.white,fontSize: 19),),
SizedBox(height: 20,),
                                                           Container(

                                                             padding: EdgeInsets.all(8.0),
                                                             height: 85,
                                                             decoration:
                                                             BoxDecoration(border: Border(bottom: BorderSide(color:  Colors.black))),
                                                                  child: TextFormField(

                                                               decoration: InputDecoration(
                                                                 prefixIcon: Icon(
                                                                   Icons.key,
                                                                   color: Colors.black,
                                                                 ),
                                                                 hintText: 'enter otp',
                                                                 filled: true,
                                                                 fillColor: Colors.white,
                                                                 enabledBorder: OutlineInputBorder(
                                                                     borderRadius: BorderRadius.circular(20),
                                                                     borderSide: BorderSide(color: Colors.white)),
                                                                 focusedBorder: OutlineInputBorder(
                                                                     borderRadius: BorderRadius.circular(20),
                                                                     borderSide: BorderSide(color: Colors.white)),
                                                                 border: OutlineInputBorder(
                                                                     borderRadius: BorderRadius.circular(20),
                                                                     borderSide: BorderSide(color: Colors.red)),
                                                               ),

                                                               onChanged: (value){
                                                                 otp=value;
                                                               },
                                                               maxLength: 6,
                                                               keyboardType: TextInputType.number,
                                                               inputFormatters: <TextInputFormatter>[
                                                                 FilteringTextInputFormatter.digitsOnly
                                                               ], // Only numbers can be entered
                                                             ),
                                                           ),
                                                 ],)
                                                      );
                                             if(result_verify=='Done'){
                                               Get.snackbar(' registered',
                                                   "User successfully registered",
                                                   snackPosition:
                                                   SnackPosition.TOP,
                                                   colorText: Colors.black,
                                                   backgroundColor:
                                                   Colors.white);
                                               authController.changeToLoading();
                                          var data =
                                          await authController
                                              .signIn(textemail.text, textpassword.text);
                                          print('login data');
                                          print('data');
                                          authController
                                              .changeToUnLoad();
                                               Get.offAllNamed('/');
                                             }
                                            } else {
                                              String email_error =
                                                  data['email'] == null
                                                      ? ''
                                                      : data['email'][0];
                                              String name_error =
                                                  data['name'] == null
                                                      ? ''
                                                      : data['name'][0];
                                              String password_error =
                                              data['password'] == null
                                                  ? ''
                                                  : data['password'][0];
                                              String phone_error =
                                              data['phone'] == null
                                                  ? ''
                                                  : data['phone'][0];

                                              Get.snackbar(
                                                  ' Invalid Input',
                                                  email_error +
                                                      ' ' +
                                                      name_error +
                                                      ' ' +
                                                      password_error+' '+phone_error,
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  colorText: Colors.black,
                                                  backgroundColor:
                                                      Colors.white);
                                              if (password_error != '' &&
                                                  email_error == '') {
                                                textpassword.clear();
                                              } else if (email_error != '' &&
                                                  password_error == '') {
                                                textemail.clear();
                                              } else {
                                                textemail.clear();
                                                textpassword.clear();
                                              }
                                            }
                                            authController.changeToUnLoad();
                                          }
                                          // if(textphone.text.length!=14){
                                          //   textphone.clear();
                                          //   Get.defaultDialog(
                                          //       title: "Phone Number Problem",
                                          //       middleText: "Phone Number must Contain 14 digit",
                                          //       backgroundColor: Colors.grey.withOpacity(0.4),
                                          //       titleStyle: TextStyle(color: Colors.white),
                                          //       middleTextStyle: TextStyle(color: Colors.white),
                                          //
                                          //       textCancel: "Cancel",
                                          //       cancelTextColor: Colors.white,
                                          //       confirmTextColor: Colors.white,
                                          //       buttonColor: Colors.green,
                                          //       barrierDismissible: false,
                                          //       radius: 15,
                                          //       // content: Column(
                                          //       //   children: [
                                          //       //
                                          //       //   ],
                                          //       //)
                                          //   );
                                          // }

                                        },
                                        child: const Text(
                                          "Register",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Obx(() => authController.loading == 1
                          ? Positioned(
                              right: width * 0.2,
                              left: width * 0.2,
                              top: height * 0.4,
                              bottom: height * 0.2,
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.withOpacity(0.4)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    new CircularProgressIndicator(
                                      strokeWidth: 4,
                                      color: Colors.green,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    new Text("Loading ...",style: TextStyle(color: Colors.white,fontSize: 22),),
                                  ],
                                ),
                              ))
                          : Container()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

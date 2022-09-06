import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/authModel.dart';

class AuthController extends GetxController{
  var  loading = 0.obs;
  String verificationId='';
  var authStatus=''.obs;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  AuthModel authModel=new AuthModel();
  Future signIn(String email,String password)async {
 var  data=await authModel.login(email,password);
 if(data.body['access_token']!=null) {
   var authUserData = data.body['user'];
   await saveUserData(
       data.body['access_token'], authUserData['name'], authUserData['email'],
       authUserData['profile_photo_url']);
   print('save');
 }
 // else{
 //   Get.snackbar(
 //       'Account',
 //       'Account not found please register and try again',
 //       snackPosition: SnackPosition.TOP,
 //       colorText: Colors.black,
 //       backgroundColor: Colors.white);
 //   changeToUnLoad();
 //   return 'error';
 // }
 return data.body;

  }

  Future signUp(String email,String password,String name,String phone)async {
    var  data=await authModel.signUp(email,password,name, phone);
    print(data.body);
    return data.body;
  }


  changeToLoading() {
    loading+=1;
    return loading;
  }
  changeToUnLoad() {
    loading-=1;
    return loading;
  }


   saveUserData(String token,String name,String email,String profile_photo_url)async{
    final    prefs = await SharedPreferences.getInstance();
    prefs.setStringList('AuthUser', <String>[token,name, email,profile_photo_url]);

    print('save done');
  }
 Future  getAuthUser()async{
   final    prefs = await SharedPreferences.getInstance();
   final List<String>? userData = prefs.getStringList('AuthUser');
   print ('get here');

    return userData;
  }


  Future<void> signInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    print(googleSignInAccount!.email);
    print(googleSignInAccount.displayName);
    print(googleSignInAccount.id);
    var signUpData= await signUp(googleSignInAccount.email,googleSignInAccount.id,googleSignInAccount.displayName.toString(),'2001011223306');
    print(signUpData);

    if(signUpData['email'][0]=='please enter unique  email'){
      var login_data = await signIn(googleSignInAccount.email, googleSignInAccount.id);
      print(login_data);
      Get.offAllNamed('/');
    }
    else if(signUpData["message"]== "User successfully registered"){
      var login_data = await signIn(googleSignInAccount.email, googleSignInAccount.id);
      print(login_data);
      Get.offAllNamed('/');
    }

    }


  verifyPhoneNumber(String phone) async {
    print('phone number');
    print(phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {
        // For andriod only automatic handling of the SMS code
      },
      verificationFailed: (FirebaseAuthException e) {
       // Get.snackbar('error verify', e.toString());
      },

      codeSent: (String Id, int? resendToken) {
        // SMS Code sent show a dialogue to enter the code.
       // _displayPhoneNumberVerificationDialog(verificationId);
        this.verificationId=Id;git init
        this.authStatus.value='verify success';
        print('otp is:');
        print(Id);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        this.verificationId=verificationId;
      },
    );
  }

  verifyOTP(String otp)async{
    print(otp);
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;

    //UserCredential userCredential = await confirmationResult.confirm('123456');


    try {

    var data=  await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
        verificationId: this.verificationId,
        smsCode: otp,
      ));
    print('result');
    print(data);
      } catch (e) {
        // General error
      }

      return 'Done';
    }



  }




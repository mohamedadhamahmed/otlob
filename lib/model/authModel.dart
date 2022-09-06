import 'package:get/get.dart';

class AuthModel extends GetConnect{

  Future  login(String email,String password)async{
    Response data= await post('http://10.0.2.2:8000/api/auth/login?email=$email&password=$password',{});

    return data;
 }

  Future  signUp(String email,String password,String name,String phone)async{
    Response data= await post('http://10.0.2.2:8000/api/auth/register?name=$name&email=$email&password=$password&phone=$phone',{});

    return data;
  }
}
import 'package:flutter/material.dart';

class Custom_TextField extends StatelessWidget {
  String hient;
  TextEditingController textEditingController;
  double hight;
  bool border=true;
  Custom_TextField( this.hient,
      this.textEditingController, this.hight,this.border
      );

  String errorMasage(String str) {
    switch (str) {
      case "Email or Phone number":
        return 'Email is empty';
        case "Email":
      return 'Email is empty';
      case "Phone Number":
        return "Phone Number is empty";
      case "Password":
        return "password is empty";
      case "Name":
        return "Name is empty";
      case "Confirm Password":
        return "Confirm Password is empty";
      default:
        return str+" is empty";
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      height: this.hight,
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: this.border? Colors.grey:Colors.white))),
      child: TextFormField
        (
        controller: textEditingController,

        obscureText: hient == "Password"||hient =="Confirm Password"
            ? true
            : false,

        validator: (value) {
          if (value!.isEmpty) {
            return errorMasage(hient);
          } else {
            return null;
          }
        },
        decoration: InputDecoration(
            border: InputBorder.none,
            hintText: this.hient,
            hintStyle:TextStyle(color:  Colors.grey[400])),
      ),
    );
  }
}

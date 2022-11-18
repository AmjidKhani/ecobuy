
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Screens/mobile_side/_AuthScreen/Signup_Screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../Components/Widget/Round_Button.dart';
import '../../../Components/Widget/textfield.dart';


import '../../../Firebase Services/Authentications.dart';
import '../../../Firebase Services/all_variables.dart';



class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final formkey=GlobalKey<FormState>();
  bool visiableretype = true;
  TextEditingController EmailC = TextEditingController();
  TextEditingController passC = TextEditingController();
submit(){
  if(formkey.currentState!.validate()){
    Authentications.Login(EmailC.text.toString(),
        passC.text.toString(),context
    )
        .then((value) {
      setState(() {
        AllVariables.isLoading = false;
      });
    });
  }

}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 120.h,
          ),
           Center(
              child: Text(
            "Welcome \n Please Login First",
            style: txtStyle.boldStyle,
            textAlign: TextAlign.center,
          )),
          SizedBox(
            height: 30.h,
          ),
          Form(
            key:formkey ,
            child: Column(
              children: <Widget>[
                textfield(
                  label: 'Please Email',
                  contoller: EmailC,
                  validate: (v)
                  {
                    if (v!.isEmpty||!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+") .hasMatch(v)){
                      return "Email is badly formatted";
                    }
                    else{
                      return "";
                    }
                    },
                ),

                textfield(
                  label: 'Please Enter Password',
                  contoller: passC,
                  obsecuretext: visiableretype ? true : false,
                  maxLine: 1,


                  validate: (v){
                    if (v!.isEmpty) {
                      return "Password is badly formatted";
                    }
                    return null;
                    
                    },
                ),
                Round_Button(
                  Loading: AllVariables.isLoading,
                  text: 'LOGIN',
                  OnPressed: () {
                    formkey.currentState!.validate();
                   // submit();
                    setState(() {
                      AllVariables.isLoading = true;
                    });
                    Authentications.Login(EmailC.text.toString(),
                        passC.text.toString(),context
                    ).then((value) {
                      setState(() {
                        AllVariables.isLoading = false;
                      });
                    });
                  },
                ),
                Round_Button(
                  text: 'Create New Account',
                  coloechange: true,
              Loading:    AllVariables.isLoading,
                  OnPressed: () {

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Signup_Screen()));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    )));
  }
}

import 'package:ecobuy/Components/Widget/Round_Button.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Components/Widget/textfield.dart';
import 'package:ecobuy/Firebase%20Services/Authentications.dart';
import 'package:ecobuy/Firebase%20Services/FirebaseApi_AllInstance.dart';
import 'package:ecobuy/Firebase%20Services/all_variables.dart';
import 'package:ecobuy/Screens/web_side/admindashboard.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebLogin extends StatefulWidget {
  static String id='WebLogin';
  @override
  State<WebLogin> createState() => _WebLoginState();
}

class _WebLoginState extends State<WebLogin> {
  final formkey = GlobalKey<FormState>();

  bool visiableretype = true;

  TextEditingController EmailC = TextEditingController();

  TextEditingController passC = TextEditingController();

  String Email = 'admin@gmail.com';

  String password = 'admin123';

  checking(BuildContext context) {
    if (EmailC.text == Email && passC.text == password) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => AdminDashBoard()));
    } else {
      Utils.toastMessage('Invalid Email or Password');
      print('Invalid Email or Password');
    }
  }

  submit(BuildContext context) async {
    if (formkey.currentState!.validate()) {
      await Authentications.WebSignIn(EmailC.text).then((value) async {
        if (value['username'] == EmailC.text &&
            value['password'] == passC.text) {
          try {
            UserCredential user = await Firebase_Instance.auth
                .signInAnonymously();
            if (user != null) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AdminDashBoard()));
              setState(() {
                AllVariables.isLoading=false;
              });
            }
          }
          catch (e) {
            Utils.toastMessage(e.toString());
            setState(() {
              AllVariables.isLoading=false;
            });
          }
        }
      }) ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                child: Container(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: 160, vertical: 50),
                      height: 400,
                      decoration: BoxDecoration(
                        // color: Colors.green,
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: Colors.black,
                          )),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 30.h,
                          ),
                          Center(
                              child: Text(
                                "Welcome \n  Admin Please Login First",
                                style: txtStyle.boldStyle,
                                textAlign: TextAlign.center,
                              )),
                          SizedBox(
                            height: 30.h,
                          ),
                          Form(
                            key: formkey,
                            child: Column(
                              children: <Widget>[
                                textfield(
                                  label: 'UserName ',
                                  contoller: EmailC,
                                  validate: (v) {
                                    if (v!.isEmpty )

                                             {
                                      return "Email is badly formatted";
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                                textfield(
                                  label: 'Please Enter Password',
                                  contoller: passC,
                                  obsecuretext: visiableretype ? true : false,
                                  validate: (v) {
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
                                    setState(() {

                                      AllVariables.isLoading=true;
                                    });
                                    submit(context);

                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                )
            )
        )
    );
  }
}

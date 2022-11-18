import 'package:ecobuy/Components/Widget/Round_Button.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Firebase%20Services/Authentications.dart';
import 'package:ecobuy/Firebase%20Services/all_variables.dart';
import 'package:ecobuy/Screens/mobile_side/_AuthScreen/Login_Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecobuy/Components/Widget/textfield.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({Key? key}) : super(key: key);
  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  TextEditingController EmailC = TextEditingController();
  TextEditingController passC = TextEditingController();
  TextEditingController rpassC = TextEditingController();

  final formkey = GlobalKey<FormState>();
  bool visiable = true;
  bool visiableretype = true;

  submit() {
    if (formkey.currentState!.validate()) {}
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
            "Welcome \n Please Register First",
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
                  label: 'Please Email',
                  contoller: EmailC,
                  validate: (v) {
                    if (v!.isEmpty
                        //    || v.contains("@")||v.contains(".com")
                        ) {
                      return "Email is badly formatted";
                    }
                    return "";
                  },
                  // prefixicon: Icon(
                  //   Icons.email,
                  // )
                ),
                textfield(
                  label: 'Please Enter Password',
                  contoller: passC,
                  obsecuretext: visiable ? true : false,
                  validate: (v) {
                    if (v!.isEmpty) {
                      return "Password is badly formatted";
                    }
                    return "";
                  },
                  sufixicon: IconButton(
                    icon: visiable
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off_sharp),
                    onPressed: () {
                      setState(() {
                        visiable = !visiable;
                      });
                    },
                  ),
                ),
                textfield(
                  label: 'Retype Password',
                  contoller: rpassC,
                  obsecuretext: visiableretype ? true : false,
                  validate: (v) {
                    String p = passC.text.toString();
                    String e = rpassC.text.toString();

                    if (v!.isEmpty) {
                      return "Password is badly formatted";
                    } else if (!p
                        .toLowerCase()
                        .contains(e.toLowerCase().toLowerCase())) {
                      return "Password not Match";
                    } else if (v.length == 2) {
                      return "Password is too Week";
                    }

                    return "";
                  },
                  sufixicon: IconButton(
                    icon: visiableretype
                        ? Icon(Icons.visibility)
                        : Icon(Icons.visibility_off_sharp),
                    onPressed: () {
                      setState(() {
                        visiableretype = !visiableretype;
                      });
                    },
                  ),
                ),
                Round_Button(
                  Loading: AllVariables.isLoading,
                  text: 'SIGNUP',
                  OnPressed: () async {
                    submit();
                    setState(() {
                      AllVariables.isLoading = true;
                    });
                    Authentications.Signup(EmailC.text.toString(),
                            passC.text.toString(), context)
                        .then((value) {
                      setState(() {
                        AllVariables.isLoading = false;
                      });
                    });
                  },
                ),
                Round_Button(
                  text: 'Already Have Account LOGIN',
                  coloechange: true,
                  OnPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Login_Screen()));
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

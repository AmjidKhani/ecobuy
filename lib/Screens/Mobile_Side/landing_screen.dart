import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/bottomnavigationbar.dart';
import 'package:ecobuy/Screens/Mobile_Side/_AuthScreen/Login_Screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_screen.dart';
class LandingScreen extends StatelessWidget {
  Future<FirebaseApp> initilized = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initilized,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Text("${snapshot.error}"),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder:
                (BuildContext context, AsyncSnapshot<dynamic> streamSnapshot) {
              if (streamSnapshot.hasError) {
                return Scaffold(
                  body: Text("${snapshot.error}"),
                );
              }
              if (streamSnapshot.connectionState == ConnectionState.active) {
                User? user = streamSnapshot.data;
                if (user == null) {
                  return Login_Screen();
                } else {
                  return BottomNavigation();
                }
              }
              return Scaffold(
                  body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Text(
                    "Checking Authentication ....",
                  )),
                  SizedBox(
                    height: 30.h,
                  ),
                  Center(child: CircularProgressIndicator()),
                ],
              ));
            },
          );
        }

        return Scaffold(
            body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: Text(
              "Initilization App ....",
            )),
            SizedBox(
              height: 30.h,
            ),
            Center(child: CircularProgressIndicator()),
          ],
        ));
      },
    );
  }
}

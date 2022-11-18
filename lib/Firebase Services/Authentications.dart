
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';

import '../Screens/mobile_side/_AuthScreen/Login_Screen.dart';
import '../Screens/mobile_side/home_screen.dart';
import '../Utils/util.dart';
import 'FirebaseApi_AllInstance.dart';

class Authentications
{
  static Future<DocumentSnapshot> WebSignIn(var id)async{
var result=Firebase_Instance.firebaseFirestore.collection('Admin').doc(id).get();
    return result;
  }

 static Future<void> Signup(String Email,String pass,BuildContext context)async {
   try{
     await Firebase_Instance.auth.createUserWithEmailAndPassword(email: Email, password: pass).
     then((value) {
       Navigator.push(context, MaterialPageRoute(
         builder: (context)=>Login_Screen())
       );
     });
   }
   catch(e){
     Utils.snackbar(e.toString(), context);

   }

  }
 static Future<void> Login(String Email,String pass,BuildContext context)async {
   try{
     await Firebase_Instance.auth.signInWithEmailAndPassword(
         email: Email, password: pass).

     then((value) {
       Navigator.push(context, MaterialPageRoute(
           builder: (context)=>HomeScreen())
       );
     });
   }
   catch(e){
     Utils.snackbar(e.toString(), context);

   }




  }


}
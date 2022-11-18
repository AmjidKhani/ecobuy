//import 'package:another_flushbar/flushbar.dart';
//import 'package:another_flushbar/flushbar_route.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:fluttertoast/fluttertoast.dart';

class Utils {


 static  void toastMessage(String message){
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0.sp
    );
  }
  static void flushBarErrorMessage(String message,BuildContext context)
  {
    showFlushbar(
        context: context,
        flushbar: Flushbar(

          forwardAnimationCurve: Curves.decelerate,
          margin: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
          padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 15.h),
          message: message,
          duration:Duration(seconds: 3) ,
          borderRadius: BorderRadius.circular(10.r),
          flushbarPosition: FlushbarPosition.TOP,
          backgroundColor: Colors.red,
          reverseAnimationCurve: Curves.easeInOut,
          positionOffset: 20,
          icon: Icon(Icons.error,size: 20.sp,color: Colors.white,),
        )..show(context),



    );

  }
  static snackbar(String message,BuildContext context){
   return ScaffoldMessenger.of(context).showSnackBar(

     SnackBar(
         backgroundColor: Colors.red,
         content: Text(message)
     )

   );
  }
  static focustonext(BuildContext context,FocusNode first,FocusNode next  ){
   first.unfocus();
   FocusScope.of(context).requestFocus(next);

  }
}

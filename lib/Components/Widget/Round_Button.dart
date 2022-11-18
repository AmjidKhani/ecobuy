import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class Round_Button extends StatelessWidget {
  String? text;
  bool coloechange;
  VoidCallback? OnPressed;
  bool Loading;
  Round_Button({
    required this.text,
    this.coloechange=false,
    required this.OnPressed,
    this.Loading=false,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnPressed,
      child: Container(
        margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 20.h),
        height: 60.h,
        width: double.infinity,
        decoration: BoxDecoration(
            border:Border.all(
              color:coloechange? Colors.black:Colors.white,

            ) ,
          color:coloechange? Colors.white:Colors.black,
          borderRadius: BorderRadius.circular(10.r)

        ),
        child: Center(child:


        Loading?
        const Center(
          child: CircularProgressIndicator(
            strokeWidth:4,
            color: Colors.white,
          ),
        ):
        Text(
          text!,style: TextStyle(
          color:coloechange? Colors.black:Colors.white,
          fontSize: 20.sp,
        ),
        )
        ),
      ),
    );
  }
}



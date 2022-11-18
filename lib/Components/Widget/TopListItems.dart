import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TopTitle extends StatelessWidget {
  String? title;
   TopTitle({
    Key? key,required this.title
  }) : super(key: key);
   @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 8.h),
      child: Container(
        height: 60.h
            //.h
        ,
        width:double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            gradient: const LinearGradient(
                colors: [
                  Colors.red,
                  Colors.green,
                ]
            )
        ),
        child: Center(child: Text(
          title!,style: txtStyle.boldStyle.copyWith(color: Colors.white),)),
      ),
    );
  }
}
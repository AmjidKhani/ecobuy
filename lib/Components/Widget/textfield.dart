import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class textfield extends StatelessWidget {
  String? label;
  int? maxLine;
  TextEditingController? contoller;
  String? Function(String?)? validate;
  bool obsecuretext;
  IconButton? sufixicon;
  Icon? prefixicon;
  bool visiiable;
  final TextInputAction? inputAction;
  textfield({
    required this.label,
    this.maxLine=1,
    required this.contoller,
    this.validate,
    this.obsecuretext=false,
this.prefixicon,
    this.sufixicon,
    this.visiiable=false,
    this.inputAction
});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20.w,right: 20.w,top: 20.h),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.circular(10.r)
      ),
      child: TextFormField(
        maxLines: maxLine==1?1:maxLine,
        textInputAction: inputAction,
        obscureText: obsecuretext,
        validator: validate,
        controller: contoller,
        decoration: InputDecoration(
            border: InputBorder.none,
          labelText: label,
            prefixIcon: prefixicon,
            suffixIcon:sufixicon,
            contentPadding: EdgeInsets.symmetric(horizontal: 5.h,vertical: 5.w)
        )
      ),
    );
  }
}

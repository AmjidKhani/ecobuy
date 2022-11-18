
import 'package:flutter/material.dart';

class Appheader extends StatelessWidget {
  String? title;
  Appheader({
   required this.title
});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text( title==null?"All Products": title.toString(),style: TextStyle(
            color: Colors.black
        )
        ),
        centerTitle: true,
        //automaticallyImplyLeading: true,


        iconTheme:IconThemeData(

            color: Colors.black)
    );
  }
}
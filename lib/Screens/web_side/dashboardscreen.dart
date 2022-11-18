import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBoardScreen extends StatefulWidget {
  static const String id='DashBoardScreen';
  const DashBoardScreen({super.key}) ;

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(child: Text("Dashboard Screen",style: txtStyle.boldStyle,))
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckingScreen extends StatefulWidget {
  const CheckingScreen({Key? key}) : super(key: key);

  @override
  State<CheckingScreen> createState() => _CheckingScreenState();
}

class _CheckingScreenState extends State<CheckingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Text("Checking Screen")),
        ],
      ),
    );
  }
}

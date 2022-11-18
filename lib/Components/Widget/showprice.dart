import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class price extends StatefulWidget {
  String? title;
   price({
    Key? key,required this.title,
  }) : super(key: key);

  @override
  State<price> createState() => _priceState();
}

class _priceState extends State<price> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            height: 50,
            width: 150,
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Text(widget.title.toString(),style: TextStyle(
                  color: Colors.white
              ),),
            ),
          ),
        ),
      ],
    );
  }
}
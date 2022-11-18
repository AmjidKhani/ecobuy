import 'dart:math';

import 'package:ecobuy/Screens/mobile_side/home_screen.dart';
import 'package:flutter/material.dart';

class category extends StatelessWidget {
  const category({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(titles.length, (index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 3.0),
              child: Container(
                child: Container(
                  height: 80,
                  width: 75,
                  decoration: BoxDecoration(
                      color:
                      Colors.primaries[Random().nextInt(titles.length)],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red.withOpacity(0.3),
                          blurRadius: 3,
                          spreadRadius: 2,
                        )
                      ]),
                  child: Center(
                      child: Text(
                        titles[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      )),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
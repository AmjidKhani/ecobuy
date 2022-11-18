import 'package:flutter/material.dart';

class HotSalesNewArrival extends StatelessWidget {
  const HotSalesNewArrival({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 10,),
        Container(
          height: 80,
          width: 170,
          decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Center(child: Text("HOT \n SALES",textAlign: TextAlign.center,

            style:TextStyle(
              color: Colors.white,fontWeight: FontWeight.w400,),



          )
          ),
        ),
        SizedBox(width: 20,),

        Container(
          height: 80,
          width: 170,
          decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15)
          ),
          child: Center(

              child: Text("NEW \n Arrival",
                style:TextStyle(
                  color: Colors.white,fontWeight: FontWeight.w400,),
                textAlign: TextAlign.center,

              )
          ),
        )
      ],
    );
  }
}


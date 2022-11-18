import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
class addproducticonsdata extends StatefulWidget {
  String? productPrice;

  addproducticonsdata({
    this.productPrice
});
  @override
  State<addproducticonsdata> createState() => _addproducticonsdataState();
}

class _addproducticonsdataState extends State<addproducticonsdata> {
  @override
  void initState() {

    widget.productPrice;
    super.initState();
  }
  var count=1;
  var price;
  var firstProductPrice;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black,width: 0.1)
      ),
      child: Row(
        children: [
          IconButton(onPressed: (){
            setState(() {
              if (count>1) {
                count--;
              }
            });
          }, icon: Icon(Icons.exposure_minus_1_rounded)),
          SizedBox(width: 2,),
          Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black,width: 0.05
              )
            ),
            child: Center(
              child: Text("${count}",style: TextStyle(color: Colors.black,
              fontSize: 20
              ),),
            ),
          ),
          SizedBox(width: 2,),
          IconButton(onPressed: (){
            setState(() {
              count++;
              price  =count *firstProductPrice;
            });
            },
              icon: Icon(Icons.exposure_plus_1_outlined)),

          txtStyle.sh40,
          txtStyle.sh40,
          txtStyle.sh40,
    Row(
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
    child: Text(price,style: TextStyle(
    color: Colors.white
    ),),
    ),
    ),
    ),
    ],
    )
        ],
      ),
    );
  }
}
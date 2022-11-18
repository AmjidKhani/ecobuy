import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/appheader.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Cart_Screen extends StatefulWidget {
  const Cart_Screen({Key? key}) : super(key: key);

  @override
  State<Cart_Screen> createState() => _Cart_ScreenState();
}

class _Cart_ScreenState extends State<Cart_Screen> {

 Future DeleteCart(String id)async{
    CollectionReference db=await FirebaseFirestore.instance.collection('Cart');
    db.doc(id).delete().then((value)  {
      Utils.toastMessage("Delete Successfully");


    }).onError((error, stackTrace) {

      Utils.toastMessage(error.toString());
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Appheader(title: 'ADD To Cart')),
        body: Column(
          children: [
            Text("Hwello"),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: StreamBuilder(
                stream: FirebaseFirestore.instance.collection('Cart').snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      var res = snapshot.data!.docs[index];

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [
                              Row(

                                children: [

                                  Container(
                                    height:100,
                                    width: 100,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 2.0,horizontal: 1.5),
                                        child: Image.network(
                                          res['imageUrls'],
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,

                                        ),
                                      ),
                                    ),
                                    decoration: BoxDecoration(

                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        res['productName'],
                                        style: txtStyle.boldStyle.copyWith(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            'Qty :',
                                            style: txtStyle.boldStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(
                                            res['Quantity'].toString(),
                                            style: txtStyle.boldStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            'Price :',
                                            style: txtStyle.boldStyle.copyWith(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
                                          ),
                                          Text(res['price'].toString(),
                                              style: txtStyle.boldStyle.copyWith(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500)),
                                          // SizedBox(
                                          //   width: 90,
                                          // ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  // SizedBox(width: 10,),

                                ],
                              ),
                              SizedBox(width: 30,),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      DeleteCart(res.id);
                                    },
                                    child: CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.red,
                                      child: Center(
                                          child: Icon(
                                            Icons.remove,
                                            size: 20,
                                          )),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}

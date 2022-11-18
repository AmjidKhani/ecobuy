import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/appheader.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Models/products_model.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/detail_productscreen.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/product_screen.dart';
import 'package:ecobuy/Screens/Mobile_Side/home_screen.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Product_Screen extends StatefulWidget {
  String? category;

  Product_Screen({Key? key, this.category}) : super(key: key);

  @override
  State<Product_Screen> createState() => _Product_ScreenState();
}

class _Product_ScreenState extends State<Product_Screen> {
  List<Product> productsData = [];
  List<Product> TotalItems = [];

  getData() async {
    FirebaseFirestore.instance
        .collection("Products")
        .get()
        .then((QuerySnapshot? snapshot) {
      if (widget.category != null) {
        snapshot!.docs
            .where((element) => element['Category'] == widget.category)
            .forEach((e) {
          if (e.exists) {
            if (e['productName'].isNotEmpty) {
              setState(() {
                productsData.add(
                  Product(
                    id: e['ID'],
                    category: e['Category'],
                    productName: e['productName'],
                    imageUrls: e['imageUrls'],
                  ),
                );
              });
            } else {
              Utils.toastMessage("Image  Urls is not Present");
            }
          } else {
            Center(
                child: Text(
              "No Data Found",
              textAlign: TextAlign.center,
            ));
          }
        });
      } else {
        snapshot!.docs.forEach((e) {
          if (e.exists) {
            if (e['productName'].isNotEmpty) {
              setState(() {
                productsData.add(
                  Product(
                    id: e['ID'],
                    category: e['Category'],
                    productName: e['productName'],
                    imageUrls: e['imageUrls'],
                    price: e['price'],
                    discountPrice: e['discountPrice'],

                  ),
                );
              });
            } else {
              Utils.toastMessage("Image  Urls is not Present");
            }
          } else {
            Center(
                child: Text(
              "No Data Found",
              textAlign: TextAlign.center,
            ));
          }
        });
      }
    });
  }
  @override
  void initState() {
    getData();

    Future.delayed(Duration(seconds: 1), () {
      TotalItems.addAll(productsData);
    });

    // TODO: implement initState
    super.initState();
  }

  TextEditingController searchC = TextEditingController();

  FilterData(String ContValue) {
    List<Product> StoreContValue = [];
    if (ContValue.isNotEmpty) {
      TotalItems.forEach((element) {
        if (element.productName!
            .toLowerCase()
            .contains(ContValue.toLowerCase())) {
          StoreContValue.add(element);
          setState(() {
            productsData.clear();
            productsData.addAll(StoreContValue);
          });
        }
      });
    } else {
      setState(() {
        productsData.clear();
        productsData.addAll(TotalItems);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
      appBar:
          PreferredSize(preferredSize: Size.fromHeight(50), child:Appheader(title:widget.category,)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: searchC,
                onChanged: (v) {
                  FilterData(searchC.text);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Search Products ...")),
              ),
            ),
            txtStyle.sh20,
            Expanded(
              child: GridView.builder(
                  itemCount: productsData.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>
                            Detail_Product_screen(
                          id: productsData[index].id.toString(),

                        )));
                      },
                      child: Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                    productsData[index].imageUrls![0]),
                              ),
                              border: Border.all(color: Colors.black),
                            ),
                          ),
                          Text(productsData[index].productName.toString()),
                        ],
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/Round_Button.dart';
import 'package:ecobuy/Components/Widget/appheader.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Models/addtocart.dart';
import 'package:ecobuy/Models/products_model.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:ecobuy/Components/Widget/showprice.dart';
import 'package:ecobuy/Components/Widget/addquantity.dart';
import 'package:flutter/material.dart';

class Detail_Product_screen extends StatefulWidget {
  String id;

  Detail_Product_screen({
    required this.id,
  });

  @override
  State<Detail_Product_screen> createState() => _Detail_Product_screenState();
}

class _Detail_Product_screenState extends State<Detail_Product_screen> {
  List<Product> PopularProducts = [];
  var count = 1;
  var price;
  var firstProductPrice;
  bool isLoading =false;

  getData() async {
    FirebaseFirestore.instance
        .collection("Products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs
          .where((element) => element['ID'] == widget.id)
          .forEach((e) {
        if (e.exists) {
          if (e['productName'].isNotEmpty) {
            setState(() {
              PopularProducts.add(
                Product(
                  category: e['Category'],
                  id: e['ID'],
                  productName: e['productName'],
                  brand: e['Brand'],
                  detail: e['detail'],
                  price: e['price'],
                  discountPrice: e['discountPrice'],
                  serialCode: e['serialCode'],
                  imageUrls: e['imageUrls'],
                  isOnSale: e['isOnSale'],
                  isPopular: e['isPopular'],
                  isFavourite: e['isFavourite'],
                ),
              );
              firstProductPrice = PopularProducts.first.price!;
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
    });
  }

  CollectionReference favorite = FirebaseFirestore.instance
      .collection('Favorite')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('Items');

  AddFavoriteItem() async {
    favorite.add({'PFID': PopularProducts.first.id});
  }

  RemoveFavoriteItem(String id) async {
    CollectionReference favorite = await FirebaseFirestore.instance
        .collection('Favorite')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('Items');
    favorite.doc(id).delete();
  }

  @override
  void initState() {
    getData();
    widget.id;
    // TODO: implement initState
    super.initState();
  }

  int SelectedIndex = 0;

  @override
  Widget build(BuildContext context) {

    print("data found are not");
    return PopularProducts.length == 0
        ? Center(child:Text(""))
        //?
            // ? Center(child: CircularProgressIndicator())
            : Scaffold(
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(50),
                    child: Appheader(title: PopularProducts[0].category)),
                body: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          height: 200,
                          width: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                  PopularProducts[0].imageUrls![SelectedIndex]),
                            ),
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                      Center(child: Text(PopularProducts[0].productName!)),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ...List.generate(
                                PopularProducts[0].imageUrls!.length, (index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      SelectedIndex = index;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          height: 130,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.black),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Image.network(
                                              PopularProducts[0]
                                                  .imageUrls![index])),
                                    ],
                                  ),
                                ),
                              );
                            })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        constraints: BoxConstraints(
                          maxHeight: 60,
                          maxWidth: 60,
                          minHeight: 60,
                          minWidth: 60,
                        ),
                        height: 50,
                        width: 60,

                        child: StreamBuilder(
                            stream: favorite
                                .where('PFID',
                                    isEqualTo: PopularProducts.first.id)
                                .snapshots(),
                            builder:
                                (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return
                                    //Icon(Icons.favorite,size: 25);
                                    Center(child: Text(" ")
                                   // CircularProgressIndicator()
                                    );
                              }
                              // if (snapshot.connectionState ==
                              //     ConnectionState.waiting) {
                              //   return Center(
                              //       child: Text('waiting'),);
                              //       //CircularProgressIndicator());
                              // }
                              return IconButton(
                                  onPressed: () {
                                    snapshot.data!.docs.length == 0
                                        ? AddFavoriteItem()
                                        : RemoveFavoriteItem(
                                            snapshot.data!.docs.first.id);
                                  },
                                  icon: Icon(Icons.favorite,
                                      size: 25,
                                      color: snapshot.data!.docs.length == 0
                                          ? Colors.black
                                          : Colors.red));
                            }),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      // price( ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Description",
                              style: txtStyle.boldStyle.copyWith(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '1):Liquid Retina HD display. \n'
                              '2):6.1-inch (diagonal) all-screen.\n'
                              '3):LCD Multi-Touch display with IPS technology.\n'
                              '4):1792-by-828-pixel resolution at 326 ppi.\n'
                              '5):1400:1 contrast ratio (typical).\n'
                              '6):True Tone display.\n'
                              '7):Wide color display (P3).\n'
                              '8):Haptic Touch.\n'
                              '9):625 nits max brightness (typical)\n',
                              style: txtStyle.boldStyle.copyWith(fontSize: 15),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "NOTE:Discount of 10 Rupees will be Applied on Selecting 5 Items",
                            style: txtStyle.boldStyle.copyWith(fontSize: 15),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border:
                                Border.all(color: Colors.black, width: 0.1)),
                        child: Row(
                          children: [
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (count > 1) {
                                      count--;
                                      if (count > 3) {
                                        price = count *
                                            int.parse(PopularProducts
                                                .first.discountPrice!);
                                      } else {
                                        price = count *
                                            int.parse(firstProductPrice);
                                      }
                                    }
                                  });
                                },
                                icon: Icon(Icons.exposure_minus_1_rounded)),
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.black, width: 0.05)),
                              child: Center(
                                child: Text(
                                  "${count}",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    count++;
                                    if (count > 3) {
                                      price = count *
                                          int.parse(PopularProducts
                                              .first.discountPrice!);
                                    } else {
                                      price =
                                          count * int.parse(firstProductPrice);
                                    }
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
                                      child: Text(
                                        '${price == null ? firstProductPrice : price} PKR',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Round_Button(
                        Loading: isLoading,
                        text: 'ADD To Cart',
                        OnPressed: () {

                          setState(() {
                            isLoading=true;
                          });
                          Cart.addToCart(
                                Cart(
                                    id: PopularProducts.first.id,
                                    ProductName: PopularProducts.first.productName,
                                    Image: PopularProducts.first.imageUrls!.first,
                                    price:price==null?PopularProducts.first.price:price,
                                    quantity:count
                                )
                            ).whenComplete(() {
                              setState(() {
                                isLoading=false;
                              });
                            }).onError((error, stackTrace) {
                              Utils.toastMessage("Data  not Successfully Added");
                              setState(() {
                                isLoading=false;
                              });

                            });


                        },


                      ),

                      txtStyle.sh40,
                      // price(title: 'ADD To Cart',),
                      txtStyle.sh40,
                      txtStyle.sh40,
                      txtStyle.sh40,
                    ],
                  ),
                ),
              );
  }
}

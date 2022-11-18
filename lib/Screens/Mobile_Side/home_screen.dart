import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/Caruselslider.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Models/homepagecategory.dart';
import 'package:ecobuy/Models/products_model.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/detail_productscreen.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/product_screen.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecobuy/Components/Widget/topcategory.dart';
import 'package:ecobuy/Components/Widget/hotsalesnewarrival.dart';

final List titles = [
  'Grocery',
  'Electronic',
  'Pharmacy',
  'Cloths',
  'Cosmetics',
  'Beauty',
  'Mart',
  'Fashion'
];

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _Home_ScreenState();
}

class _Home_ScreenState extends State<HomeScreen> {
  final List images = [
    'https://cdn.pixabay.com/photo/2016/11/22/19/08/hangers-1850082_1280.jpg',
    'https://cdn.pixabay.com/photo/2020/03/27/17/03/shopping-4974313_1280.jpg',
    'https://cdn.pixabay.com/photo/2019/03/12/09/18/tomatoes-4050245_1280.jpg',
    'https://cdn.pixabay.com/photo/2018/02/04/09/09/brushes-3129361_1280.jpg',
    'https://cdn.pixabay.com/photo/2016/11/19/17/02/chinese-1840332_1280.jpg'
  ];
  List<Product> PopularProducts = [];

  getData() async {
    FirebaseFirestore.instance
        .collection("Products")
        .get()
        .then((QuerySnapshot? snapshot) {
      snapshot!.docs.forEach((e) {
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

  @override
  void initState() {
    getData();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: SafeArea(
      child: Column(children: [
        SizedBox(
          height: 20.h,
        ),
        Text(
          "Home Screen",
          style: txtStyle.boldStyle,
        ),
        SizedBox(
          height: 20.h,
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: <Widget>[
              ...List.generate(
                categories.length,
                (index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Product_Screen(
                                    category: categories[index].title,
                                  )));
                    },
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 3.0),
                            child: Container(
                              height: 100,
                              width: 100,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                      categories[index].images.toString(),
                                    ),
                                    fit: BoxFit.contain),
                              ),
                              // child: Text("hello",),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Center(
                        child: Text(
                          categories[index].title.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      ),
                      txtStyle.sh20,
                    ]),
                  );
                },
              ),
            ],
          ),
        ),
        category(),
        SizedBox(
          height: 20.h,
        ),
        //slider
        coruselslider(images: images),

        Text(
          "Popular Products",
          style: txtStyle.boldStyle,
        ),
        txtStyle.sh20,
        PopularProducts.length == 0
            ? CircularProgressIndicator()
            : Column(
              children: [
                Container(

                  height: 200,
                  width: 1200,
                  child: ListView(

                    scrollDirection: Axis.horizontal,
                    children: PopularProducts.where((element) {
                      return element.isPopular == true;
                    }).map((e) {
                      return InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (_)=>
                              Detail_Product_screen(
                                id: e.id.toString(),

                              )));
                        },
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 160,
                                width: 100,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(15)

                                ),
                                child:  Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Image.network(
                                      e.imageUrls!.first,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                              ),
                            ),
                            Text(e.productName!,style: TextStyle(
                               fontWeight: FontWeight.bold,fontSize: 14
                             ),)
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
        txtStyle.sh20,
        HotSalesNewArrival(),
        txtStyle.sh20,
        Text(
          "Popular Brands",
          style: txtStyle.boldStyle,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 150,
                width: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                    child: Text(
                  "Hot \n Sales",
                  textAlign: TextAlign.center,
                )),
              ),
            ],
          ),
        ),
      ]),
    )));
  }
}

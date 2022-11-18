import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/appheader.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/detail_productscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class Favourite_Screen extends StatefulWidget {
  const Favourite_Screen({Key? key}) : super(key: key);
  @override
  State<Favourite_Screen> createState() => _Favourite_ScreenState();
}
class _Favourite_ScreenState extends State<Favourite_Screen> {
  List FavouriteProducts = [];
 GetFavouriteData() async {
   await FirebaseFirestore.instance
        .collection("Favorite")
        .doc( FirebaseAuth.instance.currentUser!.uid )
        .collection('Items')
        .get()
        .then((QuerySnapshot<Map<String,dynamic>> snapshot) =>
            snapshot.docs.forEach((element) {
              setState(() {
                  FavouriteProducts.add( element['PFID']);
              });
                }
                )
   );
 }
  @override
  void initState() {

    GetFavouriteData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    print('FavouriteProducts');
   print(FavouriteProducts);
   print("Dataaaaaaa");
    return FavouriteProducts.length==0?
    Center(child:
    CircularProgressIndicator()
    ):
    Scaffold(
        appBar: PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: Appheader(
              title: 'Favourite',
            )),
        body: Column(

          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance.collection('Products').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: Text("Snapshot Not has Data",style: TextStyle(
                      color: Colors.black,fontSize: 20
                  ),)
                  );
                }

                List<QueryDocumentSnapshot<Object?>> fp = snapshot.data!.docs.where((element) =>
                    FavouriteProducts.contains(element['ID']
                    )
                ).toList();
                print("fp data is where ");

                  print(fp);

                if (fp.length==0) {
                  return Center(
                    child: Text("No Favourite Item Found ",style: TextStyle(
                        fontSize: 15,color: Colors.black
                    ),),
                  );
                }
                return Expanded(
                  child: ListView.builder(
                    itemCount:

                    fp.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (_)=>Detail_Product_screen(id: fp[index]['ID'])));
                          },
                          child: Card(
                            color: Colors.black,
                            child: ListTile(
                              title: Text(
                                fp[index]['productName'].toString(),
                                style: TextStyle(color: Colors.white,fontSize: 30),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Models/products_model.dart';
import 'package:ecobuy/Screens/web_side/completeupdatescreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UpdateProduct extends StatefulWidget {
  static const String id='UpdateProduct';
  const UpdateProduct({Key? key}) : super(key: key);

  @override
  State<UpdateProduct> createState() => _UpdateProductState();
}

class _UpdateProductState extends State<UpdateProduct> {
CollectionReference products=FirebaseFirestore.instance.collection('Products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          txtStyle.sh40,
          Text("Update Product Screen",style: txtStyle.boldStyle,),

          txtStyle.sh40,
          StreamBuilder<QuerySnapshot>(
            stream:products.snapshots() ,
            builder: (

                BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
            {
              if(!snapshot.hasData)
              {
                return Center(child: CircularProgressIndicator());
              }
              else if(snapshot.connectionState==ConnectionState.waiting)
              {
                return Center(child: Text("Please Wait"));
              }
              else{
                final data =snapshot.data!.docs;
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (
                        BuildContext context, int index)
                    {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          color: Colors.black,
                          child: ListTile(
                            title: Text(
                              data[index]['productName'],
                              style:
                              txtStyle.boldStyle
                                  .copyWith(color:Colors.white ),
                            ),
                            trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                              children: [

                                IconButton(
                                  onPressed: ()
                                  {

                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (_)=>CompleteUpdateScreen(
                                          ids:snapshot.data!.docs[index].id.toString(),
                                          product:Product(
                                            category:data[index]['Category'] ,
                                            id: data[index]['ID'] ,
                                            productName: data[index]['productName'] ,
                                            brand: data[index]['brand'] ,
                                            detail: data[index]['detail'] ,
                                            price:data[index]['price'] ,
                                            discountPrice:data[index]['discountPrice'] ,
                                            serialCode:data[index]['serialCode'] ,
                                            imageUrls:data[index]['imageUrls'] ,
                                            isOnSale:data[index]['isOnSale'] ,
                                            isPopular:data[index]['isPopular'] ,
                                            isFavourite:data[index]['isFavourite'],



                                          ),


                                        )
                                    )
                                    );
                                  },

                                  icon: Icon(Icons.edit,color: Colors.white,),

                                ),



                              ],
                            )


                          ),
                        ),
                      );

                    },),
                );
              }


            },)
        ],
      ),
    );
  }
}

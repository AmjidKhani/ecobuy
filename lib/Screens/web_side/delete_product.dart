import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Firebase%20Services/CRUD/CRUD.dart';
import 'package:ecobuy/Screens/web_side/admindashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DeleteProduct extends StatefulWidget {
  static const String id='DeleteProduct';
  @override
  State<DeleteProduct> createState() => _DeleteProductState();
}

class _DeleteProductState extends State<DeleteProduct>  {
  CollectionReference products=FirebaseFirestore.instance.collection('Products');
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          txtStyle.sh40,
          Center(child: Text("Delete Product Screen",style: txtStyle.boldStyle,)),

          txtStyle.sh40,
          StreamBuilder<QuerySnapshot>(
            stream:products.snapshots() ,
            builder: (

                BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot)
            {
              if(!snapshot.hasData)
              {
                return Center(child: CircularProgressIndicator(
                  color: Colors.black,
                ));
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
                                  IconButton(onPressed: (){
                                    CrudOperations.deleteProducts(data[index].id).then((value){
                                      Navigator.push(context, MaterialPageRoute(builder: (_)=>AdminDashBoard()));

                                    });

                                  }, icon: Icon(
                                      Icons.delete_forever,color: Colors.white
                                  )),




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

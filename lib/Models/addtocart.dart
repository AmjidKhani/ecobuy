import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:firebase_database/firebase_database.dart';

class Cart {
  String? id;
  String? ProductName;
  String? Image;
  var price;
  int? quantity;

  Cart({this.id, this.ProductName, this.Image, this.price, this.quantity});

  static  Future addToCart(Cart cart) async {
    try{
    CollectionReference firebaseFirestore =
        (await FirebaseFirestore.instance.collection('Cart'));
    Map<String, dynamic> data = {
      'ID': cart.id,
      'productName': cart.ProductName,
      'imageUrls': cart.Image,
      'price': cart.price,
      'Quantity': cart.quantity
    };
    await firebaseFirestore.add(data).whenComplete(() => {
      Utils.toastMessage("Data Successfully Added")
    }
    );
    }

    on FirebaseException catch(e){
      return Utils.toastMessage(e.toString());
    }
    catch(e){
      return Utils.toastMessage(e.toString());
    }

  }
}

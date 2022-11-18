import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Models/products_model.dart';
class CrudOperations {
  static Future<void> addProducts(Product product) async{
    CollectionReference firebaseFirestore =(await FirebaseFirestore.instance.collection('Products')) ;
  String  id=product.id.toString();
    Map<String, dynamic> data = {
      'Category': product.category,
      'ID': id,
      'productName': product.productName,
      'Brand':product.brand,
      'detail': product.detail,
      'price': product.price,
      'discountPrice': product.discountPrice,
      'serialCode': product.serialCode,
      'imageUrls': product.imageUrls,
      'isOnSale': product.isOnSale,
      'isPopular': product.isPopular,
      'isFavourite': product.isFavourite
    };
 await   firebaseFirestore.doc(product.id!).set(data);
  }
  static Future<void> updateProducts(String id,  Product updateProducts)async {
    CollectionReference Products =
    FirebaseFirestore.instance.collection('Products');
    Map<String, dynamic> data = {
      'Category': updateProducts.category,
      'ID': updateProducts.id,
      'productName': updateProducts.productName,
      'Brand':updateProducts.brand,
      'detail': updateProducts.detail,
      'price': updateProducts.price,
      'discountPrice': updateProducts.discountPrice,
      'serialCode': updateProducts.serialCode,
      'imageUrls': updateProducts.imageUrls,
      'isOnSale': updateProducts.isOnSale,
      'isPopular': updateProducts.isPopular,
      'isFavourite': updateProducts.isFavourite
    };
    Products.doc(id).update(data);
  }
  static Future<void> deleteProducts(String id)async{

    CollectionReference Products =
    FirebaseFirestore.instance.collection('Products');
    Products.doc(id).delete();
  }

}

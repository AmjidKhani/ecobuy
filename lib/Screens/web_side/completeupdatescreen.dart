import 'dart:io';
import 'package:ecobuy/Components/Widget/Round_Button.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
import 'package:ecobuy/Components/Widget/textfield.dart';
import 'package:ecobuy/Models/products_model.dart';
import 'package:ecobuy/Screens/web_side/admindashboard.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ecobuy/Firebase Services/CRUD/CRUD.dart';
import 'package:uuid/uuid.dart';

class CompleteUpdateScreen extends StatefulWidget {

 String? ids;
  Product? product;

  CompleteUpdateScreen(
      {
       required this.ids,
      required this.product});

  @override
  State<CompleteUpdateScreen> createState() => _AddProductState();
}

class _AddProductState extends State<CompleteUpdateScreen> {
  List<String> titles = [
    'Please Select Category',
    'Grocery',
    'Electronic',
    'Pharmacy',
    'Cloths',
    'Cosmetics',
    'Beauty',
    'Mart',
    'Fashion'
  ];
  TextEditingController productNameC = TextEditingController();
  TextEditingController detailC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountC = TextEditingController();
  TextEditingController serialCodeC = TextEditingController();
  TextEditingController brandC = TextEditingController();
  bool isOnSale = false;
  bool isPopular = false;
  bool isFavourite = false;
  bool loading = false;
  String selectedvalue = "Please Select Category";
  final pickimage = ImagePicker();
  List<XFile> images = [];
  String? urls;
  List<dynamic>? doenloadurls = [];
  var uuid = Uuid();

  pickimages() async {
    final List<XFile> pickimage = await ImagePicker().pickMultiImage();
    if (pickimage != null) {
      setState(() {
        images.addAll(pickimage);
      });
    } else {
      print("No Images Found");
    }
  }

  Future uploadingimage(XFile fileimages) async {
    Reference ref = await FirebaseStorage.instance
        .ref()
        .child(' Pharmacy Images')
        .child(fileimages.name);
    if (kIsWeb) {
      await ref.putData(await fileimages.readAsBytes());
      SettableMetadata(contentType: "image/jpeg");
    }
    urls = await ref.getDownloadURL();
    return urls;
  }
  Future updatedate() async {
    sendmultiimages().then((value) {
      setState(() {
      });
      CrudOperations.updateProducts(
          widget.ids.toString(),
          Product(
        category: selectedvalue,
        id: widget.ids,
        productName: productNameC.text,
            brand:brandC.text,
        detail: detailC.text,
        price: priceC.text,
        discountPrice: discountC.text,
        serialCode: serialCodeC.text,
        imageUrls: doenloadurls,
        isOnSale: isOnSale,
        isPopular: isPopular,
        isFavourite: isFavourite,

      )).then((value) {
        Utils.toastMessage("Successfuly Added Data");
        Navigator.push(context, MaterialPageRoute(builder: (_)=>AdminDashBoard()));
        setState(() {
          loading = false;
       //   images.clear();
          //doenloadurls!.clear();
        });
      }).onError((error, stackTrace) {
        Utils.toastMessage(error.toString());
        setState(() {
          loading = false;
        });
      });
    });
  }
  Future sendmultiimages() async {
    if (images.isNotEmpty) {
      setState(() {
        loading = true;
      });
      for (var image in images) {
        await uploadingimage(image).then((urls) {
          doenloadurls?.add(urls);
          print('checking');

          print(doenloadurls);
doenloadurls!.addAll(widget.product!.imageUrls!);
       //   widget.product!.imageUrls!.addAll(doenloadurls!);
          print('checking all list');
          print( widget.product!.imageUrls);
        }).onError((error, stackTrace) {
          setState(() {
            loading = false;
            print("error during execution");
          });
          Utils.toastMessage('error found ');
        });
      }
    } else {
      Utils.toastMessage("Please Select a Products");
      setState(() {
        loading = false;
      });
    }
  }
  @override
  void initState() {
    selectedvalue = widget.product!.category!;
    productNameC.text = widget.product!.productName!;
    brandC.text=widget.product!.brand!;
    detailC.text = widget.product!.detail!;
    priceC.text = widget.product!.price!;
    discountC.text = widget.product!.discountPrice!;
    serialCodeC.text = widget.product!.serialCode!;
    doenloadurls = widget.product!.imageUrls!.cast<String>();
    isOnSale = widget.product!.isOnSale!;
    isPopular = widget.product!.isPopular!;
    isFavourite = widget.product!.isFavourite!;
    super.initState();
    // TODO: implement initState
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            txtStyle.sh20,
            Text(
              "Update  Products ",
              style: txtStyle.boldStyle,
            ),
            txtStyle.sh10,
            Container(
              margin: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.r)),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      hintText: 'Please Enter Category',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 5.h, vertical: 5.w),
                      border: InputBorder.none),
                  validator: (value) {
                    if (value == null) {
                      return 'Category Must be Selectd';
                    } else {
                      return null;
                    }
                  },
                  value: selectedvalue,
                  items: titles.map((e) {
                    return DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedvalue = value.toString();
                    });
                  }),
            ),
            txtStyle.sh10,
            textfield(
              label: 'Please Enter Product Name....',
              contoller: productNameC,
            ),
            textfield(
              label: 'Please Enter Brand Name....',
              contoller: brandC,
            ),
            textfield(
              label: 'Please Enter Product Detail....',
              contoller: detailC,
              maxLine: 5,
            ),
            textfield(
              label: 'Please Enter Product price....',
              contoller: priceC,
            ),
            textfield(
              label: 'Please Enter Product Discount....',
              contoller: discountC,
            ),
            textfield(
              label: 'Please Enter Product Serial Code....',
              contoller: serialCodeC,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: SwitchListTile(
                  title: const Text("Is This Product is on onSale"),
                  value: isOnSale,
                  onChanged: (v) {
                    setState(() {
                      isOnSale = !isOnSale;
                    });
                  }),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
              child: SwitchListTile(
                  title: const Text("Is This Product is Popluar"),
                  value: isPopular,
                  onChanged: (v) {
                    setState(() {
                      isPopular = !isPopular;
                    });
                  }),
            ),
            txtStyle.sh10,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                      physics:BouncingScrollPhysics(),
                      itemCount:widget.product!.imageUrls!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8,

                      ),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Image.network(
                                  widget.product!.imageUrls![index],
                                  fit: BoxFit.cover,
                                ),
                                height: 100,
                                width: 140,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black)),
                              ),
                            ),
                            Positioned(
                              right: 92,
                              bottom: 93,
                              child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    widget.product!.imageUrls!.removeAt(index);
                                  });
                                },
                                icon: Icon(Icons.highlight_remove),
                              ),
                            ),
                          ],
                        );
                      }),
                ),
              ),
            ),
            txtStyle.sh10,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                ),
                height: 150,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(

                      itemCount: images.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 8),
                      itemBuilder: (context, index) {
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                child: Image.network(
                                  File(images[index].path).path,
                                  fit: BoxFit.cover,
                                ),
                                height: 100,
                                width: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black)),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  images.removeAt(index);
                                });
                              },
                              icon: Icon(Icons.highlight_remove),
                            )
                          ],
                        );
                      }),
                ),
              ),
            ),
            Round_Button(
              text: 'Pick Images',
              OnPressed: () {
                pickimages();
              },
            ),
            txtStyle.sh10,
            Round_Button(
              Loading: loading,
              text: 'Upload Images',
              OnPressed: () {
                updatedate();
              },
            ),
            txtStyle.sh40,
          ],
        ),
      ),
    );
  }
}

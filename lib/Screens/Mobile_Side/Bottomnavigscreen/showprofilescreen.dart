import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/Round_Button.dart';
import 'package:ecobuy/Components/Widget/appheader.dart';
import 'package:ecobuy/Components/Widget/textfield.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ShowProfileScreen extends StatefulWidget {
  const ShowProfileScreen({Key? key}) : super(key: key);
  @override
  State<ShowProfileScreen> createState() => _ShowProfileScreenState();
}
class _ShowProfileScreenState extends State<ShowProfileScreen> {
  bool PicImageOrNot=false;
Future  GetData()async{
  FirebaseFirestore.instance
       .collection('Profile').doc(FirebaseAuth.
  instance.currentUser!.uid).get().then((DocumentSnapshot<Map<String, dynamic>> snapshot) {
    NameC.text=snapshot['Name'];
    PhoneC.text=snapshot['PhoneNo'];
    CityC.text=snapshot['City'];
    AddressC.text=snapshot['Address'];
    profilepic=snapshot['ProfilePic'];
  });
}
  @override
  final formkey = GlobalKey<FormState>();
  bool isLoading = false;
  TextEditingController NameC = TextEditingController();
  TextEditingController PhoneC = TextEditingController();
  TextEditingController CityC = TextEditingController();
  TextEditingController AddressC = TextEditingController();
  String? profilepic;

  PickImages() async {
    final XFile? pickImage = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickImage != null) {
      setState(() {
        profilepic = pickImage.path;
        PicImageOrNot=true;
      });
    }
  }
 String? downloadurl;
  Future<String?> UploadProfileImage(File filepath, String refrence) async {
  if(
  PicImageOrNot==true)
  {
    print(PicImageOrNot);
    try {
      final finalName = '${DateTime.now().second.toString()}';

      final Reference fbStorage =
      FirebaseStorage.instance.ref(refrence).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadurl = await fbStorage.getDownloadURL();
      }).whenComplete(() => {

        FirebaseFirestore.instance.collection('Profile').


        doc(FirebaseAuth.instance.currentUser!.uid).update({
          'ProfilePic': downloadurl,
          'Name': NameC.text.toString(),
          'PhoneNo': PhoneC.text.toString(),
          'City': CityC.text.toString(),
          'Address': AddressC.text.toString(),

        }).then((value) {
          setState(() {
            isLoading=false;

          });
          Utils.toastMessage("Data Update Successfully");
        }),
      });
      return downloadurl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  else{
    print('Else condition runing kr rhi h');
    print(PicImageOrNot);
    FirebaseFirestore.instance.collection('Profile').
    doc(FirebaseAuth.instance.currentUser!.uid).update({
      'Name': NameC.text.toString(),
          'PhoneNo': PhoneC.text.toString(),
          'City': CityC.text.toString(),
          'Address': AddressC.text.toString(),

        }).onError((error, stackTrace){
          Utils.toastMessage(error.toString());
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      Utils.toastMessage("Data Update Successfully");
    });
  }
  return null;


}
@override
  void initState() {

      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (FirebaseAuth.instance.currentUser!.displayName==null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Please Complete Profile Firstly")));
        }else{
          GetData();

        }
      });
      super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Appheader(title: 'Profile Screen')),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  PickImages();
                },
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  backgroundImage: profilepic == null
                      ? AssetImage(
                    'assets/c_images/profileedit.png',
                  ):profilepic!.contains('http')?NetworkImage(profilepic!)
                      : FileImage(File(profilepic!)) as ImageProvider,
                  radius: 70,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              textfield(
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Please Enter Name';
                  }
                  return null;
                },
                label: 'Please Enter Your Name',
                contoller: NameC,
              ),
              textfield(
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Please Enter Phone no';
                  }
                  return null;
                },
                label: 'Please Enter Your Phone No',
                contoller: PhoneC,
              ),
              textfield(
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Please Enter City';
                  }
                  return null;
                },
                label: 'Please Enter Your City',
                contoller: CityC,
              ),
              textfield(
                validate: (v) {
                  if (v!.isEmpty) {
                    return 'Please Enter Address';
                  }
                  return null;
                },
                label: 'Please Enter Your Address',
                contoller: AddressC,
              ),
              SizedBox(
                height: 20,
              ),
              Round_Button(
                  Loading: isLoading,
                  text: 'Update',
                  OnPressed: () {
                    setState(() {});
                    formkey.currentState!.validate();

                    setState(() {
                        isLoading = true;
                      });
                      UploadProfileImage(File(profilepic!),'profilepdf');
                      // UploadProfileImage(File(profilepic!), 'profilepdf')
                      //     .then((value) {
                      //   SaveProfile().whenComplete(() {
                      //     setState(() {
                      //       isLoading = false;
                      //     });
                      //   });
                      // }
                      // );

                  })
            ],
          ),
        ),
      ),
    );
  }
}

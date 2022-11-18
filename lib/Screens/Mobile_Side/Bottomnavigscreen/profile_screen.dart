import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Components/Widget/Round_Button.dart';
import 'package:ecobuy/Components/Widget/appheader.dart';
import 'package:ecobuy/Components/Widget/textfield.dart';
import 'package:ecobuy/Firebase%20Services/Authentications.dart';
import 'package:ecobuy/Firebase%20Services/all_variables.dart';
import 'package:ecobuy/Utils/util.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
      });
    }
  }

  late String downloadurl;
  late String download;

  Future<String?> UploadProfileImage(File filepath, String refrence) async {
    try {
      final finalName = '${DateTime.now().second.toString()}';

      final Reference fbStorage =
          FirebaseStorage.instance.ref(refrence).child(finalName);
      final UploadTask uploadTask = fbStorage.putFile(filepath);
      await uploadTask.whenComplete(() async {
        downloadurl = await fbStorage.getDownloadURL();
      });
      return downloadurl;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future SaveProfile() async {
    Map<String, dynamic> data = {
      'ProfilePic': downloadurl,
      'Name': NameC.text.toString(),
      'PhoneNo': PhoneC.text.toString(),
      'City': CityC.text.toString(),
      'Address': AddressC.text.toString(),
    };
    FirebaseFirestore.instance.collection('Profile').
    doc(FirebaseAuth.instance.currentUser!.uid).set(data).whenComplete(() {
      FirebaseAuth.instance.currentUser!.updateDisplayName(NameC.text);
    }).onError((error, stackTrace) {
      Utils.toastMessage(error.toString());
    });

  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (FirebaseAuth.instance.currentUser!.displayName==null) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Please Complete Profile Firstly")));
      }

    });
    super.initState();
  }
  @override
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
                        )
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
                  text: 'Save',
                  OnPressed: () {
                    setState(() {});
                    formkey.currentState!.validate();
                    if (profilepic == null) {
                      Utils.toastMessage("pLease Add Profile Image");
                    } else {
                      setState(() {
                        isLoading = true;
                      });
                      UploadProfileImage(File(profilepic!), 'profilepdf')
                          .then((value) {
                        SaveProfile().whenComplete(() {
                          setState(() {
                            isLoading = false;
                          });
                        });
                      });
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

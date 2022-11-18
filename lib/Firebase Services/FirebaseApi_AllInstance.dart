import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Firebase_Instance
{
static FirebaseAuth auth=FirebaseAuth.instance;
 static FirebaseFirestore  firebaseFirestore=FirebaseFirestore.instance;

}

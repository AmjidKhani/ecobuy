import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/bottomnavigationbar.dart';
import 'package:ecobuy/Screens/Mobile_Side/layoutscreen.dart';
import 'package:ecobuy/Screens/mobile_side/home_screen.dart';
import 'package:ecobuy/Screens/mobile_side/landing_screen.dart';
import 'package:ecobuy/Screens/web_side/add_products.dart';
import 'package:ecobuy/Screens/web_side/dashboardscreen.dart';
import 'package:ecobuy/Screens/web_side/delete_product.dart';
import 'package:ecobuy/Screens/web_side/update_product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/showprofilescreen.dart';
void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    print('web .... ha');
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyD3pVvPuEDbP7i2x_yEKi5sTFjCwlTZZY8",
            authDomain: "ecobuy-d4aff.firebaseapp.com",
            projectId: "ecobuy-d4aff",
            storageBucket: "ecobuy-d4aff.appspot.com",
            messagingSenderId: "594838625847",
            appId: "1:594838625847:web:d664db0940f0ae8f0769b2",
            measurementId: "G-T8LT8STP74"));
  }
  else {
    print('web ..nhi . ha');
    Firebase.initializeApp();

  }
  runApp(ScreenUtilInit(

    designSize: const Size(393, 826),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (BuildContext context, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyApp(),
      );
    },
  ));
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:
     // ShowProfileScreen(),
     LayoutScreen(),
      //BottomNavigation(),

      //HomeScreen(),
   //  LandingScreen(),
      //AddProduct(),
     // UpdateProduct(),
      //AdminDashBoard(),
      routes: {
        DashBoardScreen.id:(context)=>   DashBoardScreen(),
        AddProduct.id:(context)=>   AddProduct(),
        DeleteProduct.id:(context)=>  DeleteProduct(),
        UpdateProduct.id:(context)=>   UpdateProduct(),
        //CompleteUpdateScreen.id:(context)=>   CompleteUpdateScreen(),
      },
    );
  }
}

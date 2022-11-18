import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/favourite_screen.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/profile_screen.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/showprofilescreen.dart';
import 'package:ecobuy/Screens/Mobile_Side/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/product_screen.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/Cart_Screen.dart';
import 'package:ecobuy/Screens/Mobile_Side/Bottomnavigscreen/Checkingscreen.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  var length=0;
  getCart()async{
   await FirebaseFirestore.instance.collection("Cart").get().then((snapshot)  {


     setState(() {
       length=snapshot.docs.length;
     });
    });
  }
  @override
  void initState() {
    getCart();
    // TODO: implement initState
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    getCart();
    print(length);
    return CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shop),
            ),
            BottomNavigationBarItem(
              icon: Stack(
                children: [

                  Icon(
                    Icons.add_shopping_cart,
                    //   color: Colors.blue,
                  ),
                  Positioned(
                    left: 12,
                    bottom: 12,
                    child: length==0?Container():

                    Icon(
                      Icons.brightness_1,
                      color: Colors.green,
                      size: 20,
                    ),
                  ),
                  Positioned(
                    left: 19,
                    bottom: 16,
                    child:  length==0?Container():
                    Text(
                      length.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.security),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
            ),
          ],
        ),
        tabBuilder: (BuildContext context, index) {
          switch (index) {
            case 0:
              return CupertinoTabView(
                builder: ((context) {
                  return CupertinoPageScaffold(child: HomeScreen());
                }),
              );
            case 1:
              return CupertinoTabView(
                builder: ((context) {
                  return CupertinoPageScaffold(
                      child: Product_Screen(
                    category: null,
                  ));
                }),
              );
            case 2:
              return CupertinoTabView(
                builder: ((context) {
                  return CupertinoPageScaffold(child: Cart_Screen());
                }),
              );
            case 3:
              return CupertinoTabView(
                builder: ((context) {
                  return CupertinoPageScaffold(child: Favourite_Screen());
                }),
              );

            case 4:
              if (FirebaseAuth.instance.currentUser!.displayName==null) {
                return CupertinoTabView(
                  builder: ((context) {
                    return CupertinoPageScaffold(child: ProfileScreen());
                  }),
                );
              }
              return CupertinoTabView(
                builder: ((context) {
                  return CupertinoPageScaffold(child:
                 // CheckingScreen()
                  ShowProfileScreen(),
                  );
                }),
              );


            case 5:
              return CupertinoTabView(
                builder: ((context) {
                  return CupertinoPageScaffold(child: ProfileScreen());
                }),
              );

            default:
          }
          return
              //Favourite_Screen();
              HomeScreen();
        });
  }
}

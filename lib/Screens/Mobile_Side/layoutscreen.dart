
import 'package:ecobuy/Screens/mobile_side/landing_screen.dart';
import 'package:ecobuy/Screens/web_side/admindashboard.dart';
import 'package:ecobuy/Screens/web_side/web_login.dart';
import 'package:flutter/cupertino.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (
          BuildContext , BoxConstraints ) {

        if(BoxConstraints.minWidth>600)
        {
         return AdminDashBoard();
           //WebLogin();

        }

        else{
          return LandingScreen();
        }
      },
    );
  }
}

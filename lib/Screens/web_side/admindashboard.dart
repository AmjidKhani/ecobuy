import 'package:ecobuy/Screens/web_side/add_products.dart';
import 'package:ecobuy/Screens/web_side/dashboardscreen.dart';
import 'package:ecobuy/Screens/web_side/delete_product.dart';
import 'package:ecobuy/Screens/web_side/update_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
class AdminDashBoard extends StatefulWidget {
  static const String id = 'AdminDashBoard';
  const AdminDashBoard({super.key});
  @override
  State<AdminDashBoard> createState() => _AdminDashBoardState();
}
class _AdminDashBoardState extends State<AdminDashBoard> {
  Widget selectedscreen = const DashBoardScreen();
  chooseScreen(item) {
    switch (item) {
      case DashBoardScreen.id:
        setState(() {
          selectedscreen =  DashBoardScreen();
        });
        break;
        case AddProduct.id:
        setState(() {
          selectedscreen = AddProduct();
        });
        break;

      case UpdateProduct.id:
        setState(() {
          selectedscreen = UpdateProduct();
        });
        break;
      case DeleteProduct.id:
        setState(() {
          selectedscreen = DeleteProduct();
        });
        break;

        default:
          if (kDebugMode) {
            print("Hello");
          }
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      sideBar: SideBar(

        onSelected: (item) {
          chooseScreen(item.route);

        },
        items:const  [
          AdminMenuItem(
route:DashBoardScreen.id ,
              title: 'Dashboard',
              icon: Icons.dashboard
          ),
          AdminMenuItem(
route:AddProduct.id,
              title: 'Add Products',
              icon: Icons.add
          ),
          AdminMenuItem(

              route: UpdateProduct.id,
             title: 'Update Products',
              icon: Icons.update),

          AdminMenuItem(
              route:  DeleteProduct.id,
              title: 'Delete Products', icon: Icons.delete

          ),

        ],
        selectedRoute: DashBoardScreen.id,
      ),
      body:
      //Text(""),
      selectedscreen,
    );
  }
}

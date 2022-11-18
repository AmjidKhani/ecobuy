import 'package:ecobuy/Screens/mobile_side/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopularItem extends StatefulWidget {
  const PopularItem({Key? key}) : super(key: key);

  @override
  State<PopularItem> createState() => _PopularItemState();
}

class _PopularItemState extends State<PopularItem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
          children: [
            Container(
              height: 220,
              width: 1200,
              child:   ListView.builder(
                itemCount:productsData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (
                    BuildContext context, int index)
                {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 140,
                          width: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.black,width: 2
                              )
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(productsData[index].imageUrls![0],


                                  ),
                                  fit: BoxFit.cover,

                                ),


                              ),
                            ),
                          ),
                        ),
                      ),
                      Text(productsData[index].productName.toString()),
                    ],
                  );
                },),
            ),
          ],
    )

    );
  }
}

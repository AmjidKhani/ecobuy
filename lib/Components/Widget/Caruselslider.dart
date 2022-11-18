import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecobuy/Components/Widget/boldtext.dart';
class coruselslider extends StatelessWidget {
  const coruselslider({
    Key? key,
    required this.images,
  }) : super(key: key);

  final List images;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      CarouselSlider(
        items: images.map((e) {
          return Stack(
            children: [
              Padding(
                padding:
                EdgeInsets.only(left: 8.w, right: 8, top: 8, bottom: 8),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: Image.network(
                      e,
                      fit: BoxFit.fill,
                    )),
              ),
              Positioned(
                bottom: 20.h,
                left: 20.w,
                child: Container(
                  child: Text(
                    "Title",
                    style: txtStyle.boldStyle.copyWith(color: Colors.black),
                  ),
                ),
              ),
            ],
          );
        }).toList(),
        options: CarouselOptions(autoPlay: true, height: 200.h),
      ),
      CarouselSlider(
        options: CarouselOptions(autoPlay: true, height: 200.h),
        items: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Container(
              width: 280,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  gradient: LinearGradient(colors: [
                    Colors.red.withOpacity(0.05),
                    Colors.green.withOpacity(0.05),
                  ])),
            ),
          ),
        ],
      ),
    ]);
  }
}
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductController extends GetxController{
var getname= Get.arguments;

    // final imagePath = selectedItem?['image'] ?? '';
    // final name = selectedItem?['name'] ?? 'Unnamed';

  final TextEditingController searchController1=TextEditingController();
  RxInt currentIndex = 0.obs;
  RxList<String> imageUrls = <String>[
    'assets/images/picearring.jpg',
    'assets/images/tanishqneck2.webp',
     'assets/images/picearring1.jpg',
    'assets/images/picerarneck.webp',
  ].obs;
  List<String> servicetext=['Free Shipping','Supported 24/7','Money Return','Security'];
  List<Map<String,dynamic>> itemdetails=[{'image':'assets/images/tanishqear.webp','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/picerarneck.webp','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/picnecklace1.jpg','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/picearring.jpg','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},];
   CarouselSliderController sliderCarouselController = CarouselSliderController();
   
} 
 
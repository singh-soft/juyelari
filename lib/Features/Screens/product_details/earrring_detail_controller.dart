import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EarrringDetailController extends GetxController{
var getname= Get.arguments;

    // final imagePath = selectedItem?['image'] ?? '';
    // final name = selectedItem?['name'] ?? 'Unnamed';

  final TextEditingController searchController1=TextEditingController();
  RxInt currentIndex = 0.obs;
  RxList<String> imageUrls = <String>[
    'assets/images/jewelleryjustfor.png',
    'assets/images/jewelleryjustfor.png',
     'assets/images/dashgoldring.png',
    'assets/images/jewelleryjustfor.png',
  ].obs;
  List<String> servicetext=['Free Shipping','Supported 24/7','Money Return','Security'];
  List<Map<String,dynamic>> itemdetails=[{'image':'assets/images/earringjumka.png','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/jumka1.png','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/earringjumka.png','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/earringjumka.png','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},];
   CarouselSliderController sliderCarouselController = CarouselSliderController();
   
} 
 
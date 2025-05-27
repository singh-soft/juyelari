import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  
  RxInt currentIndex = 0.obs;
  RxList<String> imageUrls = <String>[
    'assets/images/dashgoldring.png',
    'assets/images/dashgoldearring.png',
     'assets/images/dashgoldring.png',
    'assets/images/dashgoldearring.png',
  ].obs;
  List<Map<String,dynamic>> listimage=[
    {'image':"assets/images/ringpic.png","name":"Ring","index":0},
    {"image":"assets/images/thumbring.png","name":"Ring","index":1},
    {"image":"assets/images/necklacepic.png","name":"Necklace","index":2},
    {"image":"assets/images/thumbring.png","name":"Bracelet","index":3},
    {"image":"assets/images/earringpic.png","name":"Earrings","index":4},
    ];
    List<Map<String,dynamic>> gridimage=[
    {'image':"assets/images/dashgoldearring.png","name":"Ringfgfhhhhhhhhhhhhhhhhhhhhhhhhhhhhh"},
    {"image":"assets/images/dashgoldchain.png","name":"Ring"},
    {"image":"assets/images/dashgoldchain.png","name":"Necklace"},
    {"image":"assets/images/dashgoldring.png","name":"Ring"},
    {"image":"assets/images/dashgoldring.png","name":"Ring"},
     {"image":"assets/images/dashgoldring.png","name":"Ring"},
    
    ];

  CarouselSliderController sliderCarouselController = CarouselSliderController();

}

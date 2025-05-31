import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DashboardController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  
  RxInt currentIndex = 0.obs;
  RxList<String> imageUrls = <String>[
    'assets/images/tanishqear.webp',
    'assets/images/tanishq2.webp',
     'assets/images/tanishqneck1.webp',
    'assets/images/tanishqring2.webp',
  ].obs;
  List<Map<String,dynamic>> listimage=[
    {'image':"assets/images/tanishqear.webp","name":"Earring","index":0},
    {"image":"assets/images/tanishqring2.webp","name":"Diamond","index":1},
    {"image":"assets/images/tanishqneck2.webp","name":"Necklace","index":2},
    {"image":"assets/images/thumbring.png","name":"Bracelet","index":3},
    {"image":"assets/images/earringpic.png","name":"Earrings","index":4},
    ];
    List<Map<String,dynamic>> gridimage=[
    {'image':"assets/images/tanishqear.webp","name":"Ring"},
    {"image":"assets/images/tanishqear1.webp","name":"Earring"},
    {"image":"assets/images/tanishqear1.webp","name":"Necklace"},
    {"image":"assets/images/tanishqring1.webp","name":"Ring"},
    {"image":"assets/images/tanishqring2.webp","name":"Diamond Ring"},
     {"image":"assets/images/tanishqear.webp","name":" Diamond Ring"},
      {"image":"assets/images/tanishqneck2.webp","name":"Pendant"},
       {"image":"assets/images/tanishqneck2.webp","name":"Pendant"},
    
    ];

  CarouselSliderController sliderCarouselController = CarouselSliderController();

}

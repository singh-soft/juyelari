import 'package:get/get.dart';

class MyCartController extends GetxController{
  final List<String> address=['32 mohan Nagar samudhayak kendra','22 sundar marg bhrampuri jaipur','12, opposite patel marng new sanganer road' ];
   final selectedCity = 'Mumbai'.obs;

  void updateCity(String value) {
    selectedCity.value = value;
  }
   final List<Map<String, String>> products = [
    {
      'title': 'Classic Gold Bangle with Leaf Design',
      'price': '₹ 1749',
      'image': 'assets/images/necklacepic.png',
      'size': 'Free Size',
      'qty': '1',
      'return': 'All Issue easy returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/thumbring.png',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/picjumka.jpg',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
    {
      'title': 'Gold Ring Elegant Style',
      'price': '₹ 899',
      'image': 'assets/images/picjumka.jpg',
      'size': '6',
      'qty': '1',
      'return': '7-Day Returns'
    },
  ];
}
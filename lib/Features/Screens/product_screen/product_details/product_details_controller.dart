import 'package:get/get.dart';

class ProductDetailsController extends GetxController{
  var getimage=Get.arguments;
  var gettitle=Get.arguments;
  RxBool showAllReviews = false.obs;

  void toggleReviews() {
    showAllReviews.value = !showAllReviews.value;
  }
   List<Map<String,dynamic>> similaritemdetails=[{'image':'assets/images/tanishqear.webp','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/picerarneck.webp','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/picnecklace1.jpg','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},
  {'image':'assets/images/picearring.jpg','title':"Radiant Geometric Diamond Stud Earrings ","rating":"4.2","rate":'1799'},];
}
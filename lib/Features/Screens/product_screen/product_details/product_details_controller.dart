import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class ProductDetailsController extends GetxController {
  RxList multipleImage = [].obs;
  var getimage = Get.arguments;
  var gettitle = Get.arguments;
  var getProductId = Get.arguments;
  var allData={}.obs;
  final staticAnchorKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;

    print(getProductId);
  }

  RxBool showAllReviews = false.obs;

  void toggleReviews() {
    showAllReviews.value = !showAllReviews.value;
  }

  List<Map<String, dynamic>> similaritemdetails = [
    {
      'image': 'assets/images/tanishqear.webp',
      'title': "Radiant Geometric Diamond Stud Earrings ",
      "rating": "4.2",
      "rate": '1799'
    },
    {
      'image': 'assets/images/picerarneck.webp',
      'title': "Radiant Geometric Diamond Stud Earrings ",
      "rating": "4.2",
      "rate": '1799'
    },
    {
      'image': 'assets/images/picnecklace1.jpg',
      'title': "Radiant Geometric Diamond Stud Earrings ",
      "rating": "4.2",
      "rate": '1799'
    },
    {
      'image': 'assets/images/picearring.jpg',
      'title': "Radiant Geometric Diamond Stud Earrings ",
      "rating": "4.2",
      "rate": '1799'
    },
  ];
  void productDetailsApi() async {
    try {
      Map<String, dynamic> data = {
        "product_id": getProductId
       
      };

      var response =
          await ApiProvider().postRequest(apiUrl: '/product-details',data: data);
          print(response.toString());
      if (response['success'] == true && response['data'] != null) {
         allData.value = response['data'];
         multipleImage.assignAll(List.from(response['data']['multi_images']));

          CustomWidgets().toast(response['message'], Colors.green);
        // isLoading.value=false;
      }
      else{
         CustomWidgets().toast(response['message'], Colors.red);
      }
    } catch (e) {}
  }
}

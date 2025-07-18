import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';
import 'package:juyelari/Features/provider/auth.dart';

class DashboardController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> brands = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> sliders = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> coupons = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> featuredProduct = <Map<String, dynamic>>[].obs;
  RxMap<String, dynamic> dashboardData = <String, dynamic>{}.obs;
  var favouriteMap = <int, RxBool>{}.obs;
  RxInt currentIndex = 0.obs;
  RxInt currentIndex1 = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isFavourite = false.obs;

  CarouselSliderController sliderCarouselController =
      CarouselSliderController();

  CarouselSliderController sliderCarouselController1 =
      CarouselSliderController();
  void dashboardApi() async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "user_id": userId(),
      };

      var response =
          await ApiProvider().postRequest(apiUrl: 'dashboard', data: data);

      if (response['status'] == true && response['data'] != null) {
        final data = response['data'];
        dashboardData.value = data;

        categories.assignAll(
            List<Map<String, dynamic>>.from(data['categories'] ?? []));
        sliders
            .assignAll(List<Map<String, dynamic>>.from(data['sliders'] ?? []));
        brands.assignAll(List<Map<String, dynamic>>.from(data['brands'] ?? []));
        featuredProduct
            .assignAll(List<Map<String, dynamic>>.from(data['products'] ?? []));
       for (var product in featuredProduct) {
        int productId = int.tryParse(product['id'].toString()) ?? 0;
        int isWishlist = int.tryParse(product['is_wishlist'].toString()) ?? 0;
        favouriteMap[productId] = (isWishlist == 1).obs;
      }
        CustomWidgets().toast(response['message'], Colors.green);
        isLoading.value = false;
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
        isLoading.value = false;
      }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets()
          .toast("Request time out, Please try again later", Colors.red);
    } catch (e) {
      CustomWidgets()
          .toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      isLoading.value = false;
    }
  }

void addtofavourite(int productId) async {
  try {
    isLoading.value = true;
    final bool previousValue = favouriteMap[productId]?.value ?? false;
    favouriteMap[productId] = (!previousValue).obs;
    print("Previous Value: $previousValue");

    Map<String, dynamic> data = {
      "product_id": productId,
      "is_like": !previousValue ? 1 : 0, 
    };
    print("Data to send: $data");
    var response = await ApiProvider().postRequest(
      apiUrl: 'wishlist',
      data: data,
    );

    if (response['status'] == true) {
      dashboardApi();
      CustomWidgets().toast(response['message'], Colors.green);
    } else {
      favouriteMap[productId] = previousValue.obs;
      CustomWidgets().toast(response['message'], Colors.red);
    }
  } on SocketException {
    CustomWidgets().toast("No Internet Connection", Colors.red);
  } on TimeoutException {
    CustomWidgets().toast("Request timed out. Please try again.", Colors.red);
  } catch (e) {
    favouriteMap[productId] = (favouriteMap[productId]?.value ?? false).obs; 
    CustomWidgets().toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
  } finally {
    isLoading.value = false;
  }
}



void toggleFavourite(int productId) {
  addtofavourite(productId);
}
}

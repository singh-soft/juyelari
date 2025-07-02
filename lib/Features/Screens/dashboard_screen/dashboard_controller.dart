import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class DashboardController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> brands = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> sliders = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> coupons = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> featuredProduct = <Map<String, dynamic>>[].obs;
  RxMap<String, dynamic> dashboardData = <String, dynamic>{}.obs;
  RxInt currentIndex = 0.obs;
  RxInt currentIndex1 = 0.obs;
  RxBool isLoading = false.obs;

  CarouselSliderController sliderCarouselController =
      CarouselSliderController();

  CarouselSliderController sliderCarouselController1 =
      CarouselSliderController();
  void dashboardApi() async {
    try {
      isLoading.value = true;
      var response = await ApiProvider().postRequest(apiUrl: 'dashboard');

      if (response['success'] == true && response['data'] != null) {
        final data = response['data'];
        dashboardData.value = data;

        categories.assignAll(
            List<Map<String, dynamic>>.from(data['categories'] ?? []));
        sliders
            .assignAll(List<Map<String, dynamic>>.from(data['sliders'] ?? []));
        brands.assignAll(List<Map<String, dynamic>>.from(data['brands'] ?? []));
        featuredProduct
            .assignAll(List<Map<String, dynamic>>.from(data['products'] ?? []));

        CustomWidgets().toast(response['message'], Colors.green);
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
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
}

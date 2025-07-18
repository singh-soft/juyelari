
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class AllProductController extends GetxController {
  final RxMap<int, RxBool> favouriteMap = <int, RxBool>{}.obs;
   RxBool isLoading = false.obs;
  RxBool isFavourite = false.obs;



void addtofavourite(int productId) async {
  try {
    isLoading.value = true;
    final bool previousValue = favouriteMap[productId]?.value ?? false;
    favouriteMap[productId] = (!previousValue).obs;

    Map<String, dynamic> data = {
      "product_id": productId,
      "is_like": !previousValue ? 0 : 1, 
    };
    var response = await ApiProvider().postRequest(
      apiUrl: 'wishlist',
      data: data,
    );

    if (response['status'] == true) {
      // dashboardApi();
      isFavourite.value = !previousValue;
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
    if (!favouriteMap.containsKey(productId)) {
      favouriteMap[productId] = false.obs;
    }
    favouriteMap[productId]!.value = !favouriteMap[productId]!.value;
    addtofavourite(productId);
  }
}
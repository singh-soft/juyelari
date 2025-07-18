import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class FavouriteController extends GetxController {
  RxList<Map<String, dynamic>> favouriteProducts = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  var favouriteMap = <int, RxBool>{}.obs;
  RxBool isFavourite = false.obs;

  Future<void> fetchFavouriteProducts() async {
    try {
      isLoading.value = true;
      var response = await ApiProvider().getRequest(apiUrl: 'wishlist-list');
      if (response['status'] == true && response['data'] != null) {
        favouriteProducts.value = List<Map<String, dynamic>>.from(response['data']);
        for (var product in favouriteProducts) {
          final id = product['product_id'];
          favouriteMap[id] = true.obs;
        }
      } else {
        favouriteProducts.clear();
        favouriteMap.clear();
      }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Get.context);
      favouriteProducts.clear();
      favouriteMap.clear();
    } on TimeoutException {
      CustomWidgets().toast("Request time out, Please try again later", Get.context);
      favouriteProducts.clear();
      favouriteMap.clear();
    } catch (e) {
      favouriteProducts.clear();
      favouriteMap.clear();
    } finally {
      isLoading.value = false;
    }
  }


void addtofavourite(product) async {
    try {
      isLoading.value = true;
      // Toggle favourite state
      isFavourite.value = !isFavourite.value;
      Map<String, dynamic> data = {
        "product_id": product,
        "is_like": isFavourite.value ? "1" : "0",
      };
      print("dddddddddddddddddd $data");
      var response =
          await ApiProvider().postRequest(apiUrl: 'wishlist', data: data);
      print(response);
      if (response['status'] == true) {
        CustomWidgets().toast(response['message'], Colors.green);
        isLoading.value = false;
      } else {
        // If failed, revert favourite state
        isFavourite.value = !isFavourite.value;
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

  void toggleFavourite(int productId) {
    if (!favouriteMap.containsKey(productId)) {
      favouriteMap[productId] = true.obs;
    }
    favouriteMap[productId]!.value = !favouriteMap[productId]!.value;
    addtofavourite(productId);
  }
}

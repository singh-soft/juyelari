import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';
import 'package:juyelari/Features/provider/auth.dart';

class ProductController extends GetxController {
  RxInt selectedFilterIndex = (-1).obs;
  RxString selectedMinPrice = ''.obs;
  RxString selectedMaxPrice = ''.obs;
  RxList<Map<String, dynamic>> products = <Map<String, dynamic>>[].obs;
  RxInt currentPage = 1.obs;
  RxBool isProductLoading = false.obs;
  RxBool hasMoreProducts = true.obs;
   var favouriteMap = <int, RxBool>{}.obs;

  Map<String, dynamic>? categoryData;

  @override
  void onInit() {
    super.onInit();
    categoryData = Get.arguments;
    fetchFilterRanges();
    fetchProducts();
  }
  var getname = Get.arguments;

  // final imagePath = selectedItem?['image'] ?? '';
  // final name = selectedItem?['name'] ?? 'Unnamed';

  final TextEditingController searchController1 = TextEditingController();
  RxInt currentIndex = 0.obs;
  RxList<String> imageUrls = <String>[
    'assets/images/picearring.jpg',
    'assets/images/tanishqneck2.webp',
    'assets/images/picearring1.jpg',
    'assets/images/picerarneck.webp',
  ].obs;
  RxList<String> filterText = <String>[].obs;
  RxBool isLoading = true.obs;
  RxString errorMessage = ''.obs;



   Future<void> fetchProducts({bool loadMore = false}) async {
    // if (isProductLoading.value || !hasMoreProducts.value) return;
    isProductLoading.value = true;
    errorMessage.value = '';
    final userIdValue = await userId();
    final categoryIdValue = categoryData?['id'] ?? '';
    final page = loadMore ? currentPage.value + 1 : 1;
    final apiUrl = 'product-list';  
    final body = {
      'user_id': userIdValue,
      'category_id': categoryIdValue,
      'page': page,
      if (selectedMinPrice.value.isNotEmpty) 'min_price': selectedMinPrice.value,
      if (selectedMaxPrice.value.isNotEmpty) 'max_price': selectedMaxPrice.value,
    };
    try {
      final response = await Get.find<ApiProvider>().postRequest(apiUrl: apiUrl, data: body);
      if (response['status'] == true && response['data'] != null && response['data']['data'] != null) {
        final List<dynamic> rawProducts = response['data']['data']; 
        final List<Map<String, dynamic>> newProducts = rawProducts.map((e) => Map<String, dynamic>.from(e)).toList();
         for (var product in newProducts) {
        int productId = int.tryParse(product['id'].toString()) ?? 0;
        int isWishlist = int.tryParse(product['is_wishlist'].toString()) ?? 0;
        favouriteMap[productId] = (isWishlist == 1).obs;
      }
        if (loadMore) {
          // Only increment page if new products are returned
          if (newProducts.isNotEmpty) {
            products.addAll(newProducts);
            currentPage.value = page;
          }
        } else {
          products.value = newProducts;
          currentPage.value = 1;
        }
        // Pagination check
        hasMoreProducts.value = response['data']['next_page_url'] != null;
        } else {
          if (!loadMore) products.value = [];
          // errorMessage.value = 'No products found.';
          hasMoreProducts.value = false;
        }
      } catch (e) {
        if (!loadMore) products.value = [];
        errorMessage.value = 'Failed to load products.';
        hasMoreProducts.value = false;
      } finally {
        isProductLoading.value = false;
      }
    }
 

  Future<void> fetchFilterRanges() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await Get.find<ApiProvider>().getRequest(apiUrl: 'filter');
      if (response['status'] == true && response['price_ranges'] != null) {
        final List ranges = response['price_ranges'];
        filterText.value = ranges.map<String>((range) {
          final min = range['min']?.toString() ?? '';
          final max = range['max']?.toString() ?? '';
          return '$min-$max';
        }).toList();
      } else {
        filterText.value = [];
        errorMessage.value = 'No filter data found.';
      }
    } catch (e) {
      filterText.value = [];
      errorMessage.value = 'Failed to load filter data.';
    } finally {
      isLoading.value = false;
    }
  }


  void addtofavourite(int productId) async {
  try {
    // wishListLoader[productId] = true;
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
    // wishListLoader[productId] = false;
  }
}



}

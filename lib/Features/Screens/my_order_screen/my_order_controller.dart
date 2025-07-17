import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class MyOrderController extends GetxController {
  final List<String> myorderupdate = ['Delivered', 'Processing', 'Cancelled'];
  var selectedIndex = 0.obs;
  var allOrders = <Map<String, dynamic>>[].obs;
  var filteredOrder = <Map<String, dynamic>>[].obs;
  final dataList = [].obs;
  RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  ScrollController scrollController = ScrollController();
  RxBool isMoreDataAvailable = true.obs;
  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 200 &&
          !isLoading.value &&
          isMoreDataAvailable.value) {
        orderListApi(isLoadMore: true);
      }
    });

    orderListApi();
  }
  // final List<Map<String, String>> products = [
  //   {
  //     'title': 'Classic Gold Bangle with Leaf Design',
  //     'price': '₹ 1749',
  //     'image': 'assets/images/necklacepic.png',
  //     'size': 'Free Size',
  //     'qty': '1',
  //     'return': 'All Issue easy returns'
  //   },
  //   {
  //     'title': 'Gold Ring Elegant Style',
  //     'price': '₹ 899',
  //     'image': 'assets/images/thumbring.png',
  //     'size': '6',
  //     'qty': '1',
  //     'return': '7-Day Returns'
  //   },
  //   {
  //     'title': 'Gold Ring Elegant Style',
  //     'price': '₹ 899',
  //     'image': 'assets/images/picjumka.jpg',
  //     'size': '6',
  //     'qty': '1',
  //     'return': '7-Day Returns'
  //   },
  //   {
  //     'title': 'Gold Ring Elegant Style',
  //     'price': '₹ 899',
  //     'image': 'assets/images/picjumka.jpg',
  //     'size': '6',
  //     'qty': '1',
  //     'return': '7-Day Returns'
  //   },
  // ];
  // void orderListApi() async {
  //   try {
  //     // isLoading.value = true;
  //     Map<String, dynamic> data = {
  //       "order_status": selectedIndex.value == 0
  //           ? "Delivered"
  //           : selectedIndex.value == 1
  //               ? "pending"
  //               : selectedIndex.value == 2
  //                   ? "Cancelled"
  //                   : '',
  //     };
  //     print(data);
  //     var response = await ApiProvider().postRequest(
  //       apiUrl: 'orders/list',
  //       data: data,
  //     );
  //     print("== API Response ==");
  //     print("Response: $response");

  //     if (response['status'] == true) {
  //        dataList.value = response['data']['data'];
  //       allOrders.clear();
  //       allOrders.assignAll(List<Map<String, dynamic>>.from(dataList ?? []));
  //       CustomWidgets().toast(response['message'], Colors.green);
  //     } else {
  //       allOrders.clear();
  //       CustomWidgets().toast(response['message'], Colors.red);
  //     }
  //   } catch (e) {
  //     allOrders.clear();
  //     print(e.toString());
  //     // isLoading.value = false;
  //   }
  // }

  void orderListApi({bool isLoadMore = false}) async {
    try {
      if (!isLoadMore) {
        isLoading.value = true;
        currentPage.value = 1;
        isMoreDataAvailable.value = true;
      }

      Map<String, dynamic> data = {
        "order_status": selectedIndex.value == 0
            ? "Delivered"
            : selectedIndex.value == 1
                ? "pending"
                : selectedIndex.value == 2
                    ? "Cancelled"
                    : '',
        "page": currentPage.value,
      };

      var response = await ApiProvider().postRequest(
        apiUrl: 'orders/list',
        data: data,
      );

      if (response['status'] == true && response['data'] is Map) {
        final jsonData = response['data'];
        final List<dynamic> dataList = jsonData['data'] ?? [];

        if (!isLoadMore) {
          allOrders.clear();
        }

        allOrders.addAll(List<Map<String, dynamic>>.from(dataList));

        final int lastPage = jsonData['last_page'] ?? 1;
        if (currentPage.value >= lastPage) {
          isMoreDataAvailable.value = false;
        }

        currentPage.value++;
      } else {
        if (!isLoadMore) {
          allOrders.clear();
        }
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

//  void orderListApi({bool reset = false}) async {
//     try {
//       if (reset) {
//         currentPage.value = 1;
//         allOrders.clear();
//       }

//       isLoading.value = reset;
//       isMoreLoading.value = !reset;

//       Map<String, dynamic> data = {
//         "order_status": selectedIndex.value == 0
//             ? "Delivered"
//             : selectedIndex.value == 1
//                 ? "pending"
//                 : selectedIndex.value == 2
//                     ? "Cancelled"
//                     : '',
//         "page": currentPage.value
//       };

//       var response = await ApiProvider().postRequest(
//         apiUrl: 'orders/list',
//         data: data,
//       );

//       if (response['status'] == true) {
//         final responseData = response['data'];
//         lastPage.value = responseData['last_page'] ?? 1;
//         final dataList = responseData['data'] ?? [];
//         allOrders.addAll(List<Map<String, dynamic>>.from(dataList));
//       } else {
//         if (reset) {
//           allOrders.clear();
//         }
//         CustomWidgets().toast(response['message'], Colors.red);
//       }
//     } catch (e) {
//       print("Pagination error: $e");
//     } finally {
//       isLoading.value = false;
//       isMoreLoading.value = false;
//     }
//   }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class MyOrderController extends GetxController {
  final List<String> myorderupdate = ['Delivered', 'Processing', 'Cancelled'];
  var selectedIndex = 0.obs;
  var allOrders = <Map<String, dynamic>>[].obs;
  var filteredOrder = <Map<String, dynamic>>[].obs;
  final dataList=[].obs;
   RxInt currentPage = 1.obs;
  RxInt lastPage = 1.obs;
  RxBool isLoading = false.obs;
  RxBool isMoreLoading = false.obs;
  ScrollController scrollController = ScrollController();
  // @override
  // void onInit() {
  //   super.onInit();
  //   orderListApi(reset: true); // First load
  //   scrollController.addListener(_scrollListener);
  // }

  // void _scrollListener() {
  //   if (scrollController.position.pixels >= scrollController.position.maxScrollExtent - 300) {
  //     if (!isMoreLoading.value && currentPage.value < lastPage.value) {
  //       currentPage.value += 1;
  //       orderListApi(reset: false);
  //     }
  //   }
  // }
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


  void orderListApi() async {
  try {
    Map<String, dynamic> data = {
      "order_status": selectedIndex.value == 0
          ? "Delivered"
          : selectedIndex.value == 1
              ? "pending"
              : selectedIndex.value == 2
                  ? "Cancelled"
                  : '',
    };

    var response = await ApiProvider().postRequest(
      apiUrl: 'orders/list',
      data: data,
    );
    allOrders.clear(); 

    if (response['status'] == true && response['data'] is Map) {
      final dataList = response['data']['data'];
      allOrders.assignAll(List<Map<String, dynamic>>.from(dataList ?? []));
      CustomWidgets().toast(response['message'], Colors.green);
    } else if (response['data'] is List) {
      allOrders.clear();
      CustomWidgets().toast(response['message'], Colors.red);
    } else {
      CustomWidgets().toast(response['message'], Colors.red);
    }
  } catch (e) {
    allOrders.clear();
    CustomWidgets().toast("Something went wrong", Colors.red);
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
}


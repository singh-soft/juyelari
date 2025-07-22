import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/bottom_bar/bottom_bar_view.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_controller.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class ReviewOrderDetailsController extends GetxController {
  final ShippingAddressController shippingAddressController =
      Get.put(ShippingAddressController());
  final TextEditingController couponController = TextEditingController();
  var steps = ['Review', 'Payment', 'Order Placed'].obs;
  var currentStep = 0.obs;
  var selectedIndex = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingApply = false.obs;
  RxDouble couponDiscount = 0.0.obs;
  RxBool isSelectedPayment = false.obs;
  RxInt selectedAddressIndex = 0.obs; 
  void togglePayment() {
    isSelectedPayment.value = !isSelectedPayment.value;
  }

  var couponKey = GlobalKey<FormState>();

  var cartItmes = <Map<String, dynamic>>[].obs;
  RxDouble totalAmount = 0.0.obs;
  RxDouble newtotalAmount = 0.0.obs;
  var selectedItems = <Map<String, dynamic>>[].obs;

  var isReviewDone = false.obs;
  var showPaymentSection = false.obs;

  List<Map<String, dynamic>> get productDetails {
    return cartItmes.map((item) {
      return {
        "id": item["product_id"]?.toString() ?? "",
        "name": item["product_name"]?.toString() ?? "",
        "qty": item["qty"] ?? 1,
        "price": item["price"]?.toString() ?? "0",
        "subtotal": item["total_amount"]?.toString() ?? "0",
      };
    }).toList();
  }

  void togglePaymentSection() {
    showPaymentSection.value = true;
  }

  void completeReview() {
    isReviewDone.value = true;
  }

  void nextStep() {
    if (canGoToStep(currentStep.value + 1)) {
      currentStep++;
  }
}

void previousStep() {
    if (currentStep > 0) currentStep--;
}

void goToStep(int index) {
    if (canGoToStep(index)) {
    currentStep.value = index;
  }
}

  bool canGoToStep(int index) {
    print( "Current Step: ${currentStep.value}, Index: $index");
    if (index == 1 || index == 2) {
      return isReviewDone.value;
    }
    return index <= steps.length - 1;
  }

  void mycartApi() async {
    try {
      isLoading.value = true;

      var response = await ApiProvider().getRequest(apiUrl: 'cart/my-cart');

      if (response['status'] == true) {
        final List data = response['data'];
        print(cartItmes);
        if (data.isEmpty) {
          cartItmes.clear();
          selectedItems.clear();
          totalAmount.value = 0.0;
        } else {
          final cartList = List<Map<String, dynamic>>.from(data);
          cartItmes.assignAll(cartList);
          selectedItems.assignAll(cartList);

          double total = 0;
          for (var item in cartList) {
            double price = double.tryParse(
                    item['price'].toString().replaceAll('₹', '').trim()) ??
                0;
            int qty = int.tryParse(item['qty'].toString()) ?? 1;
            total += price * qty;
          }
          totalAmount.value = total;
        }

        CustomWidgets().toast(response['message'], Colors.green);
      } else {
        cartItmes.clear();
        selectedItems.clear();
        totalAmount.value = 0.0;
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

  void calculateTotal() {
    double total = 0;
    for (var item in selectedItems) {
      double price = double.tryParse(
              item['price'].toString().replaceAll('₹', '').trim()) ??
          0;
      int qty = int.tryParse(item['qty'].toString()) ?? 1;
      total += price * qty;
    }
    totalAmount.value = total;
    newtotalAmount.value = total - couponDiscount.value;
  }

  void couponCodeApi() async {
    try {
      isLoadingApply.value = true;
      Map<String, dynamic> data = {"coupon_code": couponController.value.text};
      var response =
          await ApiProvider().postRequest(apiUrl: 'apply-coupon', data: data);
      if (response['status'].toString() == 'success') {
        double discount = double.tryParse(response['discount'].toString()) ?? 0;
        couponDiscount.value = discount;
        newtotalAmount.value = totalAmount.value - couponDiscount.value;

        CustomWidgets().toast(response['message'], Colors.green);
        isLoadingApply.value = false;
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
        isLoadingApply.value = false;
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
      isLoadingApply.value = false;
    }
  }

  void deleteMyCartApi(String id) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "product_id": id,
      };
      var response = await ApiProvider()
          .postRequest(apiUrl: 'remove-from-cart', data: data);
      if (response['status'] == true) {
        mycartApi();
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

  void createOrdreApi(String id) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "address_id": id,
        "payment_method": "online",
        "terms_and_conditions": true,
        "productDetails": productDetails,
      };
      print(data);
      var response =
          await ApiProvider().postRequest(apiUrl: 'orders/create', data: data);
      print(response.toString());
      if (response['status'] == true) {
        CustomWidgets().toast(response['message'], Colors.green);
        Get.dialog(
  Dialog(
    backgroundColor: Colors.transparent,
    child: Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.fromLTRB(20, 42, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
            const   SizedBox(height:25),
              const Text(
                "Done!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                response['message'] ?? "Your order has been placed successfully!",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:CustomColor.yellowshade,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  Get.back(); 
                  // Get.offAllNamed('/dashboardscreen'); 
                          Get.offAll(() => const BottomBarView());

                  
                  },
                child: const Text("OK", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),

       
        Positioned(
          top: 5,
          child: 
           Container(
            decoration: BoxDecoration(shape: BoxShape.circle,
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 8,
        offset: Offset(0, 4),
      ),
    ],),
              
             child: CircleAvatar(
              radius: 40,
              backgroundColor:CustomColor.white,
              child: CircleAvatar(
              radius: 25,
              backgroundColor:CustomColor.yellowshade,
              child: const Icon(
                Icons.check,
                size: 25,
                color: Colors.white,
              ),
              
                       ),
                       ),
           ),
         
        ),
      ],
    ),
  ),
);
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
      print(e.toString());
      CustomWidgets()
          .toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      isLoading.value = false;
    }
  }
}

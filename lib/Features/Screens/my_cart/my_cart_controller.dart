import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class MyCartController extends GetxController {
  final List<Map<String, dynamic>> addressList = [];
  final selectedCity = 'Mumbai'.obs;
  RxBool isLoading = false.obs;
    RxBool isLoading1 = false.obs;
  var cartItmes = <Map<String, dynamic>>[].obs;
  RxDouble totalAmount = 0.0.obs;

  void updateCity(String value) {
    selectedCity.value = value;
  }
  String formatAddress(Map<String, dynamic> address) {
      return [
        address['address_tag'],
        address['flat'],
        address['area'],
        address['address_line_1'],
        address['address_line_2'],
        address['city'],
        address['state'],
        address['country'],
        address['postalcode'],
      ].where((e) => e != null && e.toString().trim().isNotEmpty).join(', ');
    }
  void mycartApi() async {
    try {
      isLoading.value = true;
      var response = await ApiProvider().getRequest(apiUrl: 'cart/my-cart');
      if (response['success'] == true) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        cartItmes.assignAll(data);

        double total = 0;
        for (var item in data) {
          double price = double.tryParse(
                  item['price'].toString().replaceAll('₹', '').trim()) ??
              0;
          int qty = int.tryParse(item['qty'].toString()) ?? 1;
          total += price * qty;
        }
        totalAmount.value = total;
        // final data=response['data'];
        // cartItmes.assignAll(List<Map<String, dynamic>>.from(response['data']));
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

  void deleteMyCartApi(String id) async {
    try {
      isLoading.value = true;
      Map<String, dynamic> data = {
        "product_id": id,
      };
      var response = await ApiProvider()
          .postRequest(apiUrl: 'remove-from-cart', data: data);
      if (response['success'] == true) {
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

  void getShippingAddressApi() async {
    try {
      isLoading1.value = true;
      var response =
          await ApiProvider().getRequest(apiUrl: 'shipping-address-list');
      if (response['success'] == true) {
        addressList.clear();
        List<dynamic> data = response['data'];
        for (var item in data) {
          addressList.add(Map<String, dynamic>.from(item));
        }
        CustomWidgets().toast(response['message'], Colors.green);
        isLoading1.value = false;
      } else {
        CustomWidgets().toast(response['message'], Colors.red);
        isLoading1.value = false;
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
      isLoading1.value = false;
    }
  }
}

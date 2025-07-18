import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class ShippingAddressController extends GetxController {
  final TextEditingController searchController = TextEditingController();
  var selectedAddressIndex = 0.obs;
  RxBool isLoading1 = false.obs;
  RxInt deletingIndex = (-1).obs;
  Map<String, dynamic>? get selectedAddress {
    if (addressList.isNotEmpty &&
        selectedAddressIndex.value < addressList.length) {
      return addressList[selectedAddressIndex.value];
    }
    return null;
  }
  void selectedAddress1(int index) {
    selectedAddressIndex.value = index;
  }

  final List<Map<String, dynamic>> addressList = [];
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

  void getShippingAddressApi() async {
    try {
      isLoading1.value = true;
      var response =
          await ApiProvider().getRequest(apiUrl: 'shipping-address-list');
      if (response['status'] == true) {
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

  void deleteShippingAddressApi(int id, int index) async {
  try {
    deletingIndex.value = index;
    Map<String, dynamic> data = {'id': id};
    var response = await ApiProvider()
        .postRequest(apiUrl: 'shipping-address-delete', data: data);

    if (response['success'] == true) {
      CustomWidgets().toast(response['message'], Colors.green);
       getShippingAddressApi();
    } else {
      CustomWidgets().toast(response['message'], Colors.red);
    }
  } on SocketException {
    CustomWidgets().toast("No Internet Connection", Colors.red);
  } on TimeoutException {
    CustomWidgets().toast("Request time out, Please try again later", Colors.red);
  } catch (e) {
    CustomWidgets().toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
  } finally {
    deletingIndex.value = -1;
  }
}
    
  }


import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class ShippingAddressController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getShippingAddressApi();
  }
  final TextEditingController searchController = TextEditingController();
  var selectedAddressIndex = 0.obs;
  RxBool isLoading1 = false.obs;
  RxBool isLoading2 = false.obs;
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

  Map<String, dynamic>? get defaultAddress {
    if (addressList.isNotEmpty && selectedAddressIndex.value < addressList.length) {
      return addressList[selectedAddressIndex.value];
    }
    try {
      return addressList.firstWhere(
        (addr) => addr['is_default'] == 1,
        orElse: () {
          if (addressList.isNotEmpty) {
            return addressList[0];
          } else {
            throw Exception('No address found');
          }
        },
      );
    } catch (_) {
      return null;
    }
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
    ].whereType<String>().where((e) => e.trim().isNotEmpty).join(', ');
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
        final defaultIdx = addressList.indexWhere((addr) => addr['is_default'] == 1);
        if (defaultIdx != -1) {
          selectedAddressIndex.value = defaultIdx;
        } else if (addressList.isNotEmpty) {
          selectedAddressIndex.value = 0;
        }
        // CustomWidgets().toast(response['message'], Colors.green);
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
    

  void changeDefaultAddressApi(int addressId) async {
    try {
      isLoading2.value = true;
      Map<String, dynamic> data = {
        'address_id': addressId,
      };
      var response = await ApiProvider().postRequest(
        apiUrl: 'change-default-address',
        data: data,
      );
      if (response['status'] == true || response['success'] == true) {
        CustomWidgets().toast(response['message'], Colors.green);
        // getShippingAddressApi();
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
      isLoading2.value = false;
    }
  }
  }


import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_controller.dart';
import 'package:juyelari/Features/provider/api_provider.dart';

class AddNewAddressController extends GetxController {
  var saveAs = 'home'.obs;
  var isDefault = false.obs;
  RxBool isLoading = false.obs;
  RxBool countryLoading = false.obs;
  RxBool stateLoading = false.obs;
  RxBool cityLoading = false.obs;
  RxList countryList = [].obs;
  RxList stateList = [].obs;
  RxList cityList = [].obs;
  RxString selectedCountry = ''.obs;
  RxString selectedState = ''.obs;
  RxString selectedCity = ''.obs;
  void selectState(String value) {
    selectedState.value = value;
    stateController.text = value;
  }

  void selectcity(String value) {
    selectedCity.value = value;
    cityController.text = value;
  }

  void selectCity(String selectedName) {
    selectedCity.value = selectedName;
    cityController.text = selectedName;
    int index = stateList.indexWhere((c) => c['state'] == selectedName);
    if (index != -1) {
      int selectedId = stateList[index]['id'];
      cityApi(selectedId);
    } else {}
  }

  void selectCountry(String selectedName) {
    selectedCountry.value = selectedName;
    int index =
        countryList.indexWhere((c) => c['country_name'] == selectedName);

    if (index != -1) {
      int selectedId = countryList[index]['id'];
      stateApi(selectedId);
    }
  }

  var shippingAddressData = Get.arguments;
  var addressKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController addressController1 = TextEditingController();
  final TextEditingController addressController2 = TextEditingController();
  final TextEditingController textareaController = TextEditingController();
  final TextEditingController flatController = TextEditingController();
  final TextEditingController areaController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final cartController = Get.find<MyCartController>();
  @override
  void onInit() {
    super.onInit();

    if (shippingAddressData != null && shippingAddressData.isNotEmpty) {
      flatController.text = shippingAddressData['flat'] ?? '';
      areaController.text = shippingAddressData['area'] ?? '';
      addressController1.text = shippingAddressData['address_line_1'] ?? '';
      addressController2.text = shippingAddressData['address_line_2'] ?? '';
      cityController.text = shippingAddressData['city'] ?? '';
      stateController.text = shippingAddressData['state'] ?? '';
      countryController.text = shippingAddressData['country'] ?? '';
      pincodeController.text = shippingAddressData['postalcode'] ?? '';
      saveAs.value = shippingAddressData['address_tag'] ?? 'home';
      nameController.text = shippingAddressData['name'] ?? '';
      phoneController.text = shippingAddressData['phone'] ?? '';
    }

    // countryApi();
  }

  void addnewAddressApi() async {
    try {
      Map<String, dynamic> data = {
        "name": nameController.value.text,
        "area": areaController.value.text,
        "phone": phoneController.value.text,
        "flat": flatController.value.text,
        "postalcode": pincodeController.value.text,
        "address_line_1": addressController1.value.text,
        "address_line_2": addressController2.value.text,
        "address_tag": saveAs.toString(),
        "city": selectedCity.value,
        "state": selectedState.value,
        "country": selectedCountry.value,
      };
      isLoading.value = true;
      var response = await ApiProvider()
          .postRequest(apiUrl: 'shipping-address', data: data);
      if (response['status'] == true) {
        nameController.clear();
        areaController.clear();
        phoneController.clear();
        flatController.clear();
        pincodeController.clear();
        addressController1.clear();
        addressController2.clear();
        cityController.clear();
        stateController.clear();
        countryController.clear();
        CustomWidgets().toast(response['message'], Colors.green);
        isLoading.value = false;
        Get.back(result: true);
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

  void updateAddressApi() async {
    try {
      Map<String, dynamic> data = {
        'id': shippingAddressData['id'],
        "name": nameController.value.text,
        "area": areaController.value.text,
        "phone": phoneController.value.text,
        "flat": flatController.value.text,
        "postalcode": pincodeController.value.text,
        "address_line_1": addressController1.value.text,
        "address_line_2": addressController2.value.text,
        "address_tag": saveAs.toString(),
       "city": selectedCity.value,
        "state": selectedState.value,
        "country": selectedCountry.value,
      };
      isLoading.value = true;
      var response = await ApiProvider()
          .postRequest(apiUrl: 'shipping-address-update', data: data);
      if (response['success'] == true) {
        nameController.clear();
        areaController.clear();
        phoneController.clear();
        flatController.clear();
        pincodeController.clear();
        addressController1.clear();
        addressController2.clear();
        cityController.clear();
        stateController.clear();
        countryController.clear();
        CustomWidgets().toast(response['message'], Colors.green);

        isLoading.value = false;

        Get.back(result: true);
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

  void countryApi() async {
    try {
      countryLoading.value = true;
      var response = await ApiProvider().getRequest(apiUrl: 'countries');
      if (response['status'] == true) {
        countryList.value = response['data'];
        if (countryList.isNotEmpty) {
        final firstCountry = countryList[0];
        selectedCountry.value = firstCountry['country_name'] ?? '';
        countryController.text = firstCountry['country_name'] ?? '';
        final int countryId = firstCountry['id'];
        stateApi(countryId);
      }
        // CustomWidgets().toast(response['message'], Colors.green);
        countryLoading.value = false;
      } else {
        // CustomWidgets().toast(response['message'], Colors.red);
        countryLoading.value = false;
      }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets()
          .toast("Request time out, Please try again later", Colors.red);
    } catch (e) {
      countryLoading.value = false;
      CustomWidgets()
          .toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      countryLoading.value = false;
    }
  }

  void stateApi(int id) async {
    try {
      stateLoading.value = true;
      var response = await ApiProvider().getRequest(
        apiUrl: 'states?country_id=$id',
      );
      if (response['status'] == true) {
        stateList.value = response['data'];
        if (stateList.isNotEmpty && (shippingAddressData == null || shippingAddressData.isEmpty)) {
        final firstState = stateList[0];
        selectedState.value = firstState['state'] ?? '';
        stateController.text = firstState['state'] ?? '';
        final int stateId = firstState['id'];
        cityApi(stateId);
      }
        // CustomWidgets().toast(response['message'], Colors.green);
        stateLoading.value = false;
      } else {
        // CustomWidgets().toast(response['message'], Colors.red);
        stateLoading.value = false;
      }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets()
          .toast("Request time out, Please try again later", Colors.red);
    } catch (e) {
      stateLoading.value = false;
      CustomWidgets()
          .toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      stateLoading.value = false;
    }
  }

  void cityApi(int id) async {
    try {
      cityLoading.value = true;
      var response =
          await ApiProvider().getRequest(apiUrl: 'cities?state_id=$id');
      if (response['status'] == true) {
        cityList.value = response['data'];
         if (cityList.isNotEmpty && (shippingAddressData == null || shippingAddressData.isEmpty)) {
        final firstCity = cityList[0];
        selectedCity.value = firstCity['city'] ?? '';
        cityController.text = firstCity['city'] ?? '';
      }
        // CustomWidgets().toast(response['message'], Colors.green);
        cityLoading.value = false;
      } else {
        // CustomWidgets().toast(response['message'], Colors.red);
        cityLoading.value = false;
      }
    } on SocketException {
      CustomWidgets().toast("No Internet Connection", Colors.red);
    } on TimeoutException {
      CustomWidgets()
          .toast("Request time out, Please try again later", Colors.red);
    } catch (e) {
      cityLoading.value = false;
      CustomWidgets()
          .toast(e.toString().replaceFirst('Exception: ', ''), Colors.red);
    } finally {
      cityLoading.value = false;
    }
  }
}

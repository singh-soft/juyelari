import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Custom_widgets/field_validator.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/new_address/add_new_address_controller.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class AddNewAddressScreen extends GetView<AddNewAddressController> {
  const AddNewAddressScreen({super.key});
  final customHeight10 = height10;
  final customHeight5 = height5;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AddNewAddressController());
    controller.countryApi();
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            if (controller.addressKey.currentState!.validate()) {
              if (controller.shippingAddressData != null &&
                  controller.shippingAddressData['id'] != null) {
                controller.updateAddressApi();
              } else {
                controller.addnewAddressApi();
              }
            }
          },
          child: Container(
            height: 60,
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.topRight,
                colors: <Color>[
                  Colors.black,
                  Color(0xff890E29),
                  Colors.black,
                ],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Obx(
              () => controller.isLoading.value
                  ? Center(
                      child: LoadingAnimationWidget.flickr(
                          size: 30,
                          leftDotColor: Colors.white,
                          rightDotColor: Colors.pink),
                    )
                  : Text(
                      controller.shippingAddressData != null &&
                              controller.shippingAddressData['id'] != null
                          ? "Update Address"
                          : "Add Address",
                      style: FontStyle.white18,
                      textAlign: TextAlign.center,
                    ),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
        title: 'Add New Address',
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.addressKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFormField2(
                  contentPadding: const EdgeInsets.all(10.0),
                  hintText: 'Name',
                  topLabelText: 'Name',
                  isMandatory: true,
                  hintStyle: FontStyle.black16,
                  controller: controller.nameController,
                  fillColor: CustomColor.white,
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey.withOpacity(0.1),
                      )),
                  focusBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enableBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  validator: (value) =>
                      FieldValidator(context).nameValidate(value),
                ),
                customHeight10,
                CustomTextFormField2(
                    hintText: 'Phone',
                    topLabelText: 'Phone',
                    isMandatory: true,
                    hintStyle: FontStyle.black16,
                    controller: controller.phoneController,
                    fillColor: CustomColor.white,
                    filled: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    focusBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    enableBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    validator: (value) =>
                        FieldValidator(context).mobileValidate(value)),
                customHeight10,
                CustomTextFormField2(
                    hintText: 'Address Line 1',
                    topLabelText: 'Address Line 1',
                    isMandatory: true,
                    hintStyle: FontStyle.black16,
                    controller: controller.addressController1,
                    fillColor: CustomColor.white,
                    filled: true,
                    border:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    focusBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    enableBorder:
                        const OutlineInputBorder(borderSide: BorderSide.none),
                    validator: (value) =>
                        FieldValidator(context).addressLine1(value)),
                customHeight10,
                CustomTextFormField2(
                  hintText: 'Address Line 2',
                  topLabelText: 'Address Line 2',
                  //       isMandatory: true,
                  hintStyle: FontStyle.black16,
                  controller: controller.addressController2,
                  fillColor: CustomColor.white,
                  filled: true,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enableBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  validator: (value) =>
                      FieldValidator(context).addressLine2(value),
                ),
                customHeight10,
                CustomTextFormField2(
                  hintText: 'Pincode',
                  topLabelText: 'Pincode',
                  isMandatory: true,
                  hintStyle: FontStyle.black16,
                  controller: controller.pincodeController,
                  fillColor: CustomColor.white,
                  filled: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(6),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enableBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  validator: (value) =>
                      FieldValidator(context).postalCode(value),
                ),
                customHeight10,
                CustomTextFormField2(
                  hintText: 'Flat',
                  topLabelText: 'Flat',
                  // isMandatory: true,
                  hintStyle: FontStyle.black16,
                  controller: controller.flatController,
                  fillColor: CustomColor.white,
                  filled: true,
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enableBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  validator: (value) => FieldValidator(context).flat(value),
                ),
                customHeight10,
                CustomTextFormField2(
                  hintText: 'Area',
                  topLabelText: 'Area',
                  // isMandatory: true,
                  hintStyle: FontStyle.black16,
                  controller: controller.areaController,
                  fillColor: CustomColor.white,
                  filled: true,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                  ],
                  border: const OutlineInputBorder(borderSide: BorderSide.none),
                  focusBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  enableBorder:
                      const OutlineInputBorder(borderSide: BorderSide.none),
                  validator: (value) => FieldValidator(context).area(value),
                ),
                customHeight10,
                Obx(() {
                  final countryItems = controller.countryList
                      .map<DropdownMenuItem<String>>((country) {
                    return DropdownMenuItem<String>(
                      value: country['country_name'],
                      child: Text("${country['country_name']}"),
                    );
                  }).toList();

                  final selected = controller.selectedCountry.value;
                  final isValidSelection = countryItems
                          .where((item) => item.value == selected)
                          .length ==
                      1;

                  return Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 0,
                          blurRadius: 0,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: controller.countryLoading.value
                        ? const Center(child: CircularProgressIndicator())
                        : DropdownButtonFormField<String>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: CustomColor.white,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 14),
                            ),
                            hint: const Text("Select Country"),
                            value: isValidSelection ? selected : null,
                            items: countryItems,
                            onChanged: (value) {
                              if (value != null) {
                                controller.selectCountry(value);
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a country';
                              }
                              return null;
                            },
                          ),
                  );
                }),
                customHeight10,
                Row(
                  children: [
                    Expanded(
                      child: Obx(() {
                        final selected = controller.selectedState.value;
                        final stateItems = controller.stateList
                            .map<DropdownMenuItem<String>>((state) {
                          final value = state['state']?.toString().trim();
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value ?? ''),
                          );
                        }).toList();

                        final validSelection = stateItems
                                .where((item) => item.value == selected.trim())
                                .length ==
                            1;

                        return Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: controller.stateLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: CustomColor.white,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                  ),
                                  hint: const Text("Select State"),
                                  value:
                                      validSelection ? selected.trim() : null,
                                  items: stateItems,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectState(value.trim());
                                      controller.selectCity(value.trim());
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a state';
                                    }
                                    return null;
                                  },
                                ),
                        );
                      }),
                    ),
                    customwidth5,
                    Expanded(
                      child: Obx(() {
                        final selected = controller.selectedCity.value;

                        final cityItems = controller.cityList
                            .where((city) => city['city'] != null)
                            .map<DropdownMenuItem<String>>((city) {
                          final value = city['city'].toString().trim();
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList();

                        final validSelection = cityItems
                                .where((item) => item.value == selected.trim())
                                .length ==
                            1;

                        return Container(
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.1)),
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 0,
                                blurRadius: 0,
                                offset: const Offset(0, 1),
                              ),
                            ],
                          ),
                          child: controller.cityLoading.value
                              ? const Center(child: CircularProgressIndicator())
                              : DropdownButtonFormField<String>(
                                  isExpanded: true,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: CustomColor.white,
                                    border: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    focusedBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    enabledBorder: const OutlineInputBorder(
                                        borderSide: BorderSide.none),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 14),
                                  ),
                                  hint: const Text("Select City"),
                                  value:
                                      validSelection ? selected.trim() : null,
                                  items: cityItems,
                                  onChanged: (value) {
                                    if (value != null) {
                                      controller.selectcity(value.trim());
                                    }
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please select a city';
                                    }
                                    return null;
                                  },
                                ),
                        );
                      }),
                    ),
                  ],
                ),
                customHeight10,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Save As', style: FontStyle.black16bold),
                ),
                Obx(() => Row(
                      children: [
                        _buildChoiceChip('home', controller),
                        const SizedBox(width: 10),
                        _buildChoiceChip('work', controller),
                      ],
                    )),
                customHeight5,
                Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: controller.isDefault.value,
                            onChanged: (val) =>
                                controller.isDefault.value = val!,
                            activeColor: CustomColor.redshadeColor),
                        const Text(
                          'Set as default address',
                          style: TextStyle(color: Color(0xff890E29)),
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label, AddNewAddressController controller) {
    final isSelected = controller.saveAs.value == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => controller.saveAs.value = label,
      selectedColor: CustomColor.greycolor,
      labelStyle: TextStyle(color: isSelected ? Colors.white : Colors.black),
    );
  }
}

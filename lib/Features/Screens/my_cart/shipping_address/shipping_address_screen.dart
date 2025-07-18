import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/new_address/add_new_address_screen.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_controller.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';

class ShippingAddressScreen extends GetView<ShippingAddressController> {
  const ShippingAddressScreen({super.key});
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
    Get.lazyPut(() => ShippingAddressController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
          title: 'Shipping Address',
          leadingIcon: Icons.arrow_back_ios,
          onLeadingPressed: () {
            Get.back(
                result: controller
                    .addressList[controller.selectedAddressIndex.value]);
          },
          actions: [
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.to(() => const AddNewAddressScreen())?.then((result) {
                    if (result == true) {
                      controller.getShippingAddressApi();
                    }
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 40,
                  width: 40,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Colors.black,
                        Color(0xff890E29),
                        Colors.black,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ]),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InkWell(
          onTap: () {
            if (controller.addressList.isNotEmpty &&
                controller.selectedAddressIndex.value < controller.addressList.length) {
              final selectedId = controller.addressList[controller.selectedAddressIndex.value]['id'];
              if (selectedId != null) {
                controller.changeDefaultAddressApi(selectedId);
              }
            }
          },
          child: Container(
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
            child: Obx(() => controller.isLoading2.value
                ? SizedBox(
                    height: 28,
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  )
                : Text(
                    "Deliver Here",
                    style: FontStyle.white18,
                    textAlign: TextAlign.center,
                  ),
            ),
          ),
        ),
      ),
      body: Obx(
        () => controller.isLoading1.value
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    customHeight5,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextFormField2(
                        contentPadding: const EdgeInsets.all(8.0),
                        controller: controller.searchController,
                        hintText: 'Search Product',
                        hintStyle: FontStyle.greytext14,
                        prefixIcon: Icon(
                          Icons.search,
                          color: CustomColor.blackColor,
                          size: 25,
                        ),
                        border: InputBorder.none,
                        focusBorder: InputBorder.none,
                        enableBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                      ),
                    ),

                    // List of addresses
                    controller.addressList.isEmpty
                        ? const Center(child: Text("No Data Found"))
                        : ListView.builder(
                            itemCount: controller.addressList.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              // final isSelected=controller.selectedAddressIndex.value==index;
                              return Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                color: Colors.white,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Obx(
                                            () => Radio(
                                              value: index,
                                              groupValue: controller
                                                  .selectedAddressIndex.value,
                                              onChanged: (val) {
                                                controller
                                                    .selectedAddress1(index);
                                              },
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  // mainAxisAlignment:
                                                  //     MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        "Shipping Address - ${index + 1}",
                                                        style: FontStyle
                                                            .black16bold,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          IconButton(
                                                            visualDensity:
                                                                VisualDensity
                                                                    .compact,
                                                            padding:
                                                                EdgeInsets.zero,
                                                            constraints:
                                                                const BoxConstraints(),
                                                            icon: Icon(
                                                              Icons.edit,
                                                              color: CustomColor
                                                                  .lightgreyy,
                                                            ),
                                                            onPressed: () {
                                                              Get.to(
                                                                  () =>
                                                                      const AddNewAddressScreen(),
                                                                  arguments: {
                                                                    'id': controller
                                                                            .addressList[
                                                                        index]['id'],
                                                                    'address_tag':
                                                                        controller.addressList[index]
                                                                            [
                                                                            'address_tag'],
                                                                    'flat': controller
                                                                            .addressList[index]
                                                                        [
                                                                        'flat'],
                                                                    'area': controller
                                                                            .addressList[index]
                                                                        [
                                                                        'area'],
                                                                    'address_line_1':
                                                                        controller.addressList[index]
                                                                            [
                                                                            'address_line_1'],
                                                                    'address_line_2':
                                                                        controller.addressList[index]
                                                                            [
                                                                            'address_line_2'],
                                                                    'city': controller
                                                                            .addressList[index]
                                                                        [
                                                                        'city'],
                                                                    'state': controller
                                                                            .addressList[index]
                                                                        [
                                                                        'state'],
                                                                    'country': controller
                                                                            .addressList[index]
                                                                        [
                                                                        'country'],
                                                                    'postalcode':
                                                                        controller.addressList[index]
                                                                            [
                                                                            'postalcode'],
                                                                    'name': controller
                                                                            .addressList[index]
                                                                        [
                                                                        'name'],
                                                                    'phone': controller
                                                                            .addressList[index]
                                                                        [
                                                                        'phone'],
                                                                  })?.then(
                                                                  (result) {
                                                                if (result ==
                                                                    true) {
                                                                  controller
                                                                      .getShippingAddressApi();
                                                                }
                                                              });
                                                            },
                                                          ),
                                                          Obx(() => controller
                                                                      .deletingIndex
                                                                      .value ==
                                                                  index
                                                              ? const CircularProgressIndicator()
                                                              : IconButton(
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact,
                                                                  padding:
                                                                      EdgeInsets
                                                                          .zero,
                                                                  constraints:
                                                                      const BoxConstraints(),
                                                                  icon: Icon(
                                                                      Icons
                                                                          .delete,
                                                                      color: CustomColor
                                                                          .lightgreyy),
                                                                  onPressed:
                                                                      () {
                                                                    Get.defaultDialog(
                                                                      middleText:
                                                                          'Are you sure you want to remove this item from shipping address?',
                                                                      buttonColor:
                                                                          CustomColor
                                                                              .redshadeColor,
                                                                      textConfirm:
                                                                          "Yes",
                                                                      textCancel:
                                                                          "No",
                                                                      onConfirm:
                                                                          () {
                                                                        if (Get.isDialogOpen ??
                                                                            false) {
                                                                          Get.back();
                                                                        }

                                                                        controller.deleteShippingAddressApi(
                                                                            controller.addressList[index]['id'],
                                                                            index);
                                                                      },
                                                                      onCancel:
                                                                          () {
                                                                        if (Get.isDialogOpen ??
                                                                            false) {
                                                                          Get.back();
                                                                        }
                                                                      },
                                                                    );
                                                                  },
                                                                )),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Obx(
                                                  () => controller
                                                          .isLoading1.value
                                                      ? const CircularProgressIndicator()
                                                      : controller.addressList
                                                              .isNotEmpty
                                                          ? Text(
                                                              controller.formatAddress(
                                                                  controller
                                                                          .addressList[
                                                                      index]),
                                                              style: FontStyle
                                                                  .black14,
                                                              maxLines: 3,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            )
                                                          : Text(
                                                              "No address found",
                                                              style: FontStyle
                                                                  .black14,
                                                            ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: CustomColor.lightgrey,
                                      thickness: 1,
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                  ],
                ),
              ),
      ),
    );
  }
}

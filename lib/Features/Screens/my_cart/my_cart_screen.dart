import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_controller.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_controller.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_screen.dart';
import 'package:juyelari/Features/Screens/product_screen/product_details/product_detail_screen.dart';
import 'package:juyelari/Features/Screens/review_order_details/review_order_details_screen.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class MyCartScreen extends GetView<MyCartController> {
  const MyCartScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;
  final customwidth10 = width10;
  final customwidth20 = width20;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => MyCartController());
    controller.mycartApi();
    final ShippingAddressController shippingAddressController = Get.put(ShippingAddressController());

    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomWidgets().customAppBar(
          title: 'My Cart',
          leadingIcon: Icons.arrow_back_ios,
          onLeadingPressed: () {
            Get.back();
          },
        ),
        body:  Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(
                            () => const ShippingAddressScreen(),
                            arguments: controller.addressList,
                          )?.then((result) {
                            if (result == true) {
                              controller.getShippingAddressApi();
                            }
                          });
                        },
                        child: Container(
                          // height: screenheight * 0.12,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                              color: CustomColor.yellowshade1,
                              borderRadius: BorderRadius.circular(12)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Shipping Address",
                                style: FontStyle.black16bold,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Expanded(
                                      child:  shippingAddressController.isLoading1.value
                                        ? const Center(
                                            child: CircularProgressIndicator())
                                        : shippingAddressController.addressList.isNotEmpty
                                            ? Text(
                                                shippingAddressController.defaultAddress != null
                                                    ? shippingAddressController.formatAddress(
                                                        shippingAddressController.defaultAddress!)
                                                    :shippingAddressController.formatAddress(
                                                    shippingAddressController.addressList[0]),
                                                style: FontStyle.black14,
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              )
                                            : Text(
                                                "No address found",
                                                style: FontStyle.black14,
                                              ),
                                  ),
                                  const Icon(Icons.arrow_drop_down),

                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      customHeight10,
                      Expanded(
                        child:  Obx(()=>
                           controller.cartItmes.isEmpty
                                ? const Center(child: Text("No Data Found"))
                                : ListView.builder(
                                    itemCount: controller.cartItmes.length,
                                    itemBuilder: (context, index) {
                                      final cartItem =
                                          controller.cartItmes[index];
                                      return InkWell(
                                        onTap: () {
                                          final productId =
                                              cartItem['product_id'].toString();
                                          Get.to(
                                              () => const ProductDetailScreen(),
                                              arguments: {
                                                'product_id': productId
                                              });
                                        },
                                        child: Container(
                                            margin: const EdgeInsets.all(4.0),
                                            padding: const EdgeInsets.all(20.0),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                border: Border.all(
                                                    color: Colors.grey
                                                        .withOpacity(0.1)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.1),
                                                    spreadRadius: 2,
                                                    blurRadius: 2,
                                                    offset: const Offset(1, 3),
                                                  ),
                                                ]),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Stack(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              12),
                                                      child: Obx(
                                                        () => InkWell(
                                                          onTap:
                                                              controller.isLoading
                                                                      .value
                                                                  ? null
                                                                  : () {
                                                                      Get.defaultDialog(
                                                                        barrierDismissible:
                                                                            false,
                                                                        middleText:
                                                                            'Are you sure you want to remove this item from your cart?',
                                                                        buttonColor:
                                                                            CustomColor
                                                                                .redshadeColor,
                                                                        textConfirm:
                                                                            "Yes",
                                                                        textCancel:
                                                                            "No",
                                                                        onConfirm:
                                                                            () {
                                                                          Get.back();
                                                                          controller
                                                                              .deleteMyCartApi(cartItem['product_id'].toString());
                                                                        },
                                                                        onCancel:
                                                                            () {
                                                                          // Get.back();
                                                                        },
                                                                      );
                                                                    },
                                                          child: Container(
                                                            height: 120,
                                                            width: 120,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.white,
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.1)),
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .grey
                                                                      .withOpacity(
                                                                          0.1),
                                                                  spreadRadius: 2,
                                                                  blurRadius: 2,
                                                                  offset:
                                                                      const Offset(
                                                                          1, 3),
                                                                ),
                                                              ],
                                                            ),
                                                            child: Image.network(
                                                              cartItem[
                                                                      'product_image'] ??
                                                                  '',
                                                              fit: BoxFit.cover,
                                                              loadingBuilder:
                                                                  (context, child,
                                                                      loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null) {
                                                                  return child;
                                                                }
                                                                return const SizedBox(
                                                                  height: 120,
                                                                  width: 120,
                                                                  child: Center(
                                                                    child:
                                                                        CircularProgressIndicator(
                                                                      strokeWidth:
                                                                          2,
                                                                      valueColor: AlwaysStoppedAnimation<
                                                                              Color>(
                                                                          Colors
                                                                              .grey),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 4,
                                                      left: 4,
                                                      child: Obx(()=>
                                                         InkWell(
                                                          onTap:
                                                              controller.isLoading
                                                                      .value
                                                                  ? null
                                                                  : () {
                                                                      Get.defaultDialog(
                                                                        barrierDismissible:
                                                                            false,
                                                                        middleText:
                                                                            'Are you sure you want to remove this item from your cart?',
                                                                        buttonColor:
                                                                            CustomColor
                                                                                .redshadeColor,
                                                                        textConfirm:
                                                                            "Yes",
                                                                        textCancel:
                                                                            "No",
                                                                        onConfirm:     
                                                                            () {
                                                                          Get.back();
                                                                          controller
                                                                              .deleteMyCartApi(
                                                                                  cartItem['product_id'].toString());
                                                                        },
                                                                        onCancel:
                                                                            () {
                                                                          // Get.back();
                                                                        },
                                                                      );
                                                                    },
                                                          child: Container(
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: Colors.white,
                                                              shape:
                                                                  BoxShape.circle,
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(4),
                                                            child: const Icon(
                                                                Icons
                                                                    .delete_outline_outlined,
                                                                size: 16,
                                                                color: Colors.red),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                customwidth20,
                                                Expanded(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        cartItem['product_name']
                                                                ?.toString() ??
                                                            '',
                                                        style:
                                                            FontStyle.black17w400,
                                                        maxLines: 2,
                                                        softWrap: true,
                                                      ),
                                                      Text(
                                                        cartItem['price']
                                                                ?.toString() ??
                                                            '',
                                                        style:
                                                            FontStyle.redshad16,
                                                      ),
                                                      Text(
                                                        "All Issue easy returns",
                                                        style: FontStyle
                                                            .grettext14w500,
                                                      ),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          // Text(
                                                          //   "Size: Free Size",
                                                          //   style: FontStyle
                                                          //       .black14w500,
                                                          // ),
                                                          // customwidth20,
                                                          Text(
                                                              "Qty: ${cartItem['qty']?.toString() ?? '0'}",
                                                              style: FontStyle
                                                                  .blacks14w500),
                                                          customwidth20,
                                                          Obx(
                                                            () => Transform.scale(
                                                              scale: 0.8,
                                                              child: Checkbox(
                                                                  visualDensity:
                                                                      VisualDensity
                                                                          .compact,
                                                                  materialTapTargetSize:
                                                                      MaterialTapTargetSize
                                                                          .shrinkWrap,
                                                                  value: controller
                                                                      .selectedItems
                                                                      .contains(
                                                                          cartItem),
                                                                  onChanged:
                                                                      (bool?
                                                                          value) {
                                                                    if (value ==
                                                                        true) {
                                                                      controller
                                                                          .selectedItems
                                                                          .add(
                                                                              cartItem);
                                                                    } else {
                                                                      controller
                                                                          .selectedItems
                                                                          .remove(
                                                                              cartItem);
                                                                    }
                                                                    controller
                                                                        .calculateTotal();
                                                                  }),
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                  ),
                        ),
                        ),
                      
                      customHeight10,
                      Container(
                        // height: screenheight * 0.2,
                        width: double.infinity,
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(1, 3),
                              ),
                            ]),
                        // color: Colors.green,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Order Summary",
                              style: FontStyle.black18,
                            ),
                            customHeight20,
                            rowwidget(
                                title: 'Sub Total ',
                                value:
                                    "₹${controller.totalAmount.value.toStringAsFixed(2)}"),
                            rowwidget(title: 'Delivery Charge', value: 'Free'),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Total Amount",
                                    style: FontStyle.black16,
                                  ),
                                  Flexible(
                                    child: Obx(
                                      () => Text(
                                        "₹ ${controller.totalAmount.value.toStringAsFixed(2)}",
                                        style: FontStyle.black16,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.1)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 2,
                                offset: const Offset(1, 3),
                              ),
                            ]),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Text(
                                      "₹ ${controller.totalAmount.value.toStringAsFixed(2)}",
                                      style: FontStyle.black18,
                                       overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  customHeight10,
                                  Obx(
                                    () => Text(
                                        "(${controller.cartItmes.length} items)",
                                        style: FontStyle.black14),
                                  ),
                                ],
                              ),
                            ),
                            CustomContainerButton(
                              onTap: () {
                                Get.to(() => const ReviewOrderDetailsScreen());
                              },
                              width: screenWidth * 0.42,
                              padding: const EdgeInsets.all(15.0),
                              borderRadius: BorderRadius.circular(50),
                              child: Center(
                                child:controller.isLoadingbutton.value?Center(child: LoadingAnimationWidget.flickr( size: 30, leftDotColor: Colors.white, rightDotColor: Colors.pink)): Text(
                                  'Continue',
                                  style: FontStyle.white18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
        
        );
  }

  Widget rowwidget({required String title, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: FontStyle.greyshade14,
          ),
          Text(
            value,
            style: FontStyle.greyshade14,
          ),
        ],
      ),
    );
  }
}

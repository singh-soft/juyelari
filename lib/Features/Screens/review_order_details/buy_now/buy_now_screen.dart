import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Custom_widgets/field_validator.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_screen.dart';
import 'package:juyelari/Features/Screens/product_screen/product_details/product_detail_screen.dart';
import 'package:juyelari/Features/Screens/review_order_details/buy_now/buy_now_controller.dart';
import 'package:juyelari/Features/Screens/review_order_details/review_order_details_controller.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class BuyNowScreen extends StatelessWidget {
  const BuyNowScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;
  final customwidth10 = width5;
  final customwidth20 = width20;
  final customwidth40 = width40;


  @override
  Widget build(BuildContext context) {
    final BuyNowController controller =
        Get.put(BuyNowController());

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

  
    return Stack(
      children: [
  Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
        title: 'Review Your Order',
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () => Get.back(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        alignment: Alignment.bottomCenter,
        child: Obx(
          () => Container(
            height: screenHeight * 0.102,
            margin: const EdgeInsets.all(4.0),
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 2,
                  blurRadius: 2,
                  offset: const Offset(1, 3),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(() => Text(
                            "₹ ${(controller.couponDiscount.value > 0 ? controller.newtotalAmount.value : controller.totalAmount.value).toStringAsFixed(2)}",
                            style: FontStyle.black18,
                            overflow: TextOverflow.ellipsis,
                          )),
                      Obx(() => Text("(${controller.cartItmes.length} items)",
                          style: FontStyle.black14)),
                    ],
                  ),
                ),
                CustomContainerButton(
                  onTap: () {
                    print("-------------------------------");
                    if (!controller.showPaymentSection.value) {
                      controller.completeReview();
                      if(controller.currentStep.value < 1) {
                        controller.goToStep(1);
                      }else{
                        controller.goToStep(2);
                      }
                      controller.togglePaymentSection();
                    } else {
                      final selectedId = controller
                          .shippingAddressController
                          .addressList[controller.selectedAddressIndex.value]
                              ['id']
                          ?.toString();
        
                      if (selectedId == null || selectedId.isEmpty) {
                        CustomWidgets().toast("Address ID not found", Colors.red);
                        return;
                      }
                       controller.goToStep(2);
                      controller.createOrdreApi(selectedId);
                    }
                  },
                  height: screenHeight * 0.2,
                  width: screenWidth * 0.42,
                  padding: const EdgeInsets.all(15.0),
                  borderRadius: BorderRadius.circular(50),
                  child: Center(
                      child: Text(
                    controller.showPaymentSection.value ? 'Pay' : 'Continue',
                    style: FontStyle.white18,
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: controller.couponKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Step Indicator
        Obx(() => Row(

  children: [
    // Step 1: Review
          _buildStep(
            stepIndex: 0,
            title: controller.steps[0],
            isDone: controller.isReviewDone.value,
            isActive: controller.currentStep.value == 0,
          ),

    // Dotted line between Step 1 and Step 2
      const Expanded(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: DottedLine(
            dashLength: 5,
            dashColor: Colors.grey,
            lineThickness: 2,
          ),
        ),
      ),

    // Step 2: Payment
    _buildStep(
      stepIndex: 1,
      title: controller.steps[1],
      isDone: controller.currentStep.value > 1,
      isActive: controller.currentStep.value == 1,
    ),

    // Dotted line between Step 2 and Step 3
    const Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4),
        child: DottedLine(
          dashLength: 5,
          dashColor: Colors.grey,
          lineThickness: 2,
        ),
      ),
    ),

    // Step 3: Order Placed
    _buildStep(
      stepIndex: 2,
      title: controller.steps[2],
      isDone: controller.currentStep.value > 2,
      isActive: controller.currentStep.value == 2,
    ),
  ],
)),

  
   const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: CustomColor.yellowshade1,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Shipping Address", style: FontStyle.black16bold),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: controller
                                    .shippingAddressController.isLoading1.value
                                ? const Center(
                                    child: CircularProgressIndicator())
                                : controller.shippingAddressController
                                        .addressList.isNotEmpty
                                    ? Text(
                                        controller.shippingAddressController
                                                    .defaultAddress !=
                                                null
                                            ? controller
                                                .shippingAddressController
                                                .formatAddress(controller
                                                    .shippingAddressController
                                                    .defaultAddress!)
                                            : controller
                                                .shippingAddressController
                                                .formatAddress(controller
                                                    .shippingAddressController
                                                    .addressList[0]),
                                        style: FontStyle.black14,
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    : Text(
                                        "No address found",
                                        style: FontStyle.black14,
                                      ),
                          ),
                          IconButton(
                            onPressed: () =>
                                Get.to(() => const ShippingAddressScreen()),
                            icon: const Icon(Icons.arrow_drop_down),
                          )
                        ],
                      ),
                    ],
                  ),
                ),

                customHeight10,
                Obx(() {
                  return !controller.showPaymentSection.value
                      ? Column(
                          children: [
                            CustomTextFormField2(
                              hintText: 'Apply Coupons / Promo Code',
                              topLabelText: 'Coupon Code & Promo Code',
                              hintStyle: FontStyle.black16,
                              controller: controller.couponController,
                              fillColor: CustomColor.white,
                              filled: true,
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              enableBorder: const OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              validator: (value) =>
                                  FieldValidator(context).couponCode(value),
                              suffixIcon: InkWell(
                                onTap: () {
                                  if (controller.couponKey.currentState!
                                      .validate()) {
                                    controller.couponCodeApi();
                                  }
                                },
                                child: CustomContainerButton(
                                  height: double.infinity,
                                  padding: const EdgeInsets.all(8.0),
                                  borderRadius: BorderRadius.circular(10),
                                  child: Obx(
                                    () => controller.isLoadingApply.value
                                        ? LoadingAnimationWidget.flickr(
                                            size: 30,
                                            leftDotColor: Colors.white,
                                            rightDotColor: Colors.pink)
                                        : Text(
                                            "Apply",
                                            style: FontStyle.white18,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                            customHeight10,
                            Obx(
                              () => controller.cartItmes.isEmpty
                                  ? const Center(child: Text("No Data Found"))
                                  : SizedBox(
                                      height: screenHeight * 0.25,
                                      child: ListView.builder(
                                        itemCount: controller.cartItmes.length,
                                        itemBuilder: (context, index) {
                                          final cartItem =
                                              controller.cartItmes[index];
                                          return InkWell(
                                            onTap: () {
                                              final productId =
                                                  cartItem['product_id']
                                                      .toString();
                                              Get.to(
                                                  () =>
                                                      const ProductDetailScreen(),
                                                  arguments: {
                                                    'product_id': productId
                                                  });
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.all(4.0),
                                              padding:
                                                  const EdgeInsets.all(20.0),
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
                                                ],
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Stack(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(12),
                                                        child: InkWell(
                                                          onTap:
                                                              controller
                                                                      .isLoading
                                                                      .value
                                                                  ? null
                                                                  : () {
                                                                      Get.defaultDialog(
                                                                        barrierDismissible:
                                                                            false,
                                                                        middleText:
                                                                            'Are you sure you want to remove this item from your cart?',
                                                                        buttonColor:
                                                                            CustomColor.redshadeColor,
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
                                                                  spreadRadius:
                                                                      2,
                                                                  blurRadius: 2,
                                                                  offset:
                                                                      const Offset(
                                                                          1, 3),
                                                                ),
                                                              ],
                                                            ),
                                                            child:
                                                                Image.network(
                                                              cartItem[
                                                                      'product_image'] ??
                                                                  '',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      // Positioned(
                                                      //   bottom: 4,
                                                      //   left: 4,
                                                      //   child: InkWell(
                                                      //     onTap:
                                                      //         controller
                                                      //                 .isLoading
                                                      //                 .value
                                                      //             ? null
                                                      //             : () {
                                                      //                 Get.defaultDialog(
                                                      //                   barrierDismissible:
                                                      //                       false,
                                                      //                   middleText:
                                                      //                       'Are you sure you want to remove this item from your cart?',
                                                      //                   buttonColor:
                                                      //                       CustomColor.redshadeColor,
                                                      //                   textConfirm:
                                                      //                       "Yes",
                                                      //                   textCancel:
                                                      //                       "No",
                                                      //                   onConfirm:
                                                      //                       () {
                                                      //                     Get.back();
                                                      //                     controller
                                                      //                         .deleteMyCartApi(cartItem['product_id'].toString());
                                                      //                   },
                                                      //                   onCancel:
                                                      //                       () {
                                                      //                     // Get.back();
                                                      //                   },
                                                      //                 );
                                                      //               },
                                                      //     child:
                                                      //         const CircleAvatar(
                                                      //       backgroundColor:
                                                      //           Colors.white,
                                                      //       radius: 12,
                                                      //       child: Icon(
                                                      //           Icons
                                                      //               .delete_outline_outlined,
                                                      //           size: 16,
                                                      //           color:
                                                      //               Colors.red),
                                                      //     ),
                                                      //   ),
                                                      // ),
                                              
                                                    ],
                                                  ),
                                                  customwidth20,
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          cartItem[
                                                                  'product_name']
                                                              .toString(),
                                                          style: FontStyle
                                                              .black17w400,
                                                          maxLines: 2,
                                                        ),
                                                        Text(
                                                          cartItem['price']!,
                                                          style: FontStyle
                                                              .redshad16,
                                                        ),
                                                        Text(
                                                            "All Issue easy returns",
                                                            style: FontStyle
                                                                .grettext14w500),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                "Qty: ${cartItem['qty']!}",
                                                                style: FontStyle
                                                                    .blacks14w500),
                                                            customwidth20,
                                                            // Obx(
                                                            //   () => Transform
                                                            //       .scale(
                                                            //     scale: 0.8,
                                                            //     child: Checkbox(
                                                            //       value: controller
                                                            //           .selectedItems
                                                            //           .contains(
                                                            //               cartItem),
                                                            //       onChanged:
                                                            //           (bool?
                                                            //               value) {
                                                            //         if (value ==
                                                            //             true) {
                                                            //           controller
                                                            //               .selectedItems
                                                            //               .add(
                                                            //                   cartItem);
                                                            //         } else {
                                                            //           controller
                                                            //               .selectedItems
                                                            //               .remove(
                                                            //                   cartItem);
                                                            //         }
                                                            //         controller
                                                            //             .calculateTotal();
                                                            //       },
                                                            //     ),
                                                            //   ),
                                                            // ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                            ),
                          ],
                        )
                      : Column(
                          children: [
                            RadioMenuButton(
                                value: true,
                                groupValue: true,
                                onChanged: (value) {
                                  controller.togglePayment();
                                },
                                child: Text("Cash On Delivery",
                                    style: FontStyle.black16))
                          ],
                        );
                }),

                customHeight10,
                Container(
                  // height: screenHeight * 0.2,
                  width: double.infinity,
                  margin: const EdgeInsets.all(4.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: const Offset(1, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Order Summary", style: FontStyle.black18),
                      customHeight10,
                      Obx(() => rowwidget(
                          title: 'Sub Total',
                          value:
                              '₹ ${(controller.couponDiscount.value > 0 ? controller.newtotalAmount.value : controller.totalAmount.value).toStringAsFixed(2)}')),
                      rowwidget(title: 'Delivery Charge', value: 'Free'),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Total Amount", style: FontStyle.black16),
                            Flexible(
                              child: Obx(() => Text(
                                    "₹ ${(controller.couponDiscount.value > 0 ? controller.newtotalAmount.value : controller.totalAmount.value).toStringAsFixed(2)}",
                                    style: FontStyle.black16,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                customHeight50,
                customHeight50,
              ],
            ),
          ),
        ),
      ),
    ),
       Obx(() => controller.isLoading.value
        ? Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : const SizedBox.shrink(),
    ),
    
  
      ],
    );
    
   }
}

Widget rowwidget({required String title, required String value}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: FontStyle.greyshade14),
        Text(value, style: FontStyle.greyshade14),
      ],
    ),
  );
}
Widget _buildStep({
  required int stepIndex,
  required String title,
  required bool isDone,
  required bool isActive,
}) {
  print('StepIndex: $stepIndex, isDone: $isDone, isActive: $isActive');
  return Column(
    children: [
      CircleAvatar(
        radius: 18,
        backgroundColor: isDone
            ? Colors.green
            : isActive
                ? Colors.blue
                : Colors.grey[300],
        child: isDone
            ? const Icon(Icons.check, color: Colors.white, size: 18)
            : Text(
                "${stepIndex + 1}",
                style: TextStyle(
                  color: isActive ? Colors.white : Colors.black,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
      ),
      const SizedBox(height: 6),
      Text(
        title,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
          color: isActive ? Colors.blue : Colors.black,
        ),
      ),
    ],
  );
}


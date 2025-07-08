import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_screen.dart';
import 'package:juyelari/Features/Screens/review_order_details/review_order_details_controller.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';

class ReviewOrderDetailsScreen extends StatelessWidget {
  const ReviewOrderDetailsScreen({super.key});
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
    final ReviewOrderDetailsController controller =
        Get.put(ReviewOrderDetailsController());
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    controller.mycartApi();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
        title: 'Review Your Order',
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () => Get.back(),
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: [
          /// Step Indicator
          Obx(() => Row(
                children:
                    List.generate(controller.steps.length * 2 - 1, (index) {
                  if (index.isOdd) {
                    return const Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4),
                        child: DottedLine(
                          dashLength: 5,
                          dashColor: Colors.grey,
                          lineThickness: 2,
                        ),
                      ),
                    );
                  } else {
                    int stepIndex = index ~/ 2;
                    bool isDone = controller.currentStep.value > stepIndex;
                    bool isActive = controller.currentStep.value == stepIndex;

                    return Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (controller.canGoToStep(stepIndex)) {
                              controller.goToStep(stepIndex);
                            }
                          },
                          child: CircleAvatar(
                            radius: 18,
                            backgroundColor: isDone
                                ? Colors.green
                                : isActive
                                    ? Colors.blue
                                    : Colors.grey[300],
                            child: isDone
                                ? const Icon(Icons.check,
                                    color: Colors.white, size: 18)
                                : Text(
                                    "${stepIndex + 1}",
                                    style: TextStyle(
                                      color: isActive
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          controller.steps[stepIndex],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isActive ? FontWeight.bold : FontWeight.normal,
                            color: isActive ? Colors.blue : Colors.black,
                          ),
                        ),
                      ],
                    );
                  }
                }),
              )),

          const SizedBox(height: 20),

          Obx(() {
            int step = controller.currentStep.value;
            String title = controller.steps[step];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("Current Step: $title",
                      style: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 10),
                if (step == 0 && !controller.isReviewDone.value)
                  ElevatedButton(
                    onPressed: controller.completeReview,
                    child: const Text("Mark Review as Done"),
                  ),
              ],
            );
          }),

          const SizedBox(height: 10),

          Obx(() {
            if (!controller.isReviewDone.value) return const SizedBox.shrink();
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: controller.currentStep.value > 0
                      ? controller.previousStep
                      : null,
                  child: const Text('Back'),
                ),
                ElevatedButton(
                  onPressed: controller.currentStep.value <
                              controller.steps.length - 1 &&
                          controller
                              .canGoToStep(controller.currentStep.value + 1)
                      ? controller.nextStep
                      : null,
                  child: const Text('Next'),
                ),
              ],
            );
          }),

          const SizedBox(height: 20),

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
                      child: Text(
                        "26, Duong So 2, Thao Dien Ward, An Phu, District 2, Ho Chi Minh city",
                        style: FontStyle.black14,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
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
          // customHeight15,
          customHeight15,
          CustomTextFormField2(
            onTap: () {
              controller.couponCodeApi();
            },
            hintText: 'Apply Coupons / Promo Code',
            topLabelText: 'Coupon Code & Promo Code',
            hintStyle: FontStyle.black16,
            controller: controller.couponController,
            fillColor: CustomColor.white,
            filled: true,
            border: const OutlineInputBorder(borderSide: BorderSide.none),
            focusBorder: const OutlineInputBorder(borderSide: BorderSide.none),
            enableBorder: const OutlineInputBorder(borderSide: BorderSide.none),
            suffixIcon: CustomContainerButton(
              height: double.infinity,
              padding: const EdgeInsets.all(8.0),
              borderRadius: BorderRadius.circular(10),
              child: Text(
                "Apply",
                style: FontStyle.white18,
              ),
            ),
          ),
          customHeight15,

          Obx(
            () => controller.cartItmes.isEmpty
                ? const Text("No Data Found")
                : SizedBox(
                    height: screenHeight * 0.35,
                    child: ListView.builder(
                      itemCount: controller.cartItmes.length,
                      itemBuilder: (context, index) {
                        final cartItem = controller.cartItmes[index];
                        final isSelected =
                            controller.selectedItems.contains(cartItem);
                        return Container(
                            margin: const EdgeInsets.all(4.0),
                            padding: const EdgeInsets.all(20.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                    color: Colors.grey.withOpacity(0.1)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: const Offset(1, 3),
                                  ),
                                ]),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Obx(
                                        () => InkWell(
                                          onTap: controller.isLoading.value
                                              ? null
                                              : () {
                                                  Get.defaultDialog(
                                                    middleText:
                                                        'Are you sure you want to remove this item from your cart?',
                                                    buttonColor: CustomColor
                                                        .redshadeColor,
                                                    textConfirm: "Yes",
                                                    textCancel: "No",
                                                    onConfirm: () {
                                                      Get.back();
                                                      controller.deleteMyCartApi(
                                                          cartItem['product_id']
                                                              .toString());
                                                    },
                                                    onCancel: () {
                                                      Get.back();
                                                    },
                                                  );
                                                },
                                          child: Container(
                                            height: 120,
                                            width: 120,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
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
                                            child: Image.network(
                                              cartItem['product_image'] ?? '',
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 4,
                                      left: 4,
                                      child: InkWell(
                                        onTap: () {},
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            shape: BoxShape.circle,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                              Icons.delete_outline_outlined,
                                              size: 16,
                                              color: Colors.red),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                customwidth20,
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        cartItem['product_name'].toString(),
                                        style: FontStyle.black17w400,
                                        maxLines: 2,
                                        softWrap: true,
                                      ),
                                      Text(
                                        cartItem['price']!,
                                        style: FontStyle.redshad16,
                                      ),
                                      Text(
                                        "All Issue easy returns",
                                        style: FontStyle.grettext14w500,
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Text(
                                          //   "Size: Free Size",
                                          //   style: FontStyle.black14w500,
                                          // ),
                                          // customwidth20,
                                          Text("Qty: ${cartItem['qty']!}",
                                              style: FontStyle.blacks14w500),
                                      customwidth20,
                                      Obx(()=>
                                        Transform.scale(
                                          scale: 0.8,
                                          child: Checkbox(
                                             value: controller.selectedItems.contains(cartItem),
                                              visualDensity: VisualDensity.compact, 
                                                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                             onChanged: (bool? value) {
                                               if (value == true) {
                                                 controller.selectedItems.add(cartItem);
                                               } else {
                                                 controller.selectedItems.remove(cartItem);
                                               }
                                               controller.calculateTotal(); 
                                             },
                                           ),
                                        ),
                                       ),
                                       
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ));
                      },
                    ),
                  ),
          ),

          customHeight10,

          Container(
            height: screenHeight * 0.2,
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
                Obx(
                  () => rowwidget(
                      title: 'Sub Total ',
                      value:
                          '₹ ${(controller.couponDiscount.value > 0 ? controller.newtotalAmount.value : controller.totalAmount.value).toStringAsFixed(2)}'),
                ),
                rowwidget(title: 'Delivery Charge', value: 'Free'),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Amount",
                        style: FontStyle.black16,
                      ),
                      Obx(
                        () => Text(
                          "₹ ${(controller.couponDiscount.value > 0 ? controller.newtotalAmount.value : controller.totalAmount.value).toStringAsFixed(2)}",
                          style: FontStyle.black16,
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
                border: Border.all(color: Colors.grey.withOpacity(0.1)),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () => Text(
                        "₹ ${(controller.couponDiscount.value > 0 ? controller.newtotalAmount.value : controller.totalAmount.value).toStringAsFixed(2)}",
                        style: FontStyle.black18,
                      ),
                    ),
                    customHeight10,
                    Obx(
                      () => Text("(${controller.cartItmes.length} items)",
                          style: FontStyle.black14),
                    ),
                  ],
                ),
                CustomContainerButton(
                  onTap: () {
                    Get.to(() => const ReviewOrderDetailsScreen());
                  },
                  width: screenWidth * 0.42,
                  padding: const EdgeInsets.all(15.0),
                  borderRadius: BorderRadius.circular(50),
                  child: Center(
                    child: Text(
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
    );
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
}

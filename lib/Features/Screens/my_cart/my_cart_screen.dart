import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_controller.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_screen.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';

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
    final screenWidth = MediaQuery.of(context).size.width;
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomWidgets().customAppBar(
          title: 'My Cart',
          leadingIcon: Icons.arrow_back_ios,
          onLeadingPressed: () {
            Get.back();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Container(
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
                            onPressed: () {
                              Get.to(() => const ShippingAddressScreen());
                            },
                            icon: const Icon(Icons.arrow_drop_down))
                      ],
                    )
                  ],
                ),
              ),
              customHeight10,
              Expanded(
                // height: 200,
                child: ListView.builder(
                  itemCount: controller.products.length,
                  itemBuilder: (context, index) {
                    final product = controller.products[index];
                    return Container(
                        margin: const EdgeInsets.all(4.0),
                        padding: const EdgeInsets.all(20.0),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                          color: Colors.grey.withOpacity(0.1)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 2,
                                          offset: const Offset(1, 3),
                                        ),
                                      ],
                                    ),
                                    child: Image.asset(
                                      product['image']!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 4,
                                  left: 4,
                                  child: GestureDetector(
                                    onTap: () {
                                      // controller.removeProduct(index); // Your delete logic
                                    },
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['title'].toString(),
                                    style: FontStyle.black17w400,
                                    maxLines: 2,
                                    softWrap: true,
                                  ),
                                  Text(
                                    product['price']!,
                                    style: FontStyle.redshad16,
                                  ),
                                  Text(
                                    product['return']!,
                                    style: FontStyle.grettext14w500,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Size: ${product['size']!}",
                                        style: FontStyle.black14w500,
                                      ),
                                      customwidth20,
                                      Text("Qty: ${product['qty']!}",
                                          style: FontStyle.blacks14w500),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ));
                  },
                ),
              ),
              customHeight10,
              Container(
                height: screenheight * 0.2,
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
                    rowwidget(title: 'Sub Total ', value: '₹1749'),
                    rowwidget(title: 'Delivery Charge', value: 'Free'),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total Amount",
                            style: FontStyle.black16,
                          ),
                          Text(
                            "₹ 1749",
                            style: FontStyle.black16,
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
                        Text(
                          "₹ 1749",
                          style: FontStyle.black18,
                        ),
                        customHeight10,
                        Text("(3 items)", style: FontStyle.black14),
                      ],
                    ),
                    CustomContainerButton(
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
        ));
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

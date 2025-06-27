import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_order_screen/my_order_controller.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';

class MyOrderScreen extends GetView<MyOrderController> {
  const MyOrderScreen({super.key});
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
    final screenheight = MediaQuery.of(context).size.height;

    Get.lazyPut(() => MyOrderController());
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: CustomWidgets().customAppBar(
          title: 'My Order',
          leadingIcon: Icons.arrow_back_ios,
          onLeadingPressed: () {
            Get.back();
          },
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            children: [
              customHeight10,
              Obx(
                () => SizedBox(
                  height: screenheight * 0.04,
                  child: Row(
                      children: List.generate(controller.myorderupdate.length,
                          (index) {
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          controller.selectedIndex.value = index;
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          padding: const EdgeInsets.all(8.0),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: controller.selectedIndex.value == index
                                  ? CustomColor.yellowshade
                                  : CustomColor.white),
                          child: Text(
                            controller.myorderupdate[index],
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: controller.selectedIndex.value == index
                                  ? CustomColor.white
                                  : CustomColor.blackColor,
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
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
                                // Positioned(
                                //   bottom: 4,
                                //   left: 4,
                                //   child: GestureDetector(
                                //     onTap: () {
                                //       // controller.removeProduct(index); // Your delete logic
                                //     },
                                //     child: Container(
                                //       decoration: const BoxDecoration(
                                //         color: Colors.white,
                                //         shape: BoxShape.circle,
                                //       ),
                                //       padding: const EdgeInsets.all(4),
                                //       child: const Icon(
                                //           Icons.delete_outline_outlined,
                                //           size: 16,
                                //           color: Colors.red),
                                //     ),
                                //   ),
                                // )
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/product_screen/product_controller.dart';
import 'package:juyelari/Features/Screens/product_screen/product_details/product_detail_screen.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_image_slider/custom_image_carousel.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';

class ProductScreen extends GetView<ProductController> {
  const ProductScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
        title: controller.getname?['name'] ?? 'Unnamed',
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Get.back();
        },
        actions: [
          Icon(Icons.favorite_outline,
              size: 25, color: CustomColor.yellowshade),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 18,
              backgroundColor: CustomColor.redshadeColor,
              child: Icon(
                Icons.shopping_cart,
                color: CustomColor.white,
                size: 16,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextFormField2(
              contentPadding: const EdgeInsets.all(8.0),
              controller: controller.searchController1,
              hintText: 'Search Product',
              hintStyle: FontStyle.greytext14,
              prefixIcon: Icon(
                Icons.search,
                color: CustomColor.blackColor,
                size: 25,
              ),
              // fillColor: CustomColor.whiteshade,

              // filled: true,
              border: InputBorder.none,
              focusBorder: InputBorder.none,
              enableBorder: InputBorder.none,
              errorBorder: InputBorder.none,
            ),
            height10,
            Stack(
              children: [
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: CustomImageSlider(
                      imageList: controller.imageUrls,
                      imageController: controller.sliderCarouselController,
                      imageUrl:
                          controller.imageUrls[controller.currentIndex.value],
                      onPageChanged: (index, reason) {
                        controller.currentIndex.value = index;
                      },
                    ),
                  ),
                ),
                Positioned(
                    bottom: 25,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:
                          List.generate(controller.imageUrls.length, (index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width:
                              controller.currentIndex.value == index ? 10 : 8,
                          height:
                              controller.currentIndex.value == index ? 10 : 8,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: controller.currentIndex.value == index
                                ? CustomColor.blackColor
                                : Colors.white,
                          ),
                        );
                      }),
                    )),
              ],
            ),
            height10,
            Text(
              "Earrings",
              style: FontStyle.redshad16,
            ),
            Text(
              "(249 Results)",
              style: FontStyle.greyshadetextw400,
            ),
            height10,
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.servicetext.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.all(4.0),
                      margin: const EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: CustomColor.greycolor.withOpacity(0.2),
                              width: 1),
                          // boxShadow: [
                          //   BoxShadow(
                          //     color: Colors.grey.withOpacity(0.1),
                          //     spreadRadius: 0,
                          //     blurRadius: 0,
                          //     offset: const Offset(0, 2),
                          //   ),
                          // ],
                          color: CustomColor.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Text(
                          controller.servicetext[index],
                          style: FontStyle.greyshadetextw400,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            height20,
            Expanded(
              child: GridView.builder(
                itemCount: controller.itemdetails.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 15,
                    childAspectRatio: 1 / 1.5),
                itemBuilder: (context, index) {
                  final imagePath =
                      controller.itemdetails[index]['image'];
                  final title = controller.itemdetails[index]['title'];
                  return InkWell(
                    onTap: () {
                      Get.to(() =>  ProductDetailScreen(),
                          arguments: {'image': imagePath, 'title': title});
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 190,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(1, 3),
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.asset(
                                  controller.itemdetails[index]['image'],
                                  height: 190,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: 12,
                                right: 10,
                                child: CircleAvatar(
                                  radius: 12,
                                  backgroundColor: CustomColor.pinkfavcolor,
                                  child: Icon(
                                    Icons.favorite_border_outlined,
                                    color: CustomColor.redshadeColor,
                                    size: 16,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 4),
                                      Text(
                                        controller.itemdetails[index]
                                                ['rating'] ??
                                            '4.5',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                      width5,
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 14,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        height10,
                        Expanded(
                          child: Text(
                            controller.itemdetails[index]['title'],
                            style: FontStyle.black16w400,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Text(
                            '₹${controller.itemdetails[index]['rate']}',
                            style: FontStyle.redshadew600,
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

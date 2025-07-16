import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/Profile_screen/profile_screen.dart';
import 'package:juyelari/Features/Screens/dashboard_screen/all_product_screen/all_product_screen.dart';
import 'package:juyelari/Features/Screens/dashboard_screen/dashboard_controller.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_controller.dart';
import 'package:juyelari/Features/Screens/my_cart/my_cart_screen.dart';
import 'package:juyelari/Features/Screens/product_screen/product_details/product_detail_screen.dart';
import 'package:juyelari/Features/Screens/product_screen/product_screen.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_image_slider/custom_image_carousel.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});
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
    Get.lazyPut(() => DashboardController());
    final MyCartController myCartController = Get.put(MyCartController());
    controller.dashboardApi();
    myCartController.mycartApi();
    final screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: Builder(
            builder: (context) => IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                )),
          ),
          leadingWidth: 50,
          title: Text(
            "Jewels",
            style: FontStyle.redshade20w600,
          ),
          actions: [
            const Icon(
              Icons.search,
              size: 28,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Obx(() {
                  int count = myCartController.cartItmes.length;
                  return Stack(alignment: Alignment.topRight, children: [
                    CircleAvatar(
                      radius: 18,
                      backgroundColor: CustomColor.redshadeColor,
                      child: IconButton(onPressed: (){
                        Get.to(()=> const MyCartScreen());
                      }, 
                      icon: Icon(
                        Icons.shopping_cart,
                        color: CustomColor.white,
                        size: 20,
                      ),)
                    ),
                    if (count > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            '$count',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                  ]);
                }))
          ],
        ),
        drawer: const ProfileScreen(),
        body: Column(
          children: [
            Container(
              height: 90,
              color: Colors.transparent,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 5),
                    child: Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        Text(
                          "Update Delivery Pincode",
                          style: FontStyle.greytext14,
                        )
                      ],
                    ),
                  ),
                  height10,
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
                      // fillColor: CustomColor.whiteshade,

                      // filled: true,
                      border: InputBorder.none,
                      focusBorder: InputBorder.none,
                      enableBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                  ),
                ],
              ),
            ),
            customHeight5,
            Expanded(
                child: Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.dashboardData.isEmpty
                      ? const Center(child: Text("No Data Found"))
                      : ListView(
                          children: [
                            controller.sliders.isEmpty
                                ? const Center(child: Text("No Data Found"))
                                : Stack(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(6),
                                          border: Border.all(
                                              color:
                                                  Colors.grey.withOpacity(0.1)),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.1),
                                              spreadRadius: 2,
                                              blurRadius: 2,
                                              offset: const Offset(1, 3),
                                            ),
                                          ],
                                        ),
                                        child: Obx(() {
                                          return CustomImageSlider(
                                            height: 220,
                                            imageList: controller.sliders
                                                .map((e) => e['image_url'])
                                                .toList(),
                                            imageController: controller
                                                .sliderCarouselController,
                                            imageUrl: controller.sliders[
                                                controller.currentIndex
                                                    .value]['image_url'],
                                            onPageChanged: (index, reason) {
                                              controller.currentIndex.value =
                                                  index;
                                            },
                                          );
                                        }),
                                      ),
                                      Positioned(
                                          bottom: 28,
                                          left: 0,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                                controller.sliders.length,
                                                (index) {
                                              return Obx(
                                                () => Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(horizontal: 4),
                                                  width: controller.currentIndex
                                                              .value ==
                                                          index
                                                      ? 10
                                                      : 8,
                                                  height: controller
                                                              .currentIndex
                                                              .value ==
                                                          index
                                                      ? 10
                                                      : 8,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: controller
                                                                .currentIndex
                                                                .value ==
                                                            index
                                                        ? CustomColor.blackColor
                                                        : Colors.white,
                                                  ),
                                                ),
                                              );
                                            }),
                                          )),
                                    ],
                                  ),
                            height10,
                            SizedBox(
                              height: 110,
                              child: Obx(
                                () => controller.categories.isEmpty
                                    ? const Center(child: Text("No Data Found"))
                                    : ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: controller.categories.length,
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                            onTap: () {
                                              Get.to(
                                                  () => const ProductScreen(),
                                                  arguments: {
                                                    'name': controller
                                                            .categories[index]
                                                        ['name'],
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Container(
                                                height: 110,
                                                width: 90,
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  // shape: BoxShape.rectangle,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.grey
                                                          .withOpacity(0.15)),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.15),
                                                      spreadRadius: 1,
                                                      blurRadius: 1,
                                                      offset:
                                                          const Offset(0, 3),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    Image.network(
                                                      controller.categories[
                                                                  index]
                                                              ['image_url'] ??
                                                          '',
                                                      height: 68,
                                                      width: 90,
                                                      fit: BoxFit.cover,
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return const SizedBox(
                                                          height: 68,
                                                          width: 90,
                                                          child: Center(
                                                            child:
                                                                CircularProgressIndicator(
                                                              strokeWidth: 2,
                                                              valueColor:
                                                                  AlwaysStoppedAnimation<
                                                                          Color>(
                                                                      Colors
                                                                          .grey),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                        'assets/images/loginpic.png',
                                                        height: 68,
                                                        width: 90,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    height10,
                                                    Text(
                                                      controller
                                                              .categories[index]
                                                          ['name'],
                                                      style:
                                                          FontStyle.greytext14,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: true,
                                                      maxLines: 1,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                              ),
                            ),
                            height10,
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Featured Products",
                                    style: FontStyle.black18,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      if (controller
                                          .featuredProduct.isNotEmpty) {
                                        Get.to(() => const AllProductScreen(),
                                            arguments: {
                                              'featuredProduct': controller
                                                  .featuredProduct
                                                  .toList()
                                            });
                                      } else {
                                        CustomWidgets()
                                            .toast("No Data Found", Colors.red);
                                      }
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "See All",
                                          style: FontStyle.black16,
                                        ),
                                        customwidth5,
                                        CircleAvatar(
                                          radius: 16,
                                          backgroundColor:
                                              CustomColor.redshadeColor,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            color: CustomColor.white,
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: screenheight * 0.25,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              color: Colors.transparent,
                              child: Obx(() {
                                final allProducts = controller.featuredProduct;
                                final limitedProducts = allProducts.length > 2
                                    ? allProducts.sublist(0, 2)
                                    : allProducts;

                                return limitedProducts.isEmpty
                                    ? const Center(child: Text("No Data Found"))
                                    : GridView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: limitedProducts.length,
                                        gridDelegate:
                                            const SliverGridDelegateWithFixedCrossAxisCount(
                                          mainAxisSpacing: 2,
                                          crossAxisCount: 2,
                                          childAspectRatio: 1 / 1.25,
                                        ),
                                        itemBuilder: (context, index) {
                                          final product =
                                              limitedProducts[index];
                                          return Column(
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Get.to(
                                                      () =>
                                                          const ProductDetailScreen(),
                                                      arguments: {
                                                        "product_id":
                                                            product['id']
                                                      });
                                                },
                                                child: Container(
                                                  height: 200,
                                                  width: double.infinity,
                                                  margin:
                                                      const EdgeInsets.all(8.0),
                                                  decoration: BoxDecoration(
                                                    // color: Colors.green,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: Colors.grey
                                                            .withOpacity(0.1)),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.1),
                                                        spreadRadius: 0.2,
                                                        blurRadius: 0.2,
                                                        offset:
                                                            const Offset(0, 1),
                                                      ),
                                                    ],
                                                  ),
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                      product['image_url'] ??
                                                          '',
                                                      fit: BoxFit.cover,
                                                      // Show CircularProgressIndicator while loading
                                                      loadingBuilder: (context,
                                                          child,
                                                          loadingProgress) {
                                                        if (loadingProgress ==
                                                            null) return child;
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 2,
                                                            valueColor:
                                                                AlwaysStoppedAnimation<
                                                                        Color>(
                                                                    Colors
                                                                        .grey),
                                                          ),
                                                        );
                                                      },
                                                      // Show fallback if loading fails
                                                      errorBuilder: (context,
                                                              error,
                                                              stackTrace) =>
                                                          Image.asset(
                                                        'assets/images/loginpic.png',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(horizontal: 8),
                                                  child: Text(
                                                    product['name'] ?? '',
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        },
                                      );
                              }),
                            ),
                            height5,
                            Padding(
                              padding: const EdgeInsets.only(left: 12),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    " Offers & Deals",
                                    style: FontStyle.black18,
                                  ),
                                ],
                              ),
                            ),
                            height10,
                            Container(
                              height: 240,
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
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
                                    child: Obx(() {
                                      if (controller.brands.isEmpty) {
                                        return const Center(
                                            child: Text("No Data Found"));
                                      }
                                      return CustomImageSlider(
                                        height: 220,
                                        imageList: controller.brands
                                            .map((e) => e['image_url'])
                                            .toList(),
                                        imageController: controller
                                            .sliderCarouselController1,
                                        imageUrl: controller.brands[controller
                                            .currentIndex1.value]['image_url'],
                                        onPageChanged: (index, reason) {
                                          controller.currentIndex1.value =
                                              index;
                                        },
                                      );
                                    }),
                                  ),
                                  Positioned(
                                      bottom: 28,
                                      left: 0,
                                      right: 0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: List.generate(
                                            controller.brands.length, (index) {
                                          return Obx(
                                            () => Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              width: controller.currentIndex1
                                                          .value ==
                                                      index
                                                  ? 10
                                                  : 8,
                                              height: controller.currentIndex1
                                                          .value ==
                                                      index
                                                  ? 10
                                                  : 8,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: controller.currentIndex1
                                                            .value ==
                                                        index
                                                    ? CustomColor.blackColor
                                                    : Colors.white,
                                              ),
                                            ),
                                          );
                                        }),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
            ))
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/dashboard_screen/dashboard_controller.dart';
import 'package:juyelari/Features/Screens/favourite/favourite_controller.dart';
import 'package:juyelari/Features/Screens/product_screen/product_controller.dart';
import 'package:juyelari/Features/Screens/product_screen/product_details/product_detail_screen.dart';
import 'package:juyelari/Features/provider/api_provider.dart';
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
    final DashboardController dashboardController = Get.put(DashboardController());
        final FavouriteController favouriteController = Get.put(FavouriteController());

    
    // Ensure ApiProvider is registered before ProductController uses it
    if (!Get.isRegistered<ApiProvider>()) {
      Get.put(ApiProvider());
    }
    Get.lazyPut(() => ProductController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
        title: controller.categoryData?['name'] ?? '',
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
                Obx(() {
                                          return CustomImageSlider(
                                            height: 220,
                                            imageList: dashboardController.sliders
                                                .map((e) => e['image_url'])
                                                .toList(),
                                            imageController: dashboardController
                                                .sliderCarouselController,
                                            imageUrl: dashboardController.sliders[
                                                controller.currentIndex
                                                    .value]['image_url'],
                                            onPageChanged: (index, reason) {
                                              controller.currentIndex.value =
                                                  index;
                                            },
                                          );
                                        }),
                      Positioned(
                              bottom: 28,
                                          left: 0,
                                          right: 0,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: List.generate(
                                                dashboardController.sliders.length,
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
            Text(
              controller.categoryData?['name'] ?? '',
              style: FontStyle.redshad16,
            ),
            Text(
              "(249 Results)",
              style: FontStyle.greyshadetextw400,
            ),
            height10,
            SizedBox(
              height: 48,
              child: Obx(() {
                if (controller.isLoading.value) {
                  return Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage.isNotEmpty) {
                  return Center(child: Text(controller.errorMessage.value, style: TextStyle(color: Colors.red)));
                } else if (controller.filterText.isEmpty) {
                  return Center(child: Text('No filters available'));
                }
                return Obx(() => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.filterText.length,
                  itemBuilder: (context, index) {
                    final isSelected = controller.selectedFilterIndex.value == index;
                    final range = controller.filterText[index].split('-');
                    final minPrice = range[0];
                    final maxPrice = range.length > 1 ? range[1] : '';
                    final chipText = (minPrice.isNotEmpty && maxPrice.isNotEmpty)
                        ? '₹$minPrice - ₹$maxPrice'
                        : (minPrice.isNotEmpty ? '₹$minPrice' : (maxPrice.isNotEmpty ? '₹$maxPrice' : controller.filterText[index]));
                    return Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Obx(() {
                        final isSelected = controller.selectedFilterIndex.value == index;
                        return InkWell(
                          onTap: () {
                            if (isSelected) {
                              controller.selectedFilterIndex.value = -1;
                              controller.selectedMinPrice.value = '';
                              controller.selectedMaxPrice.value = '';
                            } else {
                              controller.selectedFilterIndex.value = index;
                              controller.selectedMinPrice.value = minPrice;
                              controller.selectedMaxPrice.value = maxPrice;
                            }
                            controller.products.clear();
                            controller.currentPage.value = 1;
                            controller.fetchProducts();
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 18, ),
                            margin: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                    color: isSelected ? CustomColor.redshadeColor : CustomColor.greycolor.withOpacity(0.2),
                                    width: 2),
                                color: isSelected ? CustomColor.redshadeColor.withOpacity(0.7) : CustomColor.white,
                                boxShadow: isSelected ? [BoxShadow(color: CustomColor.redshadeColor.withOpacity(0.2), blurRadius: 6, spreadRadius: 1)] : []),
                            child: Center(
                              child: Text(
                                chipText,
                                style: isSelected ? FontStyle.white18 : FontStyle.greyshadetextw400,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ));
              }),
            ),
            height20,
            // Product Grid
            Expanded(
              child: Obx(() {
                if (controller.isProductLoading.value && controller.products.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                } else if (controller.errorMessage.isNotEmpty && controller.products.isEmpty) {
                  return Center(child: Text(controller.errorMessage.value, style: TextStyle(color: Colors.red)));
                } else if (controller.products.isEmpty) {
                  return const Center(child: Text('No products available'));
                }
                return NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
                        controller.hasMoreProducts.value &&
                        !controller.isProductLoading.value) {
                      controller.fetchProducts(loadMore: true);
                    }
                    return false;
                  },
                  child: GridView.builder(
                    padding: const EdgeInsets.only(top: 8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemCount: controller.products.length + (controller.hasMoreProducts.value ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == controller.products.length) {
                        return Center(child: CircularProgressIndicator());
                      }
                      final product = controller.products[index];
                      final productId = product['id'];
                      return Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => const ProductDetailScreen(), arguments: {"product_id": productId});
                            },
                            child: Stack(
                              children: [
                                Container(
                                  height: 160,
                                  width: double.infinity,
                                  margin: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: Colors.grey.withOpacity(0.1)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 0.2,
                                        blurRadius: 0.2,
                                        offset: const Offset(0, 1),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      product['image_url'] ?? '',
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, loadingProgress) {
                                        if (loadingProgress == null) return child;
                                        return const Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) => Image.asset(
                                        'assets/images/pic bangles.jpg',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 12,
                                  right: 12,
                                  child: Obx(() => GestureDetector(
                                    onTap: () {
                                      favouriteController.toggleFavourite(productId);
                                    },
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.white.withOpacity(0.8),
                                      child: Icon(
                                        favouriteController.favouriteMap[productId]?.value == true
                                            ? Icons.favorite
                                            : Icons.favorite_border_outlined,
                                        color: CustomColor.redshadeColor,
                                        size: 20,
                                      ),
                                    ),
                                  )),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      product['name'] ?? '',
                                      style: FontStyle.black12,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      softWrap: true,
                                    ),
                                  ),
                                  height5,
                                  Flexible(
                                    child: Text(
                                      '₹ ${product['price'] ?? '0'}',
                                      style: FontStyle.redshade12,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                 
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Screens/product_screen/product_details/product_detail_screen.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/Screens/favourite/favourite_controller.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;

  @override
  Widget build(BuildContext context) {
    final FavouriteController controller = Get.put(FavouriteController());
    controller.fetchFavouriteProducts();
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          title: Text(
            'Favourite Products',
            style: FontStyle.redshade20w600,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 16,
              )),
          actions: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.search,
                size: 28,
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: CircleAvatar(
            //     radius: 18,
            //     backgroundColor: CustomColor.redshadeColor,
            //     child: Icon(
            //       Icons.shopping_cart,
            //       color: CustomColor.white,
            //       size: 20,
            //     ),
            //   ),
            // ),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          if (controller.favouriteProducts.isEmpty) {
            return const Center(child: Text("No Data Found"));
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(8.0),
                  shrinkWrap: true,
                  itemCount: controller.favouriteProducts.length,
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.24,
                  ),
                  itemBuilder: (context, index) {
                    final product = controller.favouriteProducts[index];
                    final productId = product['product_id'];
                    // Ensure favouriteMap entry exists
                    if (!controller.favouriteMap.containsKey(productId)) {
                      controller.favouriteMap[productId] = true.obs;
                    }
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(() => const ProductDetailScreen(),
                                arguments: {"product_id": productId});
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                margin: const EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                      color: Colors.grey.withOpacity(0.1)),
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
                                    product['product_image'] ?? '',
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const Center(
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.grey),
                                        ),
                                      );
                                    },
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Image.asset(
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
                                    controller.toggleFavourite(productId);
                                  },
                                  child: CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Colors.white.withOpacity(0.8),
                                    child: Icon(
                                      controller.favouriteMap[productId]!.value ? Icons.favorite : Icons.favorite_border_outlined,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              product['product_name'] ?? '',
                              style: FontStyle.greytext14,
                              overflow: TextOverflow.visible,
                              softWrap: true,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              )
            ],
          );
        })
    );
  }
}

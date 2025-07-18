import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Screens/dashboard_screen/dashboard_controller.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DashboardController>();
    final featuredProducts = controller.featuredProduct;
    // Initialize favouriteMap based on is_wishlist
    for (var product in featuredProducts) {
      final productId = product['id'];
      final isWishlist = product['is_wishlist'] == 1;
      if (!controller.favouriteMap.containsKey(productId)) {
        controller.favouriteMap[productId] = RxBool(isWishlist);
      }
    }
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          leadingWidth: 40,
          title: Text(
            'Featured Products',
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
          actions: [
            const Icon(
              Icons.search,
              size: 28,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CircleAvatar(
                radius: 18,
                backgroundColor: CustomColor.redshadeColor,
                child: Icon(
                  Icons.shopping_cart,
                  color: CustomColor.white,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
        body: featuredProducts.isEmpty
            ? const Text("No Data Found")
            : CustomScrollView(
                slivers: [
                  // SliverToBoxAdapter(
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  //     child: Text(
                  //       "Featured Products",
                  //       style: FontStyle.black18,
                  //     ),
                  //   ),
                  // ),
                  SliverToBoxAdapter(
                    child: GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(8.0),
                      shrinkWrap: true,
                      itemCount: featuredProducts.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 10,
                        crossAxisCount: 2,
                        childAspectRatio: 1 / 1.24,
                      ),
                      itemBuilder: (context, index) {
                        final product = featuredProducts[index];
                        final productId = product['id'];
                        if (!controller.favouriteMap.containsKey(productId)) {
                          controller.favouriteMap[productId] = RxBool(product['is_wishlist'] == 1);
                        }
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                // controller.toggleFavourite(productId);
                                controller.addtofavourite(productId); 
                              },
                              child: Stack(
                                children: [
                                  Container(
                                    height: Get.height * 0.22,
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
                                        product['image_url'] ?? '',
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
                                          'assets/error.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 12,
                                    right: 12,
                                    child: Obx(() {
                                      final isFav = controller.favouriteMap[productId]?.value ?? false;
                                      return GestureDetector(
                                        onTap: () {
                                          controller.addtofavourite(productId);
                                        },
                                        child: CircleAvatar(
                                          radius: 16,
                                          backgroundColor: Colors.white.withOpacity(0.8),
                                          child: Icon(
                                            isFav ? Icons.favorite : Icons.favorite_border_outlined,
                                            color: CustomColor.redshadeColor,
                                            size: 20,
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  product['name'],
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
              ));
  }
}

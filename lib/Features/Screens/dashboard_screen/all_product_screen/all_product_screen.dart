import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/images.dart';
import 'package:juyelari/Features/Screens/product_screen/product_details/product_detail_screen.dart';
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
    final List<Map<String, dynamic>> featuredProducts =
        (Get.arguments['featuredProduct'] as List<Map<String, dynamic>>);
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
      leading:IconButton(onPressed: (){
         Get.back();
      },
       icon: Icon(Icons.arrow_back_ios,size: 16,)),
    
      
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
        body: CustomScrollView(
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
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.24,
                ),
                itemBuilder: (context, index) {
                  final product = featuredProducts[index];
                  return Column(
                    children: [
                      InkWell(
                        onTap: (){
                          Get.to(()=> const ProductDetailScreen(),arguments: {
                            "product_id":product['id']
                          });
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          margin: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            // color: Colors.green,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(color: Colors.grey.withOpacity(0.1)),
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
                            child: FadeInImage.assetNetwork(
                              placeholder: earingpic,
                              image: product['image_url'] ?? '',
                              fit: BoxFit.cover,
                              imageErrorBuilder: (context, error, stackTrace) {
                                return Image.asset(
                                  'assets/error.png',
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
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

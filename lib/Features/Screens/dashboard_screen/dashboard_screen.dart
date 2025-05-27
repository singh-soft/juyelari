import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Screens/dashboard_screen/dashboard_controller.dart';
import 'package:juyelari/Features/Screens/product_details/earring_detail_screen.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_image_slider/custom_fun_image_slider.dart';
import 'package:juyelari/Features/utils/custom_image_slider/custom_image_carousel.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';

import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';

class DashboardScreen extends GetView<DashboardController> {
  const DashboardScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => DashboardController());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const Icon(Icons.menu),
        leadingWidth: 50,
        title: Text(
          "Hi, Mona Nagar",
          style: FontStyle.balck20,
        ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
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
            Column(
              children: [
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
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CustomImageCarousel(
                        imagePaths: controller.imageUrls,
                        isAssets: true,
                        autoPlay: true,
                        sliderHeight: 220,
                        showIndicator: true,
                      ),
                    ),
                    // Positioned(
                    //     bottom: 25,
                    //     left: 0,
                    //     right: 0,
                    //     child: Row(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: List.generate(controller.imageUrls.length,
                    //           (index) {
                    //         return Container(
                    //           margin:
                    //               const EdgeInsets.symmetric(horizontal: 4),
                    //           width: controller.currentIndex.value == index
                    //               ? 10
                    //               : 8,
                    //           height: controller.currentIndex.value == index
                    //               ? 10
                    //               : 8,
                    //           decoration: BoxDecoration(
                    //             shape: BoxShape.circle,
                    //             color: controller.currentIndex.value == index
                    //                 ? CustomColor.blackColor
                    //                 : Colors.white,
                    //           ),
                    //         );
                    //       }),
                    //     )),
                  ],
                ),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.listimage.length,
                    itemBuilder: (context, index) {
                      final imagePath =
                          controller.listimage[index]['image'] ?? '';
                      final name =
                          controller.listimage[index]['name'] ?? 'Unnamed';
            
                      return InkWell(
                        onTap: () {
                          Get.to(() => const EarringDetailScreen(),
                              arguments: {
                                'name': name,
                              });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            children: [
                              Image.asset(
                                imagePath,
                                height: 68,
                                width: 68,
                              ),
                              Text(
                                name,
                                style: FontStyle.greytext14,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Featured Products",
                        style: FontStyle.black18,
                      ),
                      Row(
                        children: [
                          Text(
                            "See All",
                            style: FontStyle.black16,
                          ),
                          customwidth5,
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: CustomColor.redshadeColor,
                            child: Icon(
                              Icons.arrow_forward,
                              color: CustomColor.white,
                              size: 18,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                customHeight10,
                Column(
                  children: [
                    Container(
                      height: 300,
                      width: double.infinity,
                       padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
                      decoration: BoxDecoration(color: CustomColor.redshadeColor),
                      child: GridView.builder(
                        shrinkWrap: true,
                        // physics: const NeverScrollableScrollPhysics(),
                        itemCount: controller.gridimage.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                mainAxisSpacing: 16,
                                crossAxisSpacing: 5,
                                crossAxisCount: 3,
                                childAspectRatio: 1 / 1.2),
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: AssetImage(
                                      controller.gridimage[index]['image'])),
                            ),
                            child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(controller.gridimage[index]['name'])),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                height10,
                Padding(
                  padding: const EdgeInsets.only(left:12),
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
                Stack(
                  children: [
                  Obx(()=>
                     Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: CustomImageSlider(
                        imageList:controller.imageUrls, 
                        imageController: controller.sliderCarouselController, 
                        imageUrl: controller.imageUrls[controller.currentIndex.value],
                         onPageChanged: (index , reason ) { 
                          controller.currentIndex.value=index;
                          },),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    left: 0,
                    right: 0,
                    child:Obx(()=>
                       Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(controller.imageUrls.length, (index){
                          return Container(
                             margin:
                             const EdgeInsets.symmetric(horizontal: 4),
                            width: controller.currentIndex.value==index?10:8,
                            height:controller.currentIndex.value==index?10:8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: controller.currentIndex.value==index?CustomColor.blackColor:CustomColor.white
                            ),
                      
                          );
                        })
                      
                        
                      ),
                    ) )
                    


                  ],
                )
               
              ],
            ),
          ],
        ),
      ),
    );
  }
}

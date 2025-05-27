import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/product_details/earrring_detail_controller.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_image_slider/custom_fun_image_slider.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';

class EarringDetailScreen extends GetView<EarrringDetailController> {
  const EarringDetailScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => EarrringDetailController());
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
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
            // height10,
            Stack(
              children: [
                CustomImageCarousel(
                  imagePaths: controller.imageUrls.value,
                  isAssets: true,
                  autoPlay: true,
                  sliderHeight: 220,
                  showIndicator: true,
                ),
                // Positioned(
                //     bottom: 25,
                //     left: 0,
                //     right: 0,
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children:
                //           List.generate(controller.imageUrls.length, (index) {
                //         return Container(
                //           margin: const EdgeInsets.symmetric(horizontal: 4),
                //           width:
                //               controller.currentIndex.value == index ? 10 : 8,
                //           height:
                //               controller.currentIndex.value == index ? 10 : 8,
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
            Text(
              "Earrings",
              style: FontStyle.black18,
            ),
            Text(
              "(249 Results)",
              style: FontStyle.greyshadetextw400,
            ),
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.servicetext.length,
                itemBuilder: (context, index) {
                  return Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(6.0),
                    margin: const EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: CustomColor.yellowshade,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        controller.servicetext[index],
                        style: FontStyle.whitew500,
                      ),
                    ),
                  );
                },
              ),
            ),
            height10,
            Expanded(
              child: GridView.builder(
                itemCount: controller.itemdetails.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 6,
                    childAspectRatio: 1 / 1.428),
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.topRight,
                        height: 190,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(2, 3))
                          ],
                          image: DecorationImage(
                              image: AssetImage(
                                  controller.itemdetails[index]['image'])),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            right: 20,
                            top: 16,
                          ),
                          child: CircleAvatar(
                            radius: 12,
                            backgroundColor: CustomColor.white,
                            child: Icon(
                              Icons.favorite_border_outlined,
                              color: CustomColor.redshadeColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                controller.itemdetails[index]['title'],
                                style: FontStyle.blackw400,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.all(5.0),
                                  width: 45,
                                  decoration: BoxDecoration(
                                      gradient: const LinearGradient(
                                          begin: Alignment.centerLeft,
                                          end: Alignment.topRight,
                                          colors: <Color>[
                                            Colors.black,
                                            Color(0xff890E29),
                                            Colors.black
                                          ]),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                      child: Text(
                                    controller.itemdetails[index]['rating'],
                                    style: FontStyle.white8w400,
                                  )),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          '₹${controller.itemdetails[index]['rate']}',
                          style: FontStyle.redshadew600,
                        ),
                      )
                    ],
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

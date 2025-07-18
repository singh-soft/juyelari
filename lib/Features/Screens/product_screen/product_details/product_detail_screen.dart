import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/product_screen/product_details/product_details_controller.dart';
import 'package:juyelari/Features/utils/custom_container_button/custom_container_button.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProductDetailScreen extends GetView<ProductDetailsController> {
  const ProductDetailScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;
  final customwidth10 = width5;
  final customwidth20 = width20;
  final customwidth40 = width40;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ProductDetailsController());
    controller.productDetailsApi();
    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customwidth40,
          Expanded(
            child: FloatingActionButton(
              heroTag: "add_to_cart",
              backgroundColor: Colors.transparent,
              onPressed: () {
                controller.addtocartApi();
              },
              child: CustomContainerButton(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                borderRadius: BorderRadius.circular(50),
                child: Obx(
                  () => controller.isLoading1.value
                      ? Center(
                          child: LoadingAnimationWidget.flickr(
                              size: 30,
                              leftDotColor: Colors.white,
                              rightDotColor: Colors.pink),
                        )
                      : Text("Add To Cart",
                          style: FontStyle.white18,
                          textAlign: TextAlign.center),
                ),
              ),
            ),
          ),
          customwidth20,
          Expanded(
            child: FloatingActionButton(
              heroTag: "buy_now", // 👈 unique
              backgroundColor: Colors.transparent,
              onPressed: () {},
              child: CustomContainerButton(
                width: double.infinity,
                padding: const EdgeInsets.all(12.0),
                borderRadius: BorderRadius.circular(50),
                child: Text(
                  "Buy Now",
                  style: FontStyle.white18,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
        title: 'Product Details',
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Get.back();
        },
      ),
      body: Obx(
        () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : controller.allData.isEmpty
                ? const Center(child: Text("No Data Found"))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          controller.multipleImage.isEmpty
                              ? const Text("No Image Available")
                              : FanCarouselImageSlider.sliderType2(
                                  sliderHeight: 220,
                                  imagesLink:
                                      controller.multipleImage.cast<String>(),
                                  isAssets: false,
                                  autoPlay: true,
                                ),
                          Text(
                            "Product Details",
                            style: FontStyle.black18,
                          ),
                          height10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.allData['name'].toString(),
                                  style: FontStyle.black17w400,
                                  maxLines: 2,
                                  softWrap: true,
                                ),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.addtofavourite();
                                    },
                                    child: CircleAvatar(
                                        radius: 14,
                                        backgroundColor:
                                            CustomColor.pinkfavcolor,
                                        child: Obx(() => Icon(
                                              controller.isFavourite.value == false
                                                  ? Icons.favorite_border
                                                  : Icons.favorite,
                                              color: Colors.red,
                                            ))),
                                  ),
                                  customwidth10,
                                  customwidth5,
                                  CircleAvatar(
                                    radius: 14,
                                    backgroundColor: CustomColor.pinkfavcolor,
                                    child: Image.asset(
                                        'assets/images/iconshare.png'),
                                  ),
                                ],
                              )
                            ],
                          ),
                          customHeight10,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                ' ₹ ${controller.allData['price'].toString()}',
                                style: FontStyle.redshadew600,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: CustomColor.pinkfavcolor,
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: controller.decrement,
                                        icon: Icon(Icons.remove,
                                            color: CustomColor.redshadeColor)),
                                  ),
                                  customwidth10,
                                  Obx(() => Text(
                                        "${controller.quantity.value}",
                                        style: TextStyle(
                                            color: CustomColor.redshadeColor),
                                      )),
                                  customwidth10,
                                  CircleAvatar(
                                    radius: 12,
                                    backgroundColor: CustomColor.pinkfavcolor,
                                    child: IconButton(
                                        padding: EdgeInsets.zero,
                                        onPressed: controller.increment,
                                        icon: Icon(Icons.add,
                                            color: CustomColor.redshadeColor)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Html(
                              anchorKey: controller.staticAnchorKey,
                              data: controller.allData['long_description']
                                  .toString(),
                              shrinkWrap: true,
                              style: {
                                "table": Style(
                                  margin: Margins.zero,
                                  backgroundColor: const Color.fromARGB(
                                      0x50, 0xee, 0xee, 0xee),
                                ),
                              }),
                          customHeight10,
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: Get.width * double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              // height: 230,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: CustomColor.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 3,
                                    blurRadius: 3,
                                    offset: const Offset(2, 3),
                                  )
                                ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Rating & Reviews",
                                    style: FontStyle.black18,
                                  ),
                                  height10,
                                  RatingBarIndicator(
                                    rating: 4.2,
                                    itemBuilder: (context, index) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 30,
                                    direction: Axis.horizontal,
                                  ),
                                  customHeight20,
                                  Obx(() {
                                    final hasReviews =
                                        controller.reviews.isNotEmpty;
                                    final showAll =
                                        controller.showAllReviews.value;
                                    final reviewCount = hasReviews
                                        ? (showAll
                                            ? controller.reviews.length
                                            : 1)
                                        : 0;

                                    return reviewCount == 0
                                        ? const Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text("No reviews available"),
                                          )
                                        : ListView.builder(
                                            shrinkWrap: true,
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            itemCount: reviewCount,
                                            itemBuilder: (context, index) {
                                              final review =
                                                  controller.reviews[index];
                                              return Container(
                                                color: Colors.white,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const CircleAvatar(
                                                      radius: 20,
                                                      backgroundImage: AssetImage(
                                                          "assets/images/pinkearring.jpg"),
                                                    ),
                                                    customwidth20,
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            review['user']
                                                                    ?['name'] ??
                                                                "",
                                                            style: FontStyle
                                                                .black18,
                                                          ),
                                                          RatingBar.builder(
                                                            itemSize: 25,
                                                            initialRating: double
                                                                    .tryParse(review[
                                                                            'rating']
                                                                        .toString()) ??
                                                                0.0,
                                                            minRating: 1,
                                                            direction:
                                                                Axis.horizontal,
                                                            allowHalfRating:
                                                                false,
                                                            itemCount: 5,
                                                            itemBuilder:
                                                                (context, _) =>
                                                                    const Icon(
                                                              Icons.star,
                                                              color:
                                                                  Colors.amber,
                                                            ),
                                                            onRatingUpdate:
                                                                (rating) {},
                                                          ),
                                                          Text(
                                                            review['comment'] ??
                                                                "",
                                                            style: FontStyle
                                                                .greytext14,
                                                            maxLines: 6,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              );
                                            },
                                          );
                                  }),
                                ],
                              ),
                            ),
                          ),
                          customHeight10,
                          Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      controller.toggleReviews();
                                    },
                                    child: Text(
                                      controller.showAllReviews.value
                                          ? "Hide Reviews"
                                          : "View All Reviews",
                                      style: FontStyle.redshadew600,
                                    ))
                              ],
                            ),
                          ),
                          Container(
                            // height: 270,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CustomColor.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: const Offset(2, 3),
                                )
                              ],
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  customHeight10,
                                  ExpansionTileCard(
                                    baseColor: Colors.white,
                                    title: Text(
                                      "Product Specification",
                                      style: FontStyle.black17w400,
                                    ),
                                    children: [
                                      Text(
                                        controller.similaritemdetails[1]
                                            ['title'],
                                      )
                                    ],
                                  ),
                                  customHeight10,
                                  ExpansionTileCard(
                                    baseColor: Colors.white,
                                    title: Text(
                                      "Write a Review",
                                      style: FontStyle.black17w400,
                                    ),
                                    children: [
                                      Text(
                                        controller.similaritemdetails[1]
                                            ['title'],
                                      )
                                    ],
                                  ),
                                  customHeight10,
                                  ExpansionTileCard(
                                    baseColor: Colors.white,
                                    title: Text(
                                      "Ask a Question",
                                      style: FontStyle.black17w400,
                                    ),
                                    children: [
                                      Text(
                                        controller.similaritemdetails[1]
                                            ['title'],
                                      )
                                    ],
                                  ),
                                  customHeight50,
                                  customHeight50,
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
      ),
    );

    // Obx(() =>

    // SafeArea(
    //     child: SingleChildScrollView(
    //       physics: const BouncingScrollPhysics(),
    //       child: Column(
    //         children: [
    //

    //

    //           // Padding(
    //           //   padding: const EdgeInsets.symmetric(horizontal: 15),
    //           //   child: Row(
    //           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //           //     children: [
    //           //       Text(
    //           //         "you Might also like",
    //           //         style: FontStyle.black18,
    //           //       ),
    //           //       Row(
    //           //         children: [
    //           //           Text(
    //           //             "See All",
    //           //             style: FontStyle.black16,
    //           //           ),
    //           //           customwidth5,
    //           //           CircleAvatar(
    //           //             radius: 16,
    //           //             backgroundColor:
    //           //                 CustomColor.redshadeColor,
    //           //             child: Icon(
    //           //               Icons.arrow_forward,
    //           //               color: CustomColor.white,
    //           //               size: 18,
    //           //             ),
    //           //           ),
    //           //         ],
    //           //       )
    //           //     ],
    //           //   ),
    //           // ),
    //           // Column(
    //           //   children: [
    //           //     SizedBox(
    //           //       height: 300,
    //           //       child: ListView.builder(
    //           //         shrinkWrap: true,
    //           //         scrollDirection: Axis.horizontal,
    //           //         itemCount: controller.multipleImage.length,
    //           //         itemBuilder: (context, index) {
    //           //           return Container(
    //           //             padding: const EdgeInsets.only(
    //           //                 left: 16, top: 10),
    //           //             // margin: const EdgeInsets.all(2.0),
    //           //             width: 180,
    //           //             child: Column(
    //           //               crossAxisAlignment:
    //           //                   CrossAxisAlignment.start,
    //           //               children: [
    //           //                 Container(
    //           //                   height: 190,
    //           //                   decoration: BoxDecoration(
    //           //                     borderRadius:
    //           //                         BorderRadius.circular(12),
    //           //                     boxShadow: [
    //           //                       BoxShadow(
    //           //                         color: Colors.grey
    //           //                             .withOpacity(0.1),
    //           //                         spreadRadius: 1,
    //           //                         blurRadius: 1,
    //           //                         offset: const Offset(1, 3),
    //           //                       )
    //           //                     ],
    //           //                   ),
    //           //                   child: Stack(
    //           //                     children: [
    //           //                       ClipRRect(
    //           //                         borderRadius:
    //           //                             BorderRadius.circular(12),
    //           //                         child: Image.network(
    //           //                           controller
    //           //                               .multipleImage[index],
    //           //                           height: 190,
    //           //                           width: double.infinity,
    //           //                           fit: BoxFit.cover,
    //           //                         ),
    //           //                       ),
    //           //                       Positioned(
    //           //                         top: 12,
    //           //                         right: 10,
    //           //                         child: CircleAvatar(
    //           //                           radius: 12,
    //           //                           backgroundColor: CustomColor
    //           //                               .pinkfavcolor,
    //           //                           child: Icon(
    //           //                             Icons
    //           //                                 .favorite_border_outlined,
    //           //                             color: CustomColor
    //           //                                 .redshadeColor,
    //           //                             size: 16,
    //           //                           ),
    //           //                         ),
    //           //                       ),
    //           //                       Positioned(
    //           //                         bottom: 0,
    //           //                         left: 0,
    //           //                         child: Container(
    //           //                           padding: const EdgeInsets
    //           //                               .symmetric(
    //           //                               horizontal: 6,
    //           //                               vertical: 2),
    //           //                           decoration: BoxDecoration(
    //           //                             color: Colors.grey
    //           //                                 .withOpacity(0.7),
    //           //                             borderRadius:
    //           //                                 BorderRadius.circular(
    //           //                                     6),
    //           //                           ),
    //           //                           child: Row(
    //           //                             children: [
    //           //                               const SizedBox(
    //           //                                   width: 4),
    //           //                               Text(
    //           //                                 controller.similaritemdetails[
    //           //                                             index]
    //           //                                         ['rating'] ??
    //           //                                     '4.5',
    //           //                                 style:
    //           //                                     const TextStyle(
    //           //                                   color: Colors.white,
    //           //                                   fontSize: 12,
    //           //                                 ),
    //           //                               ),
    //           //                               width5,
    //           //                               const Icon(
    //           //                                 Icons.star,
    //           //                                 color: Colors.amber,
    //           //                                 size: 14,
    //           //                               ),
    //           //                             ],
    //           //                           ),
    //           //                         ),
    //           //                       ),
    //           //                     ],
    //           //                   ),
    //           //                 ),
    //           //                 height10,
    //           //                 Expanded(
    //           //                   child: Text(
    //           //                     controller
    //           //                             .similaritemdetails[index]
    //           //                         ['title'],
    //           //                     style: FontStyle.black16w400,
    //           //                     maxLines: 2,
    //           //                     overflow: TextOverflow.ellipsis,
    //           //                   ),
    //           //                 ),
    //           //                 Text(
    //           //                   '₹${controller.similaritemdetails[index]['rate']}',
    //           //                   style: FontStyle.redshadew600,
    //           //                 )
    //           //               ],
    //           //             ),
    //           //           );
    //           //         },
    //           //       ),
    //           //     )
    //           //   ],
    //           // ),
  }

  Widget buildbullettext(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "•    ",
          style: FontStyle.greytext14,
        ),
        height10,
        Expanded(
          child: Text(
            title,
            style: FontStyle.greytext14,
          ),
        ),
      ],
    );
  }
}

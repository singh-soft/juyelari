// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';

// class CustomImageSlider extends StatelessWidget {
//   final List imageList;
//   final CarouselSliderController imageController;
//   final double? height;
//   final double? width;
//   final dynamic Function(int, CarouselPageChangedReason)? onPageChanged;
//   final String imageUrl;
//   const CustomImageSlider(
//       {super.key,
//       required this.imageList,
//       required this.imageController,
//       required this.imageUrl,
//       this.height,
//       required this.onPageChanged,
//       this.width});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         CarouselSlider(
//           carouselController: imageController,
//           options: CarouselOptions(
//               height: height,
//               autoPlay: true,
//               autoPlayCurve: Curves.easeInOut,
//               enableInfiniteScroll: true,
//               autoPlayAnimationDuration: const Duration(milliseconds: 1200),
//               autoPlayInterval: const Duration(seconds: 4),
//               viewportFraction: 1,
//               onPageChanged: onPageChanged),
//           items: List.generate(
//             imageList.length,
//             (index) => Container(
//               margin: const EdgeInsets.only(top: 3),
//               width: width,
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(6),
//                 child: Image.asset(
//                   imageList[index],
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                 ),
//                 // FadeInImage.assetNetwork(
//                 //   placeholder: loginpic,
//                 //   image: imageList[index].toString(),
//                 //   width: double.infinity,
//                 //   fit: BoxFit.fill,
//                 // ),
//               ),
//             ),
//           ),
//         ),
//         height10
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';

class CustomImageCarousel extends StatelessWidget {
  final List<String> imagePaths;
  final bool isAssets;
  final bool autoPlay;
  final double sliderHeight;
  final bool showIndicator;

  const CustomImageCarousel({
    super.key,
    required this.imagePaths,
    this.isAssets = false,
    this.autoPlay = true,
    this.sliderHeight = 250,
    this.showIndicator = true,
  });

  @override
  Widget build(BuildContext context) {
    return FanCarouselImageSlider.sliderType1(
      imagesLink: imagePaths,
      isAssets: isAssets,
      autoPlay: autoPlay,
      sliderHeight: sliderHeight,
      showIndicator: showIndicator,
      indicatorActiveColor: Colors.black,
    );
  }
}

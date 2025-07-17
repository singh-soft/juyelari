import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Screens/bottom_bar/bottom_bar_controller.dart';
class BottomBarView extends GetView<BottomBarController> {
  const BottomBarView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => BottomBarController());
    // late double h, w;

    return Obx(()=>
      Scaffold(
        bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            unselectedItemColor: Colors.black26,
            unselectedLabelStyle:
               GoogleFonts.poppins(fontSize: 12,color: CustomColor.redshadeColor),
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            selectedItemColor: CustomColor.redshadeColor,
            selectedLabelStyle: GoogleFonts.poppins(fontSize: 12,color: CustomColor.redshadeColor),
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeIndex,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined,size:25,), label: 'Home', ),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_border_outlined,size: 25), label: 'favourite ',),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined,size: 25), label: 'My Order',),
              BottomNavigationBarItem(icon: Icon(Icons.local_shipping,size: 25), label: 'Add Shipping',),
            ]),
        body: 
           controller.pages[controller.currentIndex.value]),
    
    );
  }
}

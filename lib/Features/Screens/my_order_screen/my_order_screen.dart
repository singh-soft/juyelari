import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Screens/my_order_screen/my_order_controller.dart';

class MyOrderScreen extends GetView<MyOrderController> {
  const MyOrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: 30,
          child: ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: controller.selectedIndex.value==index?CustomColor.yellowshade:CustomColor.white
                ),
                child: Text(controller.myorderupdate[index],
                style: GoogleFonts.poppins(fontSize: 14,color: controller.selectedIndex.value==index?CustomColor.white:CustomColor.blackColor)),
              );
            },
          ),
        
        )],
    ));
  }
}

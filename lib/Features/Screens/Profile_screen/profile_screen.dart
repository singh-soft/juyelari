import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/Profile_screen/profile_screen_controller.dart';
import 'package:juyelari/Features/Screens/bottom_bar/bottom_bar_controller.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_screen.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';

class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});
  final customHeight10 = height10;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;

  @override
  Widget build(BuildContext context) {
    final box = GetStorage();
    final userName = box.read('user_name') ?? '';
    final userEmail = box.read('user_email') ?? '';
    Get.lazyPut(() => ProfileScreenController);
    return Scaffold(
        appBar: CustomWidgets().customAppBar(
          title: 'My Profile',
          leadingIcon: Icons.arrow_back_ios,
          onLeadingPressed: () {
            Get.back();
          },
        ),
        backgroundColor: Colors.white,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.white,
                  ),
                ),
                width10,
                width5,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: FontStyle.black18w400,
                    ),
                    Text(
                      userEmail,
                      style: FontStyle.greyshade14,
                    )
                  ],
                )
              ],
            ),
            Column(
              children: [
                height30,
                customContainerTile(
                    title: 'My Order',
                    subtitle: 'See your all orders',
                    onTap: () {
                      final bottomBarController = Get.find<BottomBarController>();
                      bottomBarController.changeIndex(2);
                      Get.back();
                    }),
                height20,
                customContainerTile(
                    title: 'My Shipping addresses',
                    subtitle: 'Add or edit your addresses',
                    onTap: () {
                      Get.to(()=> const  ShippingAddressScreen());
                    }),
                height20,
                customContainerTile(
                    title: 'Payment methods',
                    subtitle: 'Add or edit your payment methods',
                    onTap: () {
                      
                    }),
                height20,
                customContainerTile(
                    title: 'My Reviews',
                    subtitle: 'Reviews for 4 items',
                    onTap: () {}),
                height20,
                customContainerTile(
                    title: 'Settings',
                    subtitle: 'Notifications, password',
                    onTap: () {})
              ],
            )
          ],
        ));
  }

  Widget customContainerTile({
    required String title,
    required String subtitle,
    required void Function()? onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(1, 2),
            ),
          ]),
      child: ListTile(
        title: Text(
          title,
          style: FontStyle.black18w400,
        ),
        subtitle: Text(
          subtitle,
          style: FontStyle.greyshade14,
        ),
        trailing: IconButton(
            onPressed: () {
              onTap?.call();  
            },
            icon: Icon(
              Icons.chevron_right,
              color: CustomColor.greyshade,
            )),
        onTap: onTap,
      ),
    );
  }
}

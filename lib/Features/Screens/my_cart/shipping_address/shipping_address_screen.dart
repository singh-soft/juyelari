import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/Custom_widgets/custom_widgets.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/new_address/add_new_address_screen.dart';
import 'package:juyelari/Features/Screens/my_cart/shipping_address/shipping_address_controller.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';
import 'package:juyelari/Features/utils/custom_spaces/custom_spaces.dart';
import 'package:juyelari/Features/utils/custom_textformfield/custom_textformfield2.dart';

class ShippingAddressScreen extends GetView<ShippingAddressController> {
  const ShippingAddressScreen({super.key});
  final customHeight10 = height10;
  final customHeight5 = height5;
  final customHeight15 = height15;
  final customHeight25 = height25;
  final customHeight20 = height20;
  final customHeight30 = height30;
  final customHeight50 = height50;
  final customwidth5 = width5;

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => ShippingAddressController());
    final List<Map<String, dynamic>> addressList =
        (Get.arguments as List).cast<Map<String, dynamic>>();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomWidgets().customAppBar(
        title: 'Shipping Address',
        leadingIcon: Icons.arrow_back_ios,
        onLeadingPressed: () {
          Get.back();
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.topRight,
              colors: <Color>[
                Colors.black,
                Color(0xff890E29),
                Colors.black,
              ],
            ),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            "Delviery Here",
            style: FontStyle.white18,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            customHeight5,
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
                border: InputBorder.none,
                focusBorder: InputBorder.none,
                enableBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),

            // List of addresses
            SizedBox(
              height: 350,
              child: ListView.builder(
                itemCount: addressList.length,
                itemBuilder: (context, index) {
                  // final isSelected=controller.selectedAddressIndex.value==index;
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: Colors.white,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => Radio(
                                  value: index,
                                  groupValue:
                                      controller.selectedAddressIndex.value,
                                  onChanged: (val) {
                                    controller.selectedAddress(index);
                                  },
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Shipping Address - ${index+1}",
                                            style: FontStyle.black16bold,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: CustomColor.lightgreyy,
                                          ),
                                          onPressed: () {
                                            // controller.selectedAddress(index);
                                            Get.to(()=>const AddNewAddressScreen(),arguments: {'id':addressList[index]['id'],
                                            'address_tag':addressList[index]['address_tag'],'flat':addressList[index]['flat'],
                                            'area':addressList[index]['area'],'address_line_1':addressList[index]['address_line_1'],
                                            'address_line_2':addressList[index]['address_line_2'],'city':addressList[index]['city'],
                                            'state':addressList[index]['state'],'country':addressList[index]['country'],
                                            'postalcode':addressList[index]['postalcode'],'name':addressList[index]['name'],'phone':addressList[index]['phone']});
                                          },
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${addressList[index]['address_tag'] ?? ''}, ${addressList[index]['flat'] ?? ''}, ${addressList[index]['area'] ?? ''}${addressList[index]['address_line_1'] ?? ''}, ${addressList[index]['address_line_2'] ?? ''}, ${addressList[index]['city'] ?? ""}, ${addressList[index]['state'] ?? ''}, ${addressList[index]['country'] ?? ''}, ${addressList[index]['postalcode'] ?? ''}",
                                      style: FontStyle.black14,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          color: CustomColor.lightgrey,
                          thickness: 1,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            customHeight10,

            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  Get.to(() => const AddNewAddressScreen());
                },
                child: Container(
                  margin: const EdgeInsets.all(10.0),
                  height: 50,
                  width: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.topRight,
                      colors: <Color>[
                        Colors.black,
                        Color(0xff890E29),
                        Colors.black,
                      ],
                    ),
                  ),
                  child: const Icon(
                    Icons.add,
                    size: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

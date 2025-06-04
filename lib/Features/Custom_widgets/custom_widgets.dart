import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';

class CustomWidgets {
  AppBar customAppBar({
    required String title,
    required IconData leadingIcon,
    required VoidCallback onLeadingPressed,
    List<Widget>? actions,
  }) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        onPressed: onLeadingPressed,
        icon: Icon(
          leadingIcon,
          color: CustomColor.blackColor,
          size: 16,
        ),
      ),
      leadingWidth: 40,
      title: Text(
        title,
        style: FontStyle.redshade20w600,
      ),
      centerTitle: false,
      actions: actions?.isNotEmpty == true ? actions : null,
    );
  }

  toast(msg, color) {
    Fluttertoast.showToast(
      msg: msg,
      backgroundColor: color,
      toastLength: Toast.LENGTH_LONG,
    );
  }
}

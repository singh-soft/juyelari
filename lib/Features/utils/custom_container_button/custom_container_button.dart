import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';

class CustomContainerButton extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final Color?gradientColors;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;

  const CustomContainerButton(
      {super.key,
      required this.text,
       this.gradientColors,
      this.borderRadius,
      this.onTap,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        child: Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.topRight,
            colors: <Color>[
             
              Colors.black,
               Color(0xff890E29),
                Colors.black
            ]),
        borderRadius: borderRadius,
      ),
      child: Center(
          child: Text(
        text,
        style: FontStyle.white18,
      )),
    ));
  }
}

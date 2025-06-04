import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';
import 'package:juyelari/Features/utils/custom_font_style.dart';

class CustomContainerButton extends StatelessWidget {
 
  final void Function()? onTap;
  final Color?gradientColors;
  final BorderRadius? borderRadius;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const CustomContainerButton(
      {super.key,
    
       this.gradientColors,
      this.borderRadius,
      this.onTap,
      this.padding,
      this.width,
      this.child});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
        child: Container(
      padding: padding,
      width: width,
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
      child:child
    ));
  }
}

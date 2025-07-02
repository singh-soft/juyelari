import 'package:flutter/material.dart';

class CustomContainerButton extends StatelessWidget {
  final void Function()? onTap;
  final Color? gradientColors;
  final BorderRadius? borderRadius;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Widget? child;

  const CustomContainerButton(
      {super.key,
      this.gradientColors,
      this.borderRadius,
      this.onTap,
      this.padding,
      this.width,
      this.height,
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
            child: child));
  }
}

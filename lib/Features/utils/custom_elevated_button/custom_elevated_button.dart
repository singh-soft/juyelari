import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  

  final void Function()? onPressed;
  final Widget? child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Size? maximumSize;
  final Size? minimumSize;
  final Color? borderColor;
  final double? borderWidth;
   final double? borderRadius;
   final double? elevation;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.maximumSize,
    this.minimumSize,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.elevation,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        
          elevation: elevation?? 2.0,
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 30),
            side: BorderSide(
              color: borderColor ?? const Color.fromARGB(255, 215, 212, 212), // Border color
              width: borderWidth ?? .3, // Border width
              style: BorderStyle.solid, // Border style
            ),
          ),
          maximumSize: maximumSize ?? const Size(350, 50),
          minimumSize: minimumSize ?? const Size(350, 50)),
      child: child,
    );
  }
}
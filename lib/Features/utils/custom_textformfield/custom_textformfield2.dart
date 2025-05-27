import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';

class CustomTextFormField2 extends StatelessWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final Color? fillColor;
  final bool? filled;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final InputBorder? focusBorder;
  final InputBorder? enableBorder;
  final InputBorder? errorBorder;
  final InputBorder? border;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelStyle;
  final bool? ishighlighted;

  const CustomTextFormField2({
    super.key,
    required this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText,
    this.maxLength,
    this.maxLines = 1,
    this.hintText,
    this.labelText,
    this.fillColor,
    this.filled,
    this.hintStyle,
    this.style,
    this.focusBorder,
    this.enableBorder,
    this.errorBorder,
    this.border,
    this.validator,
    this.onChanged,
    this.onTap,
    this.readOnly,
    this.inputFormatters,
    this.contentPadding,
    this.labelStyle,
    this.ishighlighted,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: CustomColor.whiteshade,
        borderRadius:BorderRadius.circular(50) ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText ?? false,
        readOnly: readOnly ?? false,
        maxLength: maxLength,
        maxLines: maxLines,
        style: style,
        validator: validator,
        onChanged: onChanged,
        onTap: onTap,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: hintStyle,
          labelText: labelText,
          labelStyle: labelStyle,
          fillColor: fillColor,
          filled: filled,
          contentPadding: contentPadding,
          border: border ??
              OutlineInputBorder(
                borderSide: BorderSide(
                  color: ishighlighted == true
                      ? Colors.transparent
                      : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
          focusedBorder: focusBorder,
          enabledBorder: enableBorder,
          errorBorder: errorBorder,
        ),
      ),
    );
  }
}

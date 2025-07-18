import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField2 extends StatelessWidget {
  final TextEditingController? controller;

  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? suffix;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLines;
  final String? hintText;
  final String? labelText;
  final Color? fillColor;
  final bool? filled;
  final TextStyle? hintStyle;
  final InputBorder? focusBorder;
  final InputBorder? enableBorder;
  final InputBorder? errorBorder;
  final InputBorder? border;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelStyle;
  final bool? ishighlighted;
  final String? topLabelText;
  final TextStyle? topLabelStyle;
  final bool isMandatory;

  const CustomTextFormField2({
    required this.controller,
    this.keyboardType,
    this.prefixIcon,
    this.readOnly,
    this.suffixIcon,
    this.obscureText,
    this.maxLength,
    this.hintText,
    this.labelText,
    this.fillColor,
    this.filled,
    this.focusBorder,
    this.enableBorder,
    this.errorBorder,
    this.border,
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.hintStyle,
    this.style,
    this.maxLines = 1,
    this.inputFormatters,
    this.onTap,
    this.labelStyle,
    this.ishighlighted,
    this.topLabelText,
    this.topLabelStyle,
    this.isMandatory = false,
    this.suffix,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (topLabelText != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: RichText(
              text: TextSpan(
                text: topLabelText,
                style: topLabelStyle ??
                    GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                children: [
                  if (isMandatory == true)
                    TextSpan(
                      text: ' *',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                ],
              ),
            ),
          ),
        Container(
          decoration: BoxDecoration(
              border: Border.all(
               color: Colors.grey.withOpacity(0.1),
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 0,
                  offset: const Offset(0,1),
                ),
              ]),
          child: TextFormField(
            style: style,
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText ?? false,
            readOnly: readOnly ?? false,
            maxLength: maxLength,
            maxLines: maxLines,
            validator: validator,
            onChanged: onChanged,
            inputFormatters: inputFormatters,
            onTap: onTap,
            decoration: InputDecoration(
              suffix: suffix,
                prefixIcon: prefixIcon,
                suffixIcon: suffixIcon,
                hintText: hintText,
                labelText: labelText,
                fillColor: fillColor,
                filled: filled,
                border: border,
                hintStyle: hintStyle,
                labelStyle: labelStyle,
                focusedBorder: focusBorder,
                enabledBorder: enableBorder,
                errorBorder: errorBorder,
                contentPadding: contentPadding),
          ),
        ),
      ],
    );
  }
}

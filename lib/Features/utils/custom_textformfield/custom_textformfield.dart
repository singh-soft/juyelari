import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:juyelari/Features/Custom_widgets/colors.dart';

class CustomTextFormField extends StatelessWidget {
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
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final EdgeInsetsGeometry? contentPadding;
  final bool? readOnly;
  final List<TextInputFormatter>? inputFormatters;
  final TextStyle? labelStyle;
  final bool? isHighlighted;
  final TextStyle? topLabelStyle;
  final bool isMandatory;
  final String? topLabelText;
 
 
  const CustomTextFormField({
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
    this.validator,
    this.onChanged,
    this.contentPadding,
    this.hintStyle,
    this.style,
    this.maxLines = 1,
    this.inputFormatters,
    this.onTap,
    this.labelStyle,
    this.isHighlighted,
     this.topLabelText,
    this.topLabelStyle,
    this.isMandatory = false,
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
        TextFormField(
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
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            hintText: hintText,
            labelText: labelText,
            fillColor: fillColor ?? Colors.white,
            filled: filled ?? true,
            hintStyle: hintStyle,
            labelStyle: labelStyle,
            contentPadding: contentPadding,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: CustomColor.blackColor1, width: 1),
            ),
            enabledBorder: enableBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: CustomColor.blackColor1, width: 1),
                ),
            focusedBorder: focusBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: CustomColor.blackColor1, width: 1),
                ),
            errorBorder: errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50),
                  borderSide: BorderSide(color: CustomColor.blackColor1, width: 1),
                ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(color: CustomColor.blackColor1, width: 1),
            ),
          ),
        ),
      ],
    );
  }
}

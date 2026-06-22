import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rehmandev/core/utils/responsive.dart';

class BlackText extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? textColor;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final double? letterSpacing;

  const BlackText({
    super.key,
    this.text,
    this.onTap,
    this.fontSize,
    this.fontWeight,
    this.textColor,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    //===========>>> Initialize Responsive utility
    Responsive.init(context);

    return InkWell(
      //===========>>> Tappable text container
      onTap: onTap,
      child: Text(
        //===========>>> Display text or empty string
        text ?? "",
        textAlign: textAlign ?? TextAlign.center,
        maxLines: maxLines,
        overflow: overflow,
        style: GoogleFonts.poppins(
          //===========>>> Responsive font size
          fontSize: fontSize != null
              ? Responsive.fontSize(fontSize!)
              : Responsive.fontSize(16), // Default font size scaled
          fontWeight: fontWeight ?? FontWeight.w500,
          color: textColor ?? Colors.white, // Default to white for dark theme
          height: height,
          letterSpacing: letterSpacing,
        ),
      ),
    );
  }
}

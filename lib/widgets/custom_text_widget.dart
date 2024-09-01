import 'package:flutter/material.dart';

class CustomTextWidget extends StatelessWidget {
  final String text;
  final Color? colorText; 
  final double? fontsize; 
  final FontWeight? fontWeight; 
  final TextDecoration? textDecoration;
  final TextAlign? textAlign;
  final TextDecorationStyle? textDecorationStyle;
  const CustomTextWidget({super.key, required this.text, 
  this.colorText, this.fontsize, 
  this.fontWeight, this.textDecoration, this.textDecorationStyle, this.textAlign});

  @override
  Widget build(BuildContext context) {
    return  Text(text, 
    style: TextStyle(color: colorText?? Colors.black,
      decoration: textDecoration,
      decorationStyle: textDecorationStyle,
     fontSize: fontsize?? 18, fontWeight: fontWeight ),);
  }
}
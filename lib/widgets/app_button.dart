import 'package:flutter/material.dart';
import 'package:sportkai/const/app_colors.dart';

Widget reuseableButton(
    width, color, onButtonClick, title, fontColor, borderColor) {
  return InkWell(
    onTap: onButtonClick,
    child: Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
          color: color),
      child: Center(
          child: Text(
        title,
        style: TextStyle(
            fontSize: 16, color: fontColor, fontWeight: FontWeight.w500),
      )),
    ),
  );
}

Widget reuseableButtonWithIcon(
    width, color, onButtonClick, title, fontColor, borderColor) {
  return InkWell(
    onTap: onButtonClick,
    child: Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor),
          color: color),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
          const SizedBox(
            width: 8,
          ),
          Text(
            title,
            style: TextStyle(
                fontSize: 16, color: fontColor, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

Widget filterButton(onButtonClick) {
  return InkWell(
    onTap: onButtonClick,
    child: Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: buttonPrimaryColor),
          image: const DecorationImage(
              image: AssetImage(
                'assets/icons/filter.png',
              ),
              fit: BoxFit.none)),
    ),
  );
}

Widget circleIconButton(icon,onPress) {
  return InkWell(
    onTap: onPress,
    child: Container(
      height: 22,
      width: 22,
      decoration: const BoxDecoration(
          shape: BoxShape.circle, color: buttonPrimaryColor),
      child:  Center(
        child: Icon(
          icon,
          size: 16,
          color: Colors.white,
        ),
      ),
    ),
  );
}

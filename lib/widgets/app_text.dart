import 'package:flutter/material.dart';
import 'package:sportkai/const/app_colors.dart';
import 'package:sportkai/widgets/app_button.dart';

Widget appTitleText(title){
  return Text(title,style: const TextStyle(fontSize: 24,fontWeight: FontWeight.w700,color: Colors.black),);
}

Widget appEmptyScreen(title,subtitle,context,press){
  return Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/empty.png',
                      height: 80,
                      width: 200,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 12),
                      child: Text('Not Selected'),
                    ),
                     Text(
                      title,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    reuseableButtonWithIcon(
                        MediaQuery.of(context).size.width > 600? MediaQuery.of(context).size.width/3  : MediaQuery.of(context).size.width/ 2,
                        buttonPrimaryColor,
                        press,
                        subtitle,
                        Colors.white,
                        buttonPrimaryColor)
                  ],
                ),
              ),
            );
}

Widget shadowText(title){
  return Text(title,style: const TextStyle(fontSize: 12,fontWeight: FontWeight.w400,color: fontShadowColor),);
}
Widget appSubTitleText(title){
  return Text(title,
  style: const TextStyle(fontSize: 14,fontWeight: FontWeight.w400),);
}

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/views/profile/profile_details_screen.dart';

var box = GetStorage();

Widget topBar(context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset('assets/images/logo.png'),
      InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> const ProfileDetailsScreen()));
        },
        child: Container(
          height: 32,
          width: 32,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: NetworkImage(
                    box.read('user')['url'],
                  ),
                  fit: BoxFit.contain)),
        ),
      )
    ],
  );
}

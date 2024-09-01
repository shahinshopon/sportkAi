import 'package:flutter/material.dart';
import 'package:sportkai/const/app_colors.dart';
import 'package:sportkai/views/filter/filter_screen.dart';

Widget searchBar(context, searchController) {
  return Row(
    children: [
      Expanded(
        child: SizedBox(
          height: 45,
          width: double.infinity,
          child: TextField(
            controller: searchController,
            
            decoration: InputDecoration(
              labelText: 'Search in app',
              
              
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: buttonPrimaryColor)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: buttonPrimaryColor)),
              errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Colors.red)),
              focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: buttonPrimaryColor)),
            ),
          ),
        ),
      ),
      const SizedBox(
        width: 15,
      ),
      GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) =>  FilterScreen()));
        },
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
      ),
      const SizedBox(
        width: 15,
      ),
    ],
  );
}


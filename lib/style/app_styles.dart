import 'package:flutter/material.dart';
import 'package:get/get.dart';

  successSnackBar({
    required String message,
  }) {
    return Get.showSnackbar(GetSnackBar(
      title: "Success",
      message: message,
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 2),
    ));
  }

  failedSnackBar({
    required String message,
  }) {
    return Get.showSnackbar(GetSnackBar(
      title: "Failed",
      message: message,
      backgroundColor: Colors.redAccent,
      duration: const Duration(seconds: 2),
    ));
  }

// loading
progressDialog(context) {
  showDialog(
    context: context,
    builder: (context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Image.asset(
          "assets/files/loading.gif",
          height: 150,
        ),
      );
    },
    barrierDismissible: false,
  );
}

BoxDecoration cardDecoration = BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(blurRadius: 25,spreadRadius: 0,color: const Color(0xff6B7989).withOpacity(0.15)),
                                ]
                              );

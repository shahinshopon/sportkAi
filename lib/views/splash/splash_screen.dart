import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/views/home/homescreen.dart';
import 'package:sportkai/const/auth_config.dart';
import 'package:sportkai/controller/auth_controller.dart';
import 'package:sportkai/style/app_styles.dart';

class SplashScreen extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());
  final auth0Web = Auth0Web(AuthConfig.domain, AuthConfig.clientId);
  final box = GetStorage();

  SplashScreen() {
    _initAuth();
  }

  void _initAuth() async {
    if (box.read('user') != null) {
      await Future.delayed(const Duration(seconds: 2));
      Get.off(() => const HomeScreen());
    } else {
      if (GetPlatform.isWeb) {
        auth0Web.onLoad().then((credentials) {
          if (credentials != null) {
            Map user = {
              'email': credentials.user.email.toString(),
              'url': credentials.user.pictureUrl.toString(),
              'id_token': credentials.idToken.toString(),
            };

            box.write('user', user);
            Get.to(() => const HomeScreen());
          } else {
            authController.login();
            //SystemNavigator.pop();
          }
        }).catchError((e) {
          failedSnackBar(message: e.toString());
        });
      } else {
        authController.login();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Image.asset(
              'assets/images/logo.png',
              height: 150,
            ),
          ),
        ),
      ),
    );
  }
}

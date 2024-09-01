import 'dart:io';
import 'package:auth0_flutter/auth0_flutter.dart';
import 'package:auth0_flutter/auth0_flutter_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/views/home/homescreen.dart';
import 'package:sportkai/views/splash/splash_screen.dart';
import 'package:sportkai/style/app_styles.dart';
import '../const/auth_config.dart';

class AuthController extends GetxController {
  final auth0 = Auth0(
    AuthConfig.domain,
    AuthConfig.clientId,
  );
  final auth0Web = Auth0Web(AuthConfig.domain, AuthConfig.clientId);
  final box = GetStorage();

  RxBool isLoading = false.obs;

  login() async {
    try {
      isLoading.value = true;
      final userAuthResult;
      if (kIsWeb) {
        userAuthResult =
            auth0Web.loginWithRedirect(redirectUrl: AuthConfig.redirectUri);
      } else {
        userAuthResult =
            await auth0.webAuthentication(scheme: 'com.sportkai.app').login();
      }
      if (userAuthResult != null) {
        Map user = {
          'email': userAuthResult.user.email.toString(),
          'url': userAuthResult.user.pictureUrl.toString(),
          'id_token': userAuthResult.idToken.toString(),
        };
        await box.write('user', user);
        Get.off(() => const HomeScreen());
      } else {
        failedSnackBar(message: 'Failed to authenticate');

        if (Platform.isIOS) {
          exit(0);
        } else {
          SystemNavigator.pop();
        }
      }
    } catch (e) {
      failedSnackBar(message: e.toString());

      if (Platform.isIOS) {
        exit(0);
      } else {
        SystemNavigator.pop();
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      String returnToUrl;
      if (GetPlatform.isAndroid) {
        returnToUrl =
            'https://dev-j2ruirzod4scshbl.us.auth0.com/android/com.sportkai.app/logout';
      } else if (GetPlatform.isIOS) {
        returnToUrl =
            'com.sportkai.app://dev-j2ruirzod4scshbl.us.auth0.com/ios/com.sportkai.app/logout';
      } else if (GetPlatform.isMacOS) {
        returnToUrl =
            'com.sportkai.app://dev-j2ruirzod4scshbl.us.auth0.com/macos/com.sportkai.app/logout';
      } else {
        returnToUrl =
            'http://localhost:8080/logout'; // For web or other platforms
      }
      await box.remove('user');
      await auth0.webAuthentication().logout(returnTo: returnToUrl);
      Get.offAll(() => SplashScreen());
    } catch (e) {
      failedSnackBar(message: e.toString());
    }
  }
}

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/const/api_endpoints.dart';

class HomeController extends GetxController {
  var isLoad = true.obs;
  var selectedIndex = 0.obs;

  final box = GetStorage();

  Future<void> getUserInfo() async {
    final response = await http.get(
      Uri.parse('$apiUrl/me/read'),
      headers: {
        'Authorization': 'Bearer ${box.read('user')['id_token']}',
        "alg": "HS256",
        "typ": "JWT",
      },
    );

    if (response.statusCode == 200) {
      box.write('profileData', jsonDecode(response.body));
      // print(box.read('user')['id_token']);
      isLoad.value = false;
    } else {
      throw Exception('Failed to fetch user info ${response.body}');
    }
  }

  void onItemTapped(int index) {
    selectedIndex.value = index;
  }

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
  }
}

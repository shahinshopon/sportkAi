import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sportkai/const/api_endpoints.dart';
import 'dart:convert';

import 'package:sportkai/models/team_model.dart';

// for empty screen
class MyTeamController extends GetxController {
  var searchResults = <Team>[].obs;
  var isLoading = false.obs;
  var box = GetStorage();
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void onInit() {
    searchController.addListener(_onSearchChanged);
    super.onInit();
  }

  @override
  void onClose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    searchController.clear();
    _debounce?.cancel();
    super.onClose();
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      search(searchController.text);
    });
  }

  Future<void> search(String term) async {
    if (term.isEmpty) {
      searchResults.clear();
      return;
    }

    isLoading.value = true;

    final url = Uri.parse('$apiUrl/search');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = box.hasData('filterData')
        ? jsonEncode({
            "term": term,
            "scope": [
              {"team": true}
            ],
            "filters": [
              {
                "sex": [
                  {"${box.read('filterData')['sex']}": true}
                ],
                "age": [
                  {"${box.read('filterData')['age']}": true}
                ]
              }
            ]
          })
        : jsonEncode({
            "term": term,
            "scope": [
              {"team": true}
            ]
          });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['teams'] as List;
        searchResults.value = data.map((team) => Team.fromJson(team)).toList();
      } else {
        // Get.snackbar("Error", response.body.toString());
      }
    } catch (error) {
      // Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

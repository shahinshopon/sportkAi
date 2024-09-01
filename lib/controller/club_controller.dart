import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:sportkai/const/api_endpoints.dart';
import 'dart:convert';
import 'package:sportkai/models/club_model.dart';

// for empty screen
class MyClubController extends GetxController {
  var searchResults = <Club>[].obs;
  var isLoading = false.obs;
  var isLoad = false.obs;
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
              {"club": true}
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
              {"club": true}
            ]
          });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body)['clubs'] as List;
        searchResults.value = data.map((club) => Club.fromJson(club)).toList();
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

//for view screen
class MatchController extends GetxController {
  var isLoading = true.obs;
  var matchList = <Match>[].obs;

  Future<void> fetchClubMatches(String clubName) async {
    final url = Uri.parse('$apiUrl/club');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({"name": clubName});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body) as List;
        matchList.value = jsonData.map((json) => Match.fromJson(json)).toList();
        isLoading.value = false;
      } else {
        Get.snackbar("Error", response.body.toString());
      }
    } catch (error) {
      Get.snackbar("Error", error.toString());
    }
  }
}

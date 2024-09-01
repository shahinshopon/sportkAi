import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/const/api_endpoints.dart';
import 'package:sportkai/models/club_model.dart';
import 'package:sportkai/models/league_model.dart';
import 'package:sportkai/models/team_model.dart';
import 'package:sportkai/style/app_styles.dart';

class ManageController extends GetxController {
  final box = GetStorage();
  var clubItemExpanded = false.obs;
  var teamItemExpanded = false.obs;
  var leagueItemExpanded = false.obs;
  var getClubData = {}.obs;
  var searchResultsForClub = <Club>[].obs;
  var searchResultsForTeam = <Team>[].obs;
  var searchResultsForLeague = <League>[].obs;
  var isLoading = false.obs;
  var isLoad = false.obs;
  TextEditingController searchController = TextEditingController();
  Timer? _debounce;

  @override
  void onInit() {
    userClubInfo();
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

  Future<void> sendClubData(context,String clubName) async {
    progressDialog(context);
    final url = Uri.parse('$apiUrl/me/club');
    final headers = {'Content-Type': 'application/json'};
    final body =
        jsonEncode({"id": box.read('profileData')['id'], "club": clubName});
 
    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Handle success
        userClubInfo();
      } else {
        failedSnackBar(message: response.body.toString());
      }
    } catch (error) {
      failedSnackBar(message: error.toString());
    }finally{
      Get.back();
    }
  }

  Future<void> sendTeamData(String teamID) async {
    final url = Uri.parse('$apiUrl/me/team');
    final headers = {'Content-Type': 'application/json'};
    final body =
        jsonEncode({"id": box.read('profileData')['id'], "team": teamID});

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        // Handle success
        userClubInfo();
      } else {
        failedSnackBar(message: response.body.toString());
      }
    } catch (error) {
      failedSnackBar(message: error.toString());
    }
  }

  Future<void> userClubInfo() async {
    final response = await http.get(
      Uri.parse('$apiUrl/me/read'),
      headers: {
        'Authorization': 'Bearer ${box.read('user')['id_token']}',
        "alg": "HS256",
        "typ": "JWT"
      },
    );

    if (response.statusCode == 200) {
      getClubData.value = jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user info ${response.body}');
    }
  }

  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      search(searchController.text);
    });
  }

  Future<void> search(String term) async {
    if (term.isEmpty) {
      searchResultsForClub.clear();
      searchResultsForTeam.clear();
      searchResultsForLeague.clear();
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
              {"club": true},
              {"team": true},
              {"league": true}
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
              {"club": true},
              {"team": true},
              {"league": true}
            ]
          });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        var dataForClub = jsonDecode(response.body)['clubs'] as List;
        var dataForTeam = jsonDecode(response.body)['teams'] as List;
        var dataForLeague = jsonDecode(response.body)['leagues'] as List;

        searchResultsForClub.value =
            dataForClub.map((club) => Club.fromJson(club)).toList();
        searchResultsForTeam.value =
            dataForTeam.map((team) => Team.fromJson(team)).toList();
        
        searchResultsForLeague.value =
            dataForLeague.map((league) => League.fromJson(league)).toList();
      } else {
        Get.snackbar("Error", response.body.toString());
      }
    } catch (error) {
      // Get.snackbar("Error", error.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

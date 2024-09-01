import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/const/api_endpoints.dart';
import 'package:sportkai/views/league/league_details_screen.dart';
import 'package:sportkai/style/app_styles.dart';
import 'package:sportkai/widgets/app_text.dart';
import 'package:sportkai/widgets/app_textfield.dart';
import 'package:sportkai/widgets/top_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyLeagueEmptyScreen extends StatefulWidget {
  const MyLeagueEmptyScreen({
    super.key,
  });

  @override
  State<MyLeagueEmptyScreen> createState() => _MyLeagueEmptyScreenState();
}

class _MyLeagueEmptyScreenState extends State<MyLeagueEmptyScreen> {
  TextEditingController searchController = TextEditingController();
    var box = GetStorage();
  
  Future<void> postLeagueData(String id, String name) async {
    final url = Uri.parse('$apiUrl/me/league');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${box.read('user')['id_token']}',
    };
    final body = jsonEncode({
      'id': id,
      'name': name,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
       // print('Data posted successfully');
       // add logic
      } else {
        failedSnackBar(message: response.body.toString());

      }
    } catch (error) {
      failedSnackBar(message: error.toString());
      
    }
  }
  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Padding(
           padding: screenWidth > 600
              ? EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth / 10)
              : const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topBar(context),
              const SizedBox(height: 15),
              appTitleText('My Leagues'),
              const SizedBox(
                height: 10,
              ),
              searchBar(context, searchController),
               appEmptyScreen(
                  'Please add your league details', 'Add a League', context, () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) =>  const LeageDetailsScreen(name: 'Details',)));
              }),
            ],
          ),
        ),
      ),
    );
  }
}
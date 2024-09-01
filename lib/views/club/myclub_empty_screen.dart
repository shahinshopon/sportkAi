import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportkai/controller/club_controller.dart';
import 'package:sportkai/controller/manage_controller.dart';
import 'package:sportkai/style/app_styles.dart';
import 'package:sportkai/views/club/myclub_view_screen.dart';
import 'package:sportkai/Widgets/app_text.dart';
import 'package:sportkai/Widgets/top_bar.dart';
import 'package:sportkai/widgets/app_button.dart';
import 'package:sportkai/widgets/app_textfield.dart';

class MyClubEmptyScreen extends StatelessWidget {
  const MyClubEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    final MyClubController controller = Get.put(MyClubController());
    final ManageController manageController = Get.put(ManageController());

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
              appTitleText('My Clubs'),
              const SizedBox(height: 10),
              searchBar(context, controller.searchController),
              const SizedBox(height: 10),
              Obx(() {
                if (manageController.getClubData.isEmpty ||
                    manageController.getClubData['message']['clubs'].isEmpty) {
                  return appEmptyScreen(
                      'Please add your club details', 'Add a Club', context,
                      () {
                    manageController.sendClubData(
                        context, "Next Level Soccer (AZ)");
                  });
                } else {
                  return SizedBox(
                    height: manageController
                          .getClubData['message']['clubs'].length*60.0,
                    child: ListView.builder(
                      itemCount: manageController
                          .getClubData['message']['clubs'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MyClubViewScreen(
                                    manageController.getClubData['message']
                                            ['clubs'][index]['club']
                                        .toString(),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              
                              decoration: cardDecoration,
                              
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                
                                child: Text(manageController
                                    .getClubData['message']['clubs'][index]
                                        ['club']
                                    .toString(),overflow: TextOverflow.ellipsis,),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
              }),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                      child: CircularProgressIndicator.adaptive());
                } else if (controller.searchResults.isNotEmpty) {
                  return const SizedBox(
                    height: 40,
                    child: Text(
                      'Your Search result',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
              Obx(() {
                if (controller.isLoading.value|| controller.searchController.text.isEmpty) {
                  return const SizedBox.shrink();
                } else if (controller.searchResults.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: controller.searchResults.length,
                      itemBuilder: (context, index) {
                        final result = controller.searchResults[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MyClubViewScreen(
                                  result.clubName,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(result.clubName),
                            trailing: circleIconButton(Icons.add, () {
                              manageController
                                  .sendClubData(context, result.clubName)
                                  .then((value) => successSnackBar(
                                      message: 'Successfully Added'));
                            }),
                          ),
                        );
                      },
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      'No results found',
                      style: TextStyle(fontSize: 16, color: Colors.green),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportkai/controller/manage_controller.dart';
import 'package:sportkai/controller/team_controller.dart';
import 'package:sportkai/style/app_styles.dart';
import 'package:sportkai/views/team/myteams_screen.dart';
import 'package:sportkai/widgets/app_button.dart';
import 'package:sportkai/widgets/app_text.dart';
import 'package:sportkai/widgets/app_textfield.dart';
import 'package:sportkai/widgets/top_bar.dart';

class MyTeamEmptyScreen extends StatelessWidget {
  const MyTeamEmptyScreen({super.key});

  @override
  Widget build(BuildContext context) {
     var screenWidth = MediaQuery.of(context).size.width;
    final MyTeamController controller = Get.put(MyTeamController());
    final ManageController manageController = Get.put(ManageController());
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:screenWidth>600?EdgeInsets.symmetric(vertical: 10,horizontal: screenWidth/10): const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              topBar(context),
              const SizedBox(height: 15),
              appTitleText('My Teams'),
              const SizedBox(height: 10),
              searchBar(context, controller.searchController),
              const SizedBox(height: 10),
              Obx(() {
                if (manageController.getClubData.isEmpty ||
                    manageController.getClubData['message']['teams'].isEmpty) {
                  return appEmptyScreen(
                      'Please add your team details', 'Add a Team', context,
                      () {
                    manageController
                        .sendTeamData("0673b678-3edf-4e83-ba8d-ae81fb6b7a2e");
                  });
                } else {
                  return SizedBox(
                     height: manageController
                          .getClubData['message']['teams'].length*60.0,
                    child: ListView.builder(
                      itemCount: manageController
                          .getClubData['message']['teams'].length,
                      itemBuilder: (context, index) {
                        var teamIndexData = manageController
                            .getClubData['message']['teams'][index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MyTeamViewScreen(
                                      teamIndexData['id']),
                                ),
                              );
                            },
                            child: Container(
                              decoration: cardDecoration,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(manageController
                                    .getClubData['message']['teams'][index]
                                        ['id']
                                    .toString()),
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
                  return const Center(child: CircularProgressIndicator.adaptive());
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
                }  else if (controller.searchResults.isNotEmpty) {
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
                                  builder: (_) => MyTeamViewScreen(
                                      result.id),
                                ),
                              );
                          },
                          child: ListTile(
                            title: Text(result.name),
                            trailing: circleIconButton(Icons.add, () {
                              manageController.sendTeamData(result.id);
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

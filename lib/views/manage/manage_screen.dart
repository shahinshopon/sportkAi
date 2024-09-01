import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportkai/controller/club_controller.dart';
import 'package:sportkai/controller/manage_controller.dart';
import 'package:sportkai/const/app_colors.dart';
import 'package:sportkai/style/app_styles.dart';
import 'package:sportkai/views/club/myclub_view_screen.dart';
import 'package:sportkai/views/team/myteams_screen.dart';
import 'package:sportkai/widgets/app_text.dart';
import 'package:sportkai/widgets/app_button.dart';
import 'package:sportkai/widgets/app_textfield.dart';
import 'package:sportkai/widgets/top_bar.dart';

class ManageScreen extends StatelessWidget {
  ManageScreen({super.key});
  final ManageController controller = Get.put(ManageController());
  final MyClubController clubController = Get.put(MyClubController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: screenWidth > 600
                ? EdgeInsets.symmetric(
                    vertical: 10, horizontal: screenWidth / 10)
                : const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                topBar(context),
                const SizedBox(height: 15),
                appTitleText('Manage'),
                const SizedBox(height: 10),
                
                searchBar(context, controller.searchController),
                const SizedBox(height: 15),
                buildTeamExpansionTile(screenWidth),
                buildClubExpansionTile(context, screenWidth),
                buildLeagueExpansionTile(screenWidth),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTeamExpansionTile(double width) {
    return Obx(() => Card(
          elevation: 2,
          child: ExpansionTile(
            backgroundColor: Colors.white,
            collapsedBackgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
               
                borderRadius: BorderRadius.circular(10)),
            collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            title: const Text('My Teams'),
            trailing: controller.teamItemExpanded.value
                ? const Icon(Icons.keyboard_arrow_down, size: 25)
                : const Icon(Icons.arrow_forward_ios, size: 15),
            leading: Image.asset('assets/icons/team.png',
                color: buttonPrimaryColor),
            children: [
              const Divider(),
              controller.getClubData.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: reuseableButton(width / 2, Colors.green, () {
                          controller.sendTeamData(
                              "0673b678-3edf-4e83-ba8d-ae81fb6b7a2e");
                        }, '+ Add a Team', Colors.white, Colors.green),
                      ),
                    )
                  : buildTeamList(),
              Obx(() {
                if (controller.isLoading.value ||
                    controller.searchController.text.isEmpty) {
                  return const SizedBox.shrink();
                } else if (controller.searchResultsForTeam.isNotEmpty) {
                  return SizedBox(
                    height: controller.searchResultsForTeam.length * 40.0,
                    child: ListView.builder(
                      itemCount: controller.searchResultsForTeam.length,
                      itemBuilder: (context, index) {
                        final result = controller.searchResultsForTeam[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MyTeamViewScreen(result.id),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  result.name,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                circleIconButton(Icons.add, () {
                                  controller.sendTeamData(result.id);
                                })
                              ],
                            ),
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
              })
            ],
            onExpansionChanged: (bool expanded) {
              controller.teamItemExpanded.value = expanded;
            },
          ),
        ));
  }

  Widget buildTeamList() {
    return controller.getClubData['message']['teams'].isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: reuseableButton(
                  MediaQuery.of(Get.context!).size.width / 2, Colors.green, () {
                controller.sendTeamData("0673b678-3edf-4e83-ba8d-ae81fb6b7a2e");
              }, '+ Add a Team', Colors.white, Colors.green),
            ),
          )
        : SizedBox(
            height: controller.getClubData['message']['teams'].length * 40.0,
            child: ListView.builder(
              itemCount: controller.getClubData['message']['teams'].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MyTeamViewScreen(controller
                            .getClubData['message']['teams'][index]['id']
                            .toString()),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.getClubData['message']['teams'][index]
                                  ['id']
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        circleIconButton(Icons.remove, () {
                          controller.sendTeamData(controller
                              .getClubData['message']['teams'][index]['id']
                              .toString());
                        })
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget buildClubExpansionTile(context, double width) {
    return Obx(() => Card(
      elevation: 2,
          child: Theme(
            data: Theme.of(Get.context!)
                .copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text('My Clubs'),
              trailing: controller.clubItemExpanded.value
                  ? const Icon(Icons.keyboard_arrow_down, size: 25)
                  : const Icon(Icons.arrow_forward_ios, size: 15),
              leading: Image.asset('assets/icons/club.png',
                  color: buttonPrimaryColor),
              children: [
                const Divider(),
                controller.getClubData.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: reuseableButton(width / 2, Colors.green, () {
                            controller.sendClubData(
                                context, "Next Level Soccer (AZ)");
                          }, '+ Add a Club', Colors.white, Colors.green),
                        ),
                      )
                    : buildClubList(context),
                Obx(() {
                  if (controller.isLoading.value ||
                      controller.searchController.text.isEmpty) {
                    return const SizedBox.shrink();
                  } else if (controller.searchResultsForClub.isNotEmpty) {
                    return SizedBox(
                      height: controller.searchResultsForClub.length * 40.0,
                      child: ListView.builder(
                        itemCount: controller.searchResultsForClub.length,
                        itemBuilder: (context, index) {
                          final result = controller.searchResultsForClub[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
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
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    result.clubName,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  circleIconButton(Icons.add, () {
                                    controller.sendClubData(
                                        context, result.clubName);
                                  })
                                ],
                              ),
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
                })
              ],
              onExpansionChanged: (bool expanded) {
                controller.clubItemExpanded.value = expanded;
              },
            ),
          ),
        ));
  }

  Widget buildClubList(context) {
    return controller.getClubData['message']['clubs'].isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: reuseableButton(
                  MediaQuery.of(Get.context!).size.width / 2, Colors.green, () {
                controller.sendClubData(context, "Next Level Soccer (AZ)");
              }, '+ Add a Club', Colors.white, Colors.green),
            ),
          )
        : SizedBox(
            height: controller.getClubData['message']['clubs'].length * 40.0,
            child: ListView.builder(
              itemCount: controller.getClubData['message']['clubs'].length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => MyClubViewScreen(
                            controller.getClubData['message']['clubs'][index]
                                    ['club']
                                .toString(),
                          ),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.getClubData['message']['clubs'][index]
                                  ['club']
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        circleIconButton(Icons.remove, () {
                          controller
                              .sendClubData(
                                  context,
                                  controller.getClubData['message']['clubs']
                                          [index]['club']
                                      .toString())
                              .then((value) => successSnackBar(
                                  message: 'Successfully remove club'));
                        })
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }

  Widget buildLeagueExpansionTile(double width) {
    return Obx(() => Card(
      elevation: 2,
          child: Theme(
            data: Theme.of(Get.context!)
                .copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              backgroundColor: Colors.white,
              collapsedBackgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              collapsedShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              title: const Text('My Leagues'),
              trailing: controller.leagueItemExpanded.value
                  ? const Icon(Icons.keyboard_arrow_down, size: 25)
                  : const Icon(Icons.arrow_forward_ios, size: 15),
              leading: Image.asset('assets/icons/league.png',
                  color: buttonPrimaryColor),
              children: [
                const Divider(),
                controller.getClubData.isEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: reuseableButton(width / 2, Colors.green, () {
                            //  controller.sendClubData("Next Level Soccer (AZ)");
                          }, '+ Add a League', Colors.white, Colors.green),
                        ),
                      )
                    : buildLeagueList(),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const SizedBox.shrink();
                  } else if (controller.searchResultsForLeague.isNotEmpty) {
                    return SizedBox(
                      height: controller.searchResultsForLeague.length * 40.0,
                      child: ListView.builder(
                        itemCount: controller.searchResultsForLeague.length,
                        itemBuilder: (context, index) {
                          final result =
                              controller.searchResultsForLeague[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  result.location,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                circleIconButton(Icons.add, () {
                                  // controller.sendTeamData(result.id);
                                })
                              ],
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
                })
              ],
              onExpansionChanged: (bool expanded) {
                controller.leagueItemExpanded.value = expanded;
              },
            ),
          ),
        ));
  }

  Widget buildLeagueList() {
    return controller.getClubData['message']['leagues'].isEmpty
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Align(
              alignment: Alignment.topLeft,
              child: reuseableButton(
                  MediaQuery.of(Get.context!).size.width / 2, Colors.green, () {
                //controller.sendClubData("Next Level Soccer (AZ)");
              }, '+ Add a League', Colors.white, Colors.green),
            ),
          )
        : SizedBox(
            height: controller.getClubData['message']['leagues'].length * 40.0,
            child: ListView.builder(
              itemCount: controller.getClubData['message']['leagues'].length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.getClubData['message']['leagues'][index]
                                  ['league']
                              .toString(),
                          overflow: TextOverflow.ellipsis,
                        ),
                        circleIconButton(Icons.remove, () {})
                      ],
                    ),
                  ),
                );
              },
            ),
          );
  }
}

import 'package:flutter/material.dart';
import 'package:sportkai/const/app_colors.dart';
import 'package:sportkai/controller/home_controller.dart';
import 'package:sportkai/views/league/league_empty_screen.dart';
import 'package:sportkai/views/club/myclub_empty_screen.dart';
import 'package:sportkai/views/manage/manage_screen.dart';
import 'package:sportkai/views/team/team_empty_screen.dart';
import 'package:get/get.dart';



class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static List<Widget> pages = <Widget>[
    const MyClubEmptyScreen(),
    const MyLeagueEmptyScreen(),
    const MyTeamEmptyScreen(),
     ManageScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final HomeController controller = Get.put(HomeController());
    
    
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage('assets/icons/club.png'),
                color: controller.selectedIndex.value == 0
                    ? buttonPrimaryColor
                    : Colors.grey,
              ),
              label: 'Clubs',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage('assets/icons/league.png'),
                color: controller.selectedIndex.value == 1
                    ? buttonPrimaryColor
                    : Colors.grey,
              ),
              label: 'Leagues',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage('assets/icons/team.png'),
                color: controller.selectedIndex.value == 2
                    ? buttonPrimaryColor
                    : Colors.grey,
              ),
              label: 'Teams',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                const AssetImage('assets/icons/Settings.png'),
                color: controller.selectedIndex.value == 3
                    ? buttonPrimaryColor
                    : Colors.grey,
              ),
              label: 'Manage',
            ),
          ],
          currentIndex: controller.selectedIndex.value,
          selectedItemColor: buttonPrimaryColor,
          onTap: controller.onItemTapped,
        ),
      ),
      backgroundColor: Colors.white,
      body: Obx(
        () => controller.isLoad.value
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : pages[controller.selectedIndex.value],
      ),
    );
  }
}

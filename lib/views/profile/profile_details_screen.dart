import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/Widgets/custom_text_widget.dart';
import 'package:sportkai/controller/auth_controller.dart';
import 'package:sportkai/style/app_styles.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen({super.key});

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen> {
  final box = GetStorage();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: const Text(
          'My Profile',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        ),
      ),
      body: Padding(
        padding:screenWidth>600? EdgeInsets.symmetric(horizontal: screenWidth/10): const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Container(
                decoration: cardDecoration,
                child: SizedBox(
                  height: 150,
                  width:screenWidth>1000? screenWidth/2.5: screenWidth>600? screenWidth/1.75:screenWidth,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(12),
                        child: Container(
                          width:screenWidth>1000?MediaQuery.of(context).size.width / 5:screenWidth>600?MediaQuery.of(context).size.width / 4: MediaQuery.of(context).size.width / 2.8,
                          decoration: BoxDecoration(
                             // color: Colors.grey.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                    image: NetworkImage(
                      box.read('user')['url'],
                    ),
                    fit: BoxFit.cover))
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const CustomTextWidget(
                            text: 'Mariya Ronaldo',
                            fontsize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                          Row(
                            children: [
                              const Icon(Icons.email, size: 18),
                              const SizedBox(
                                width: 8,
                              ),
                              CustomTextWidget(
                                text: '${box.read('user')['email']}',
                                fontsize: 14,
                              ),
                            ],
                          ),
                          InkWell(
                             onTap: () {
                authController.logout();
                },
                            child: const Row(
                              children: [
                                Icon(
                                  Icons.logout,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                CustomTextWidget(
                                  text: '+Logout',
                                  fontsize: 14,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.sizeOf(context).height * 0.2,
            // ),
             Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextWidget(
                  text: 'About App',
                  fontsize: 18,
                  fontWeight: FontWeight.w600,
                ),
                 CustomTextWidget(
                  text: 'App Version: ${box.read('profileData')['message']['version']}',
                  fontsize: 15,
                ),
                CustomTextWidget(
                  text: box.read('profileData')['message']['contact'],
                  fontsize: 15,
                ),
                
              ],
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextWidget(
                  text: 'Release Notes',
                  fontsize: 18,
                  fontWeight: FontWeight.w600,
                ),
                
                SizedBox(
                  height: 8,
                ),
                CustomTextWidget(
                  text:
                      "Note",
                  fontsize: 15,
                ),
              ],
            ),
             
          ],
        ),
      ),
    );
  }
}

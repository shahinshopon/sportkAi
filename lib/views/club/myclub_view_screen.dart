
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportkai/const/app_colors.dart';
import 'package:sportkai/controller/club_controller.dart';
import 'package:sportkai/style/app_styles.dart';
import 'package:sportkai/widgets/app_text.dart';
import 'package:sportkai/widgets/custom_text_widget.dart';
import 'package:sportkai/widgets/format_datetime.dart';
import 'package:sportkai/widgets/top_bar.dart';

class MyClubViewScreen extends StatelessWidget {
  final String clubName;
  MyClubViewScreen(this.clubName, {super.key});

  final MatchController matchController = Get.put(MatchController());


  @override
  Widget build(BuildContext context) {
     var screenWidth = MediaQuery.of(context).size.width;
    matchController.fetchClubMatches(clubName);

    return Scaffold(
      body: Obx(() {
        return matchController.isLoading.value
            ? const Center(
                child: CircularProgressIndicator.adaptive(),
              )
            : SafeArea(
                child: Padding(
                  padding:screenWidth>600?EdgeInsets.symmetric(vertical: 10,horizontal: screenWidth/10): const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      topBar(context),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          const CustomTextWidget(
                            text: 'My Clubs',
                            fontsize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Expanded(
                        child: ListView.builder(
                          itemCount: matchController.matchList.length,
                          itemBuilder: (context, index) {
                            var match = matchController.matchList[index];
                            String formattedDate =
                                formatMatchDateTime(match.matchDatetime.toString());
                            return Padding(
                              padding: const EdgeInsets.only(top: 10,left: 12,right: 12),
                              child: Container(
                                decoration: cardDecoration,
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Wrap(
                                        children: [
                                          Container(
                                            height: 25,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: buttonPrimaryColor
                                                    .withOpacity(0.1)),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 2, horizontal: 10),
                                              child: Text(
                                                formattedDate,
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: buttonPrimaryColor),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: CustomTextWidget(
                                          text: match.homeName,
                                          fontsize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 16,
                                            backgroundColor: buttonPrimaryColor
                                                .withOpacity(0.1),
                                            child: const Icon(
                                              Icons.flag,
                                              color: buttonPrimaryColor,
                                              size: 17,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Wrap(
                                                  children: [
                                                    CustomTextWidget(
                                                      text: match.homeName,
                                                      fontsize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                    const CustomTextWidget(
                                                      text: ' vs ',
                                                      fontsize: 14,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                    CustomTextWidget(
                                                      text: match.awayName,
                                                      fontsize: 14,
                                                      fontWeight: FontWeight.w400,
                                                    ),
                                                  ],
                                                ),
                                                shadowText('${match.homeScore} (O+${match.awayScore},D+${match.homeScore}) - ${match.awayScore} (O-${match.awayScore},D+${match.homeScore})')
                                                
                                               
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
      }),
    );
  }
}


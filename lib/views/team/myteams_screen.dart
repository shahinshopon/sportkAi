
import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sportkai/Widgets/app_text.dart';
import 'package:sportkai/Widgets/top_bar.dart';
import 'package:sportkai/const/api_endpoints.dart';
import 'package:sportkai/const/app_colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:sportkai/style/app_styles.dart';
import 'package:sportkai/widgets/charts_widget.dart';
import 'package:sportkai/widgets/custom_text_widget.dart';
import 'package:sportkai/widgets/format_datetime.dart';

class MyTeamViewScreen extends StatefulWidget {
  MyTeamViewScreen(this.id);
  String id;

  @override
  State<MyTeamViewScreen> createState() => _MyTeamViewScreenState();
}

class _MyTeamViewScreenState extends State<MyTeamViewScreen> {
 
  var box = GetStorage();
  List teamData = [];
  List<String>? splitText;
  Future<void> readTeamData() async {
    final url = Uri.parse('$apiUrl/team');
    final headers = {
      'Content-Type': 'application/json',
    };
    final body = jsonEncode({"id": widget.id});

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        teamData = jsonDecode(response.body);
        splitText = teamData[0]['agebracket'].split(' ');
        setState(() {
          isLoad = false;
        });
      } else {
        failedSnackBar(message: response.body.toString());
      }
    } catch (error) {
      failedSnackBar(message: error.toString());
    }
  }

  bool isLoad = true;
  @override
  void initState() {
    super.initState();
    readTeamData();
  }

  final List<FlSpot> dummyData1 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });
  final List<FlSpot> dummyData2 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });
  final List<FlSpot> dummyData3 = List.generate(8, (index) {
    return FlSpot(index.toDouble(), index * Random().nextDouble());
  });

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isLoad
          ? const Center(
              child: CircularProgressIndicator.adaptive(),
            )
          : SingleChildScrollView(
              child: SafeArea(
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
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          appTitleText(teamData[0]['club']),
                        ],
                      ),
                      // const SizedBox(
                      //   height: 15,
                      // ),
                      // Slider(
                      //   value: _sliderValue,
                      //   min: 0.0,
                      //   max: 2.0,
                      //   divisions: 2,
                      //   label: _sliderOptions[_sliderValue],
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _sliderValue = value;
                      //     });
                      //   },
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     appSubTitleText('-1M'),
                      //     appSubTitleText('Today'),
                      //     appSubTitleText('1M'),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextWidget(
                        text: teamData[0]['name'].isEmpty
                            ? 'NEXT LEVEL 2016 - Boys Red - East Valley'
                            : teamData[0]['name'],
                        fontsize: 14,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                shadowText('Gender'),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: shadowText('State'),
                                ),
                                shadowText('Age'),
                              ],
                            ),
                            const SizedBox(
                              width: 150,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appSubTitleText(splitText![0]),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child:
                                      appSubTitleText(teamData[0]['location']),
                                ),
                                appSubTitleText(
                                    splitText![1].replaceAll('U', '')),
                                // appSubTitleText(teamData[0]['agebracket']),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.3 + 20,
                          width: double.infinity,
                          // color: Colors.amber,
                          child: Stack(
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 38),
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: VerticalDivider(
                                    indent: 45,
                                    endIndent: 90,
                                    color: Colors.blue,
                                    thickness: 10,
                                  ),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.centerRight,
                                child: CustomTextWidget(
                                  text: 'Team\n87.0',
                                  fontsize: 14,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 1, vertical: 18),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CustomTextWidget(
                                        text: 'Schedule \n       4.0',
                                        fontsize: 13,
                                      ),
                                      Container(
                                        height: 10,
                                        width: 10,
                                        color: Colors.green.shade900,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 40),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.1 +
                                              52,
                                      child: const ChartsWidget(
                                        start: 1,
                                        second: 2,
                                        third: 5,
                                        fourth: 8,
                                        fith: 13,
                                        width: 10,
                                        chartCOlor: Colors.green,
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 18),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CustomTextWidget(
                                        text: 'Offense\n       41.0',
                                        fontsize: 13,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                    0.1 -
                                                13,
                                        width: 12,
                                        color: const Color(0xff00B6C7),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 8),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.1 +
                                              50,
                                      width: MediaQuery.sizeOf(context).width *
                                          0.9,
                                      child: const ChartsWidget(
                                        start: 20,
                                        second: 19,
                                        third: 17,
                                        fourth: 12,
                                        fith: 9,
                                        width: 80,
                                        chartCOlor: Color(0xff8CDEE6),
                                      )),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 85),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const CustomTextWidget(
                                        text: 'Defense \n      41.0',
                                        fontsize: 13,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                    0.1 -
                                                8,
                                        width: 12,
                                        color: const Color(0xffFF7425),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 48),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: SizedBox(
                                      height:
                                          MediaQuery.sizeOf(context).height *
                                                  0.1 +
                                              46,
                                      // width: MediaQuery.sizeOf(context).width * 0.9- 20,
                                      child: const ChartsWidget(
                                        start: 7,
                                        second: 6,
                                        third: 8,
                                        fourth: 10,
                                        fith: 10,
                                        width: 80,
                                        chartCOlor: Color(0xffFFC09D),
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                     
                      const Text(
                        'Trend',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CircleAvatar(radius: 7,backgroundColor: Colors.green,),
                          SizedBox(width: 10,),
                          Text('Offence'),
                           SizedBox(width: 30,),
                          CircleAvatar(radius: 7,backgroundColor: Colors.red,),
                           SizedBox(width: 10,),
                          Text('Deffence',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),),
                        ],
                      ),

                      Container(
                        height: 350,
                        padding: const EdgeInsets.all(20),
                        width: double.infinity,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            LineChart(
                              LineChartData(
                                minY: -7.5,
                                maxY: 7.5,
                                titlesData: FlTitlesData(
                                  show: true,
                                  bottomTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  topTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  rightTitles: AxisTitles(
                                    sideTitles: SideTitles(showTitles: false),
                                  ),
                                  leftTitles: AxisTitles(
                                    sideTitles: SideTitles(
                                      showTitles: true,
                                      interval: 2.5,
                                      reservedSize: 60,
                                      getTitlesWidget: (value, meta) {
                                        if (value == 0) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                value.toInt().toString(),
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12,
                                                ),
                                              ),
                                              SizedBox(
                                                  height:
                                                      4), // Spacing between the line and the text
                                            ],
                                          );
                                        }

                                        return Text(
                                          value.toInt().toString(),
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                          ),
                                          textAlign: TextAlign.center,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                gridData: FlGridData(
                                  drawHorizontalLine: true,
                                  horizontalInterval: 3,
                                  getDrawingHorizontalLine: (value) {
                                    if (value == 0) {
                                      return FlLine(
                                        color: Colors.red,
                                        strokeWidth: 1,
                                      );
                                    }
                                    return FlLine(
                                      color: Colors.grey,
                                      strokeWidth: 0.5,
                                    );
                                  },
                                  drawVerticalLine: false,
                                ),
                                borderData: FlBorderData(show: false),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: [
                                      FlSpot(0, -2),
                                      FlSpot(0, 3),
                                      FlSpot(1, 2),
                                      FlSpot(1, -2),
                                      FlSpot(2, -3),
                                      FlSpot(2, 3),
                                      FlSpot(3, 2),
                                      FlSpot(3, 4),
                                      FlSpot(4, 3),
                                      FlSpot(4, -2),
                                    
                                    ],
                                    isCurved: false,
                                    barWidth: 0,
                                    isStrokeCapRound: false,
                                    color: Colors.blue,
                                    dotData: FlDotData(
                                        show: true,
                                        getDotPainter:
                                            (spot, percent, barData, index) {
                                          // Use index to apply different colors to different spots
                                          Color dotColor;
                                          switch (index) {
                                            case 0:
                                              dotColor = Colors.red;
                                              break;
                                            case 1:
                                              dotColor = Colors.green;
                                              break;
                                            case 2:
                                              dotColor = Colors.red;
                                              break;
                                            case 3:
                                              dotColor = Colors.green;
                                              break;
                                            case 4:
                                              dotColor = Colors.red;
                                              break;
                                            case 5:
                                              dotColor = Colors.green;
                                              break;
                                            case 6:
                                              dotColor = Colors.red;
                                              break;
                                            case 7:
                                              dotColor = Colors.green;
                                              break;
                                            case 8:
                                              dotColor = Colors.red;
                                              break;
                                            default:
                                              dotColor = Colors.green;
                                          }
                                          return FlDotCirclePainter(
                                            radius: 4,
                                            color: dotColor,
                                            strokeWidth: 2,
                                            strokeColor: Colors.white,
                                          );
                                        }),
                                    belowBarData: BarAreaData(show: false),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                                top: 155,
                                left: 30,
                                
                                child: SizedBox(
                                  width: screenWidth/1.25,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        appSubTitleText('-6'),
                                        appSubTitleText('-5'),
                                        appSubTitleText('-4'),
                                        appSubTitleText('-2'),
                                        appSubTitleText('Last'),
                                      ]),
                                ))
                          ],
                        ),
                       
                      ),
                       const SizedBox(
                        height: 20,
                      ),
                       SizedBox(
                        height: teamData[2]['games'].length * 190.0,
                        child: ListView.builder(
                            itemCount: teamData[2]['games'].length,
                            itemBuilder: (context, index) {
                              var indexData = teamData[2]['games'][index];

                              String formattedDate = formatMatchDateTime(
                                  indexData['match_datetime']);
                              return Container(
                                decoration: cardDecoration,
                                // shape: RoundedRectangleBorder(
                                //     borderRadius: BorderRadius.circular(16)),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                const Icon(
                                                    Icons.sports_football),
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints(
                                                      maxWidth:
                                                          100), // Adjust max width
                                                  child: appSubTitleText(
                                                      indexData['away_name']),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              height: 30,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                  color:
                                                      const Color(0xffEFF0F2),
                                                  borderRadius:
                                                      BorderRadius.circular(8)),
                                              child: Center(
                                                  child: Text(
                                                '${indexData['away_score']}:${indexData['home_score']}',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              )),
                                            ),
                                            Column(
                                              children: [
                                                const Icon(
                                                    Icons.sports_football),
                                                ConstrainedBox(
                                                  constraints: const BoxConstraints(
                                                      maxWidth:
                                                          100), // Adjust max width
                                                  child: appSubTitleText(
                                                      indexData['home_name']),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      shadowText(
                                          '+${indexData['away_score']} Offences  &  - ${indexData['home_score']} Defenses')
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

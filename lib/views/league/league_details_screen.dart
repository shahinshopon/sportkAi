import 'package:flutter/material.dart';
import 'package:sportkai/Widgets/app_text.dart';
import 'package:sportkai/Widgets/charts_widget.dart';
import 'package:sportkai/Widgets/custom_text_widget.dart';
import 'package:sportkai/const/app_colors.dart';

class LeageDetailsScreen extends StatefulWidget {
  final String name;
  const LeageDetailsScreen({super.key, required this.name});

  @override
  State<LeageDetailsScreen> createState() => _LeageDetailsScreenState();
}

class _LeageDetailsScreenState extends State<LeageDetailsScreen> {
  List<ChartData> data1 = [
    ChartData('2010', 2),
    ChartData('2011', 9),
    ChartData('2012', 80),
    ChartData('2013', 75),
    ChartData('2014', 20),
  ];
  List<ChartData> data2 = [
    ChartData('2010', 120),
    ChartData('2011', 40),
    ChartData('2012', 15),
    ChartData('2013', 38),
    ChartData('2014', 82),
  ];
  List<ChartData> data3 = [
    ChartData('2010', 5),
    ChartData('2011', 8),
    ChartData('2012', 12),
    ChartData('2013', 15),
    ChartData('2014', 18),
  ];

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: false,
        title: CustomTextWidget(
          text: widget.name,
          fontsize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: SafeArea(
        child: Padding(
           padding: screenWidth > 600
              ? EdgeInsets.symmetric(vertical: 10, horizontal: screenWidth / 10)
              : const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomTextWidget(
                  text: 'NEXT LEVEL 2016 - Boys Red - East Valley',
                  fontsize: 14,
                ),
                Center(
                    child: Image.asset(
                  'assets/images/club_logo.png',
                  height: 100,
                )),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        shadowText('Sex'),
                        shadowText('State'),
                        shadowText('Coach'),
                        shadowText('Manager'),
                      ],
                    ),
                    const SizedBox(width: 100,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        appSubTitleText('Girls'),
                        appSubTitleText('CA'),
                        appSubTitleText('George Malik'),
                        appSubTitleText('Charles Kumar'),
                      ],
                    ),
                  ],
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
                              indent: 55,
                              endIndent: 95,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            child: SizedBox(
                                height:
                                    MediaQuery.sizeOf(context).height * 0.1 +
                                        52,
                                child: const ChartsWidget(
                                  start: 1,
                                  second: 2,
                                  third: 6,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CustomTextWidget(
                                  text: 'Offense\n       41.0',
                                  fontsize: 13,
                                ),
                                Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1 -
                                          16,
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
                                    MediaQuery.sizeOf(context).height * 0.1 +
                                        60,
                                width: MediaQuery.sizeOf(context).width * 0.9,
                                child: const ChartsWidget(
                                  start: 20,
                                  second: 19,
                                  third: 17,
                                  fourth: 10,
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const CustomTextWidget(
                                  text: 'Defense \n      41.0',
                                  fontsize: 13,
                                ),
                                Container(
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.1 -
                                          13,
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
                                    MediaQuery.sizeOf(context).height * 0.1 +
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
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Image.asset('assets/img.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context,index){
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 25,
                                
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: buttonPrimaryColor.withOpacity(0.1)
                                  
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                                  child: Text('Win 5/2',style: TextStyle(fontSize: 12,fontWeight: FontWeight.w500,color: buttonPrimaryColor),),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        const Icon(Icons.sports_football),
                                        appSubTitleText('2012 Next Level')
                                      ],
                                    ),
                                    Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color:const Color(0xffEFF0F2),
                                        borderRadius: BorderRadius.circular(8)
                                      ),
                                      child: const Center(child: Text('3:2',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),)),
                                    ),
                                    Column(
                                      children: [
                                        const Icon(Icons.sports_football),
                                        appSubTitleText('2012 Next Level')
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              shadowText('+3 Offences  &  - 2 Defenses')
                              
                            ],
                          ),
                        ),
                      );
                    }),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}

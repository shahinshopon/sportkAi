// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';
// import 'package:sportkai/widgets/app_text.dart';

// import '../../Widgets/custom_text_widget.dart';

// class TeamDetailsScreen extends StatelessWidget {
//   var teamDetailsData;
//   TeamDetailsScreen(this.teamDetailsData, {super.key});
//   final List<double> offenseValues = [1, 6, 5, 2, 4, 3];
//   final List<double> defenseValues = [7, 4, 2, 5, 6, 1];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         centerTitle: false,
//         title: const CustomTextWidget(
//           text: 'Team Details',
//           fontsize: 20,
//           fontWeight: FontWeight.w600,
//         ),
//       ),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 CustomTextWidget(
//                   text: teamDetailsData[0]['name'].isEmpty
//                       ? 'NEXT LEVEL 2016 - Boys Red - East Valley'
//                       : teamDetailsData[0]['name'],
//                   fontsize: 14,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(top: 10, bottom: 15),
//                   child: Center(
//                       child: Image.asset(
//                     'assets/images/club_logo.png',
//                     height: 100,
//                   )),
//                 ),
//                 Row(
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         shadowText('Sex'),
//                         shadowText('State'),
//                       ],
//                     ),
//                     const SizedBox(
//                       width: 150,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         appSubTitleText(teamDetailsData[0]['agebracket']),
//                         appSubTitleText(teamDetailsData[0]['location']),
//                       ],
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 const Text(
//                   'Ranking',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
//                 ),
//                 const Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     CircleAvatar(
//                       radius: 7,
//                       backgroundColor: Colors.green,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'Offence',
//                       style:
//                           TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//                     ),
//                     SizedBox(
//                       width: 30,
//                     ),
//                     CircleAvatar(
//                       radius: 7,
//                       backgroundColor: Colors.red,
//                     ),
//                     SizedBox(
//                       width: 10,
//                     ),
//                     Text(
//                       'Defense',
//                       style:
//                           TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   height: 100,
//                   child: LineChart(
//                     LineChartData(
//                       // minX: 0,
//                       // maxX: 5,
//                       // minY: 1,
//                       // maxY: 7,
//                       lineBarsData: [
//                         LineChartBarData(
//                           spots: List.generate(
//                               teamDetailsData[1]['trend'].length,
//                               (index) => FlSpot(
//                                   index.toDouble(),
//                                   teamDetailsData[1]['trend'][index]
//                                       ['offense'])),
//                           isCurved: true,
//                           color: Colors.green,
//                           barWidth: 4,
//                           isStrokeCapRound: true,
//                           belowBarData: BarAreaData(show: false),
//                         ),
//                       ],
//                       gridData: const FlGridData(show: false),
//                       titlesData: const FlTitlesData(
//                         topTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                         rightTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                         bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                         leftTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                       ),
//                       borderData: FlBorderData(show: false),
//                     ),
//                   ),
//                 ),
//                 const Divider(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     appSubTitleText('G1'),
//                     appSubTitleText('G2'),
//                     appSubTitleText('G3'),
//                     appSubTitleText('G4'),
//                     appSubTitleText('G5'),
//                     appSubTitleText('G6'),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 100,
//                   child: LineChart(
//                     LineChartData(
//                       // minX: 0,
//                       // maxX: 5,
//                       // minY: 0,
//                       // maxY: 26,
//                       lineBarsData: [
//                         LineChartBarData(
//                           spots: List.generate(
//                               teamDetailsData[1]['trend'].length,
//                               (index) => FlSpot(
//                                   index.toDouble(),
//                                   teamDetailsData[1]['trend'][index]
//                                       ['defense'])),
//                           isCurved: true,
//                           color: Colors.red,
//                           barWidth: 4,
//                           isStrokeCapRound: true,
//                           belowBarData: BarAreaData(show: false),
//                           aboveBarData: BarAreaData(show: false),
//                         ),
//                       ],
//                       gridData: const FlGridData(show: false),
//                       titlesData: const FlTitlesData(
//                         topTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                         rightTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                         bottomTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                         leftTitles: AxisTitles(
//                             sideTitles: SideTitles(showTitles: false)),
//                       ),
//                       borderData: FlBorderData(show: false),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

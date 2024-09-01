// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:sportkai/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}


//this is my code. Everything works fine. I want to implement this using getx state management and MVC pattern in Flutter.
//dbc0d080-d523-4839-8609-a18ccce4723c

// style old code
// successSnacber({required String message}) {
//   return SnackBar(
//     content: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           'Success',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white),
//         ),
//         Text(message)
//       ],
//     ),
//     backgroundColor: Colors.green,
//     duration: const Duration(seconds: 2),
//   );
// }

// failedSnackBar({
//   required String message,
// }) {
//   return SnackBar(
//     content: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [const Text(
//           'Failed',
//           style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500,color: Colors.white),
//         ), Text(message)],
//     ),
//     backgroundColor: Colors.red,
//     duration: const Duration(seconds: 2),
//   );
// }

//auth service old code
// class AuthService {
//   final auth0 = Auth0(
//     AuthConfig.domain,
//     AuthConfig.clientId,
//   );
//   final auth0Web = Auth0Web(AuthConfig.domain, AuthConfig.clientId);
//   Future<dynamic> login(context) async {
//     try {
//       if (kIsWeb) {
//         final result = await auth0Web.loginWithRedirect(
//             redirectUrl: AuthConfig.redirectUri);
//         return result;
//       } else {
//         final result =
//             await auth0.webAuthentication(scheme: 'com.sportkai.app').login();
//         return result;
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//               .showSnackBar(failedSnackBar(message: e.toString()));
//     }
//   }

//   Future logout(context) async {
//     var box = GetStorage();
//     try {
//       String returnToUrl;
//       if (Platform.isAndroid) {
//         returnToUrl =
//             'https://dev-j2ruirzod4scshbl.us.auth0.com/android/com.sportkai.app/logout';
//       } else if (Platform.isIOS) {
//         returnToUrl =
//             'com.sportkai.app://dev-j2ruirzod4scshbl.us.auth0.com/ios/com.sportkai.app/logout';
//       } else if (Platform.isMacOS) {
//         returnToUrl =
//             'com.sportkai.app://dev-j2ruirzod4scshbl.us.auth0.com/macos/com.sportkai.app/logout';
//       } else {
//         returnToUrl =
//             'http://localhost:8080/logout'; // For web or other platforms
//       }
//       await box.remove('user');
//       await auth0.webAuthentication().logout(returnTo: returnToUrl);
//     } catch (e) {
//       ScaffoldMessenger.of(context)
//               .showSnackBar(failedSnackBar(message: e.toString()));
//     }
//   }
// }

// splash screen old code
// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }
// class _SplashScreenState extends State<SplashScreen> {
//   final formKey = GlobalKey<FormState>();
//   final emailText = TextEditingController();
//   final auth0Web = Auth0Web(AuthConfig.domain, AuthConfig.clientId);
//   final box = GetStorage();
//   auth(authService) async {
//     final userAuthResult = await authService.login(context);
//     if (userAuthResult != null) {
//       Map user = {
//         'email': userAuthResult.user.email.toString(),
//         'url': userAuthResult.user.pictureUrl.toString(),
//         'id_token': userAuthResult.idToken.toString(),
//       };
//       await box.write('user', user);
//       Navigator.push(
//           context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//     } else {
//       if (Platform.isIOS) {
//         exit(0);
//       } else {
//         SystemNavigator.pop();
//       }
//     }
//   }
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final authService = Provider.of<AuthService>(context, listen: false);
//     if (box.read('user') != null) {
//       Future.delayed(const Duration(seconds: 2)).then((value) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//       });
//     } else {
//       if (kIsWeb) {
//         auth0Web.onLoad().then((credentials) {
//           if (credentials != null) {
//             Map user = {
//               'email': credentials.user.email.toString(),
//               'url': credentials.user.pictureUrl.toString(),
//               'id_token': credentials.idToken.toString(),
//             };
//             box.write('user', user);
//             // Handle authenticated user
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (_) => const HomeScreen()));
//           } else {
//             SystemNavigator.pop();
//           }
//         }).catchError((e) {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(failedSnackBar(message: e.toString()));
//         });
//       } else {
//         try {
//           auth(authService);
//         } catch (e) {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(failedSnackBar(message: e.toString()));
//         }
//       }
//     }
//     super.didChangeDependencies();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       canPop: true,
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         body: Center(
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Image.asset(
//               'assets/images/logo.png',
//               height: 100,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//login screen old code
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final formKey = GlobalKey<FormState>();
//   final emailText = TextEditingController();
//   final auth0Web = Auth0Web(AuthConfig.domain, AuthConfig.clientId);
//   final box = GetStorage();
//   @override
//   void initState() {
//     if (box.read('user') != null) {
//       Future.delayed(const Duration(seconds: 1)).then((value) {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (_) => HomeScreen()));
//       });
//     } else {
//       if (kIsWeb) {
//         auth0Web.onLoad().then((credentials) {
//           if (credentials != null) {
//             // print(credentials.user.email);
//             // print(credentials.user.pictureUrl);
//             // print(credentials.idToken);
//             // print(credentials.user.sub.characters.last);
//             //  return credentials;
//             Map user = {
//               'email': credentials.user.email.toString(),
//               'url': credentials.user.pictureUrl.toString(),
//               'id_token': credentials.idToken.toString(),
//             };
//             box.write('user', user);
//             // Handle authenticated user
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (_) => HomeScreen()));
//           } else {
//             print('No credentials found');
//           }
//         }).catchError((e) {
//           print('Error loading credentials: $e');
//         });
//       }
//     }
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     final authService = Provider.of<AuthService>(context);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.only(left: 20, right: 20),
//           child: CustomButtonWidget(
//             size: Size(MediaQuery.sizeOf(context).width, 58),
//             ontap: () async {
//               final userAuthResult = await authService.login();
//               //autho is giving user email,image,id token and access token
//               // print(userAuthResult.user.email);
//               // print(userAuthResult.user.pictureUrl);
//               // print(userAuthResult.idToken);
//               // print(userAuthResult.accessToken);
//               if (userAuthResult != null) {
//                 Map user = {
//                   'email': userAuthResult.user.email.toString(),
//                   'url': userAuthResult.user.pictureUrl.toString(),
//                   'id_token': userAuthResult.idToken.toString(),
//                 };
//                 await box.write('user', user);
//                 Navigator.push(
//                     context, MaterialPageRoute(builder: (_) => HomeScreen()));
//               }
//             },
//             child: const CustomTextWidget(
//               text: 'Start',
//               colorText: Colors.white,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//home screen old code
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   bool isLoad = true;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   int _selectedIndex = 0;

//   static List<Widget> pages = <Widget>[
//     const MyClubEmptyScreen(),
//     const MyLeagueEmptyScreen(),
//     const MyTeamEmptyScreen(),
//     const ManageScreen()
//   ];
//   //// get user all data
//   final box = GetStorage();
//   Future<Map<String, dynamic>> getUserInfo() async {
//     final response = await http.get(
//       Uri.parse(
//           userInfoApiUrl),
//       headers: {
//         'Authorization': 'Bearer ${box.read('user')['id_token']}',
//         "alg": "HS256",
//         "typ": "JWT"
//       },
//     );

//     if (response.statusCode == 200) {
//       box.write('profileData', jsonDecode(response.body));
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to fetch user info ${response.body}');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     getUserInfo().then((value) {
//       Future.delayed(Duration(seconds: 1)).then((value) {
//         setState(() {
//           isLoad = false;
//         });
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: BottomNavigationBar(
//         items: <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: ImageIcon(
//               const AssetImage('assets/icons/club.png'),
//               color: _selectedIndex == 0 ? buttonPrimaryColor : Colors.grey,
//             ),
//             label: 'Clubs',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(
//               const AssetImage('assets/icons/league.png'),
//               color: _selectedIndex == 1 ? buttonPrimaryColor : Colors.grey,
//             ),
//             label: 'Leagues',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(
//               const AssetImage('assets/icons/team.png'),
//               color: _selectedIndex == 2 ? buttonPrimaryColor : Colors.grey,
//             ),
//             label: 'Teams',
//           ),
//           BottomNavigationBarItem(
//             icon: ImageIcon(
//               const AssetImage('assets/icons/Settings.png'),
//               color: _selectedIndex == 3 ? buttonPrimaryColor : Colors.grey,
//             ),
//             label: 'Manage',
//           ),
//         ],
//         currentIndex: _selectedIndex,
//         selectedItemColor: buttonPrimaryColor,
//         onTap: _onItemTapped,
//       ),
//       backgroundColor: Colors.white,
//       body: isLoad
//           ? const Center(
//               child: CircularProgressIndicator.adaptive(),
//             )
//           : pages.elementAt(_selectedIndex),
//     );
//   }
// }

//my club old code
// class MyClubEmptyScreen extends StatefulWidget {
//   const MyClubEmptyScreen({
//     super.key,
//   });
//   @override
//   State<MyClubEmptyScreen> createState() => _MyClubEmptyScreenState();
// }
// class _MyClubEmptyScreenState extends State<MyClubEmptyScreen> {
//   Map<String, dynamic>? getClubData;
//   Map<String, dynamic>? sendClubData;
//   bool isLoad = false;
//   addClubData(String clubName) async {
//     final url = Uri.parse(clubPostApiUrl);
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final body =
//         jsonEncode({"id": box.read('profileData')['id'], "club": clubName});
//     try {
//       final response = await http.post(url, headers: headers, body: body);
//       if (response.statusCode == 200) {
//         sendClubData = jsonDecode(response.body) as Map<String, dynamic>;
//         setState(() {
//           isLoad = true;
//         });
//       } else {   
//         ScaffoldMessenger.of(context)
//             .showSnackBar(failedSnackBar(message: response.body.toString()));
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(failedSnackBar(message: error.toString()));
//     }
//   }
//   Future<Map<String, dynamic>> userClubInfo() async {
//     final response = await http.get(
//       Uri.parse(userInfoApiUrl),
//       headers: {
//         'Authorization': 'Bearer ${box.read('user')['id_token']}',
//         "alg": "HS256",
//         "typ": "JWT"
//       },
//     );
//     if (response.statusCode == 200) {
//       getClubData = jsonDecode(response.body) as Map<String, dynamic>;
//       setState(() {});
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to fetch user info ${response.body}');
//     }
//   }
//   var box = GetStorage();
//   /////////////////for search start////////////
//  TextEditingController searchController = TextEditingController();
//   List<dynamic> searchResults = [];
//   bool isLoading = false;
//   Timer? _debounce;
//   void _onSearchChanged() {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       search(searchController.text);
//     });
//   }
//   Future<void> search(String term) async {
//     if (term.isEmpty) {
//       setState(() {
//         searchResults = [];
//       });
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     final url = Uri.parse(searchApiUrl);
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final body = box.hasData('filterData')
//         ? jsonEncode({
//             "term": term,
//             "scope": [
//               {"club": true}
//             ],
//             "filters": [
//               {
//                 "sex": [
//                   {"${box.read('filterData')['sex']}": true}
//                 ],
//                 "age": [
//                   {"${box.read('filterData')['age']}": true}
//                 ]
//               }
//             ]
//           })
//         : jsonEncode({
//             "term": term,
//             "scope": [
//               {"club": true}
//             ]
//           });

//     try {
//       final response = await http.post(url, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         setState(() {
//           searchResults = responseData[
//               'clubs']; // Adjust based on your API response structure
//           isLoading = false;
//         });
//       } else {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(failedSnackBar(message: response.body.toString()));
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context)
//           .showSnackBar(failedSnackBar(message: error.toString()));
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//   /////////////////for search end////////////
//   @override
//   void initState() {
//     userClubInfo();
//     searchController.addListener(_onSearchChanged);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     searchController.removeListener(_onSearchChanged);
//     searchController.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 15),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               topBar(context),
//               appTitleText('My Clubs'),
//               const SizedBox(
//                 height: 10,
//               ),
//               searchBar(context, searchController),
//               const SizedBox(
//                 height: 10,
//               ),
//               // user favourite club or add club
//               getClubData == null
//                   ? appEmptyScreen(
//                       'Please add your club details', 'Add a Club', context,
//                       () {
//                       addClubData("Next Level Soccer (AZ)");
//                     })
//                   : getClubData!['message']['clubs'].isEmpty ||
//                           getClubData!['message']['clubs'] == null
//                       ? appEmptyScreen(
//                           'Please add your club details', 'Add a Club', context,
//                           () {
//                           addClubData("Next Level Soccer (AZ)");
//                         })
//                       : Expanded(
//                           child: ListView.builder(
//                               itemCount:
//                                   getClubData!['message']['clubs'].length,
//                               itemBuilder: (context, index) {
//                                 return Padding(
//                                   padding: const EdgeInsets.only(top: 10),
//                                   child: InkWell(
//                                     onTap: () {
//                                       Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) => MyClubViewScreen(
//                                                   '${getClubData!['message']['clubs'][index]['club']}')));
//                                     },
//                                     child: Card(
//                                         child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                           '${getClubData!['message']['clubs'][index]['club']}'),
//                                     )),
//                                   ),
//                                 );
//                               }),
//                         ),
//               //club search result
//               isLoading
//                   ? const SizedBox.shrink()
//                   : const SizedBox(
//                       height: 40,
//                       child: Text(
//                         'Your Search result',
//                         style: TextStyle(
//                             fontSize: 16, fontWeight: FontWeight.w500),
//                       )),

//               isLoading
//                   ? const SizedBox.shrink()
//                   : Expanded(
//                       child: searchResults.isEmpty
//                           ? const SizedBox.shrink()
//                           : ListView.builder(
//                               itemCount: searchResults.length,
//                               itemBuilder: (context, index) {
//                                 final result = searchResults[index];
//                                 return InkWell(
//                                   onTap: () {
//                                     addClubData(result['club']);
//                                   },
//                                   child: ListTile(
//                                     title: Text(result['club'] ??
//                                         'No name available'), // Adjust based on your response structure
//                                   ),
//                                 );
//                               },
//                             ),
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// my club view drop down old code
  // String? selectedGender;
  // String? selectedLocation;
  // List<Map<String, dynamic>>? gender;
  // List<Map<String, dynamic>>? location;
    // gender = box
    //     .read('profileData')['message']['filters']['genders']
    //     .cast<Map<String, dynamic>>();
    // selectedGender = gender![0]['name'];

    // location = box
    //     .read('profileData')['message']['filters']['locations']
    //     .cast<Map<String, dynamic>>();
    // selectedLocation = location![0]['name'];
// const SizedBox(
                    //   height: 15,
                    // ),
                    // const Text(
                    //   'NEXT LEVEL - EAST VALLEY',
                    //   style:
                    //       TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                    // ),
                    // const SizedBox(
                    //   height: 10,
                    // ),
                    // Row(
                    //   children: [
                    //     Container(
                    //       width: 120,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey, width: 1),
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //       padding: const EdgeInsets.symmetric(horizontal: 12),
                    //       child: DropdownButtonHideUnderline(
                    //         child: DropdownButton<String>(
                    //           value: selectedGender,
                    //           items: gender!.map<DropdownMenuItem<String>>(
                    //               (Map<String, dynamic> gender) {
                    //             return DropdownMenuItem<String>(
                    //               value: gender['name'].toString(),
                    //               child: Text(gender['name']!.toString()),
                    //             );
                    //           }).toList(),
                    //           onChanged: (String? newValue) {
                    //             setState(() {
                    //               selectedGender = newValue!;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 20,
                    //     ),
                    //     Container(
                    //       width: 200,
                    //       decoration: BoxDecoration(
                    //         border: Border.all(color: Colors.grey, width: 1),
                    //         borderRadius: BorderRadius.circular(8),
                    //       ),
                    //       padding: const EdgeInsets.symmetric(horizontal: 12),
                    //       child: DropdownButtonHideUnderline(
                    //         child: DropdownButton(
                    //           isExpanded: true,
                    //           hint: const Text("All Location"),
                    //           value: selectedLocation,
                    //           items: location!.map<DropdownMenuItem<String>>(
                    //               (Map<String, dynamic> location) {
                    //             return DropdownMenuItem<String>(
                    //               value: location['name'].toString(),
                    //               child: Text(location['name']!.toString()),
                    //             );
                    //           }).toList(),
                    //           onChanged: (String? newValue) {
                    //             setState(() {
                    //               selectedLocation = newValue!;
                    //             });
                    //           },
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),

//league screen old code
 // body: SingleChildScrollView(
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.all(10.0),
      //       child: Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           topBar(context),
      //           appTitleText('My Leagues'),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           Row(
      //             children: [
      //               const Expanded(
      //                 child: SizedBox(
      //                   height: 45,
      //                   width: double.infinity,
      //                   child: TextInputCustomWIdget(
      //                     hintext: 'Search in app',
      //                     circle: 14,
      //                     hideWIdget: Icon(Icons.search),
      //                     borderSide: BorderSide(color: buttonPrimaryColor),
      //                   ),
      //                 ),
      //               ),
      //               const SizedBox(
      //                 width: 15,
      //               ),
      //               filterButton(() {
      //                 Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (_) => const FilterScreen()));
      //               }),
      //             ],
      //           ),
      //           const SizedBox(
      //             height: 15,
      //           ),
      //           //  Card(
      //           //   child: Column(
      //           //     children: [
      //           //       const Text(
      //           //         'My Leagues',
      //           //         style: TextStyle(
      //           //             fontSize: 14, fontWeight: FontWeight.w500),
      //           //       ),
      //           //       const Divider(),
      //           //       Row(
      //           //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           //         children: [
      //           //           const Row(
      //           //             children: [
      //           //               Icon(Icons.sports_football),
      //           //               SizedBox(
      //           //                 width: 8,
      //           //               ),
      //           //               Text(
      //           //                 'U7 - Boys - AZ',
      //           //                 style: TextStyle(
      //           //                     fontSize: 16, fontWeight: FontWeight.w400),
      //           //               ),
      //           //             ],
      //           //           ),
      //           //           IconButton(
      //           //             onPressed: () {
      //           //                 Navigator.push(
      //           //                   context,
      //           //                   MaterialPageRoute(
      //           //                       builder: (_) =>
      //           //                           LeageDetailsScreen(name: e.name)));
      //           //             },
      //           //             icon: Icon(Icons.keyboard_arrow_right,
      //           //             color: Colors.blueAccent,)
      //           //           )
      //           //         ],
      //           //       ),
      //           //     ],
      //           //   ),
      //           // ),
      //           Card(
      //             child: Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   const Text(
      //                     'My Leagues',
      //                     style: TextStyle(
      //                         fontSize: 14, fontWeight: FontWeight.w500),
      //                   ),
      //                   const Divider(),
      //                   Column(
      //                     children: mainTeamList.map((e) {
      //                       return Padding(
      //                         padding: const EdgeInsets.all(8.0),
      //                         child: Theme(
      //                           data: Theme.of(context)
      //                               .copyWith(dividerColor: Colors.transparent),
      //                           child: ExpansionTile(
      //                             leading: Icon(Icons.sports_football),
      //                             trailing: GestureDetector(
      //                               onTap: () {
      //                                 Navigator.push(
      //                                     context,
      //                                     MaterialPageRoute(
      //                                         builder: (_) =>
      //                                             LeageDetailsScreen(
      //                                                 name: e.name)));
      //                               },
      //                               child: const Icon(
      //                                 Icons.keyboard_arrow_right,
      //                                 color: Colors.blueAccent,
      //                               ),
      //                             ),
      //                             title: CustomTextWidget(
      //                               text: e.name,
      //                               fontsize: 15,
      //                             ),
      //                             // children: listTeams.map((d) {
      //                             //   return Padding(
      //                             //     padding: const EdgeInsets.all(8.0),
      //                             //     child: Column(
      //                             //       mainAxisAlignment: MainAxisAlignment.center,
      //                             //       children: [
      //                             //         Padding(
      //                             //           padding: const EdgeInsets.symmetric(
      //                             //               horizontal: 20),
      //                             //           child: Container(
      //                             //             height: 40,
      //                             //             width: double.infinity,
      //                             //             alignment: Alignment.centerLeft,
      //                             //             decoration: BoxDecoration(
      //                             //                 border: Border(
      //                             //                     top: BorderSide(
      //                             //                         color: Colors.grey
      //                             //                             .withOpacity(0.3)),
      //                             //                     bottom: BorderSide(
      //                             //                         color: Colors.grey
      //                             //                             .withOpacity(0.3)))),
      //                             //             child: CustomTextWidget(
      //                             //               text: d.teamNames,
      //                             //               fontsize: 15,
      //                             //             ),
      //                             //           ),
      //                             //         )
      //                             //       ],
      //                             //     ),
      //                             //   );
      //                             // }).toList(),
      //                           ),
      //                         ),
      //                       );
      //                     }).toList(),
      //                   ),
      //                 ],
      //               ),
      //             ),
      //           ),
      //           const Text(
      //             'Top 10 Teams',
      //             style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      //           ),
      //           Column(
      //             children: listTeams.asMap().entries.map((entry) {
      //               int index = entry.key;
      //               ListTeams team = entry.value;
      //               bool isEven = index % 2 == 0;
      //               return Padding(
      //                 padding: const EdgeInsets.all(8.0),
      //                 child: Column(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Padding(
      //                       padding: const EdgeInsets.symmetric(horizontal: 20),
      //                       child: Container(
      //                         height: 35,
      //                         width: double.infinity,
      //                         alignment: Alignment.centerLeft,
      //                         decoration: isEven
      //                             ? null
      //                             : BoxDecoration(
      //                                 color:
      //                                     buttonPrimaryColor.withOpacity(0.1),
      //                                 borderRadius: BorderRadius.circular(16.0),
      //                               ),
      //                         child: Padding(
      //                           padding: const EdgeInsets.all(8.0),
      //                           child: CustomTextWidget(
      //                             text: team.teamNames,
      //                             fontsize: 15,
      //                           ),
      //                         ),
      //                       ),
      //                     )
      //                   ],
      //                 ),
      //               );
      //             }).toList(),
      //           ),
      //           SizedBox(
      //             height: 200,
      //             child: ListView.builder(
      //               itemCount: 2,
      //               itemBuilder: (context,index){
      //                 return Card(
      //               child: ListTile(
      //                 leading: CircleAvatar(
      //                   radius: 16,
      //                   backgroundColor: buttonPrimaryColor.withOpacity(0.1),
      //                   child: const Icon(
      //                     Icons.flag,
      //                     color: buttonPrimaryColor,
      //                   ),
      //                 ),
      //                 title: const CustomTextWidget(
      //                   text: '2016 Next Level vs Away Team',
      //                   fontsize: 14,
      //                   fontWeight: FontWeight.w400,
      //                 ),
      //                 subtitle: const CustomTextWidget(
      //                   text: '3 (O+2, D+3) - 2(0-2, D+3)',
      //                   fontsize: 12,
      //                   fontWeight: FontWeight.w400,
      //                   colorText: fontShadowColor,
      //                 ),
      //               ),
      //             );
      //               }
      //               ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

//league details screen old code
// SizedBox(
                //   height: MediaQuery.sizeOf(context).height * 0.3,
                //   width: MediaQuery.sizeOf(context).width,
                //   child:SfCartesianChart(
                //               primaryXAxis: const CategoryAxis(),
                //               // primaryYAxis: CategoryAxis(),
                //               series: <CartesianSeries>[
                //                   StackedAreaSeries<ChartData, String>(
                //                     trendlines: [
                //                       Trendline(
                //                       type: TrendlineType.polynomial,
                //                       polynomialOrder: 3,
                //                       color: Colors.red),
                //                       ],
                //                     color: const Color(0xffA4D9E4),
                //                       dataSource: data1,
                //                       xValueMapper: (ChartData data, _) => data.x,
                //                       yValueMapper: (ChartData data, _) => data.y
                //                   ),
                //                   StackedAreaSeries<ChartData, String>(
                //                       trendlines: [
                //                         Trendline(
                //                       type: TrendlineType.polynomial,
                //                       polynomialOrder: 2,
                //                       color: Colors.green),
                //                        Trendline(
                //                       type: TrendlineType.polynomial,
                //                       polynomialOrder: 8,
                //                       color: Colors.purpleAccent),
                //                         ],
                //                     color: const Color(0xff04A6EA),
                //                       dataSource: data2,
                //                       xValueMapper: (ChartData data, _) => data.x,
                //                       yValueMapper: (ChartData data, _) => data.y
                //                   ),
                //                   StackedAreaSeries<ChartData, String>(
                //                      trendlines: [
                //                       Trendline(
                //                       type: TrendlineType.polynomial,
                //                       polynomialOrder: 3,
                //                       color: Colors.orange),
                //                       ],
                //                       dataSource: data3,
                //                       xValueMapper: (ChartData data, _) => data.x,
                //                       yValueMapper: (ChartData data, _) => data.y
                // ),
                // ]
                // )

//my team screen old code
// body: SingleChildScrollView(
      //   child: Column(
      //     children: [
      //           Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      //             child: Container(
      //                   height: 50,
      //                   width: double.infinity,
      //                   alignment: Alignment.centerLeft,
      //                   decoration:  BoxDecoration(
      //                     border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.4)),
      //                     bottom: BorderSide(color: Colors.grey.withOpacity(0.4)))
      //                   ),
      //                   child: const CustomTextWidget(text: 'NEXT LEVEL 2016 - Boys Red - East Valley', fontsize: 16,),
      //                 ),
      //           ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: SizedBox(
      //           height: MediaQuery.sizeOf(context).height * 0.3 + 20,
      //           width: double.infinity,
      //           // color: Colors.amber,
      //           child: Stack(
      //             children: [
      //               const Padding(
      //                 padding: EdgeInsets.symmetric(horizontal: 38),
      //                 child: Align(
      //                   alignment: Alignment.centerRight,
      //                   child: VerticalDivider(
      //                     indent: 55,
      //                     endIndent: 95,
      //                     color: Colors.blue,
      //                     thickness: 10,
      //                   ),
      //                 ),
      //               ),
      //               const Align(
      //                 alignment: Alignment.centerRight,
      //                 child: CustomTextWidget(text: 'Team\n87.0', fontsize: 14,),
      //               ),
      //                Padding(
      //                  padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 18),
      //                  child: Align(
      //                   alignment: Alignment.bottomLeft,
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
      //                       const CustomTextWidget(text: 'Schedule \n       4.0', fontsize: 13,),
      //                       Container(
      //                         height: 10,
      //                         width: 10,
      //                         color: Colors.green.shade900,
      //                       )
      //                     ],
      //                   ),
      //                                  ),
      //                ),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 40),
      //                   child: Align(
      //                     alignment: Alignment.bottomLeft,
      //                     child: SizedBox(
      //                     height: MediaQuery.sizeOf(context).height * 0.1 +52,
      //                             child: const ChartsWidget(
      //                               start: 1,
      //                             second: 2,
      //                             third: 6,
      //                             fourth: 8,
      //                             fith: 13,
      //                             width: 10,
      //                             chartCOlor: Colors.green,)
      //                             ),
      //                   ),
      //                 ),
      //                 Padding(
      //                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 18),
      //                  child: Align(
      //                   alignment: Alignment.topLeft,
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
      //                       const CustomTextWidget(text: 'Offense\n       41.0', fontsize: 13,),
      //                       Container(
      //                         height: MediaQuery.sizeOf(context).height* 0.1 - 16,
      //                         width: 12,
      //                         color: const Color(0xff00B6C7),
      //                       )
      //                     ],
      //                   ),
      //                   ),
      //                ),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 8),
      //                   child: Align(
      //                     alignment: Alignment.topLeft,
      //                     child: SizedBox(
      //                     height: MediaQuery.sizeOf(context).height * 0.1 +60,
      //                     width: MediaQuery.sizeOf(context).width * 0.9,
      //                             child:  const ChartsWidget(
      //                             start: 20,
      //                             second: 19,
      //                             third: 17,
      //                             fourth: 10,
      //                             fith: 9,
      //                             width: 80,
      //                             chartCOlor: Color(0xff8CDEE6),)
      //                             ),
      //                   ),
      //                 ),
      //                  Padding(
      //                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 85),
      //                  child: Align(
      //                   alignment: Alignment.bottomLeft,
      //                   child: Row(
      //                     crossAxisAlignment: CrossAxisAlignment.center,
      //                     children: [
      //                       const CustomTextWidget(text: 'Defense \n      41.0', fontsize: 13,),
      //                       Container(
      //                         height: MediaQuery.sizeOf(context).height* 0.1 - 13,
      //                         width: 12,
      //                         color: const Color(0xffFF7425),
      //                       )
      //                     ],
      //                   ),
      //                   ),
      //                ),
      //                 Padding(
      //                   padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 48),
      //                   child: Align(
      //                     alignment: Alignment.bottomLeft,
      //                     child: SizedBox(
      //                     height: MediaQuery.sizeOf(context).height * 0.1 +46,
      //                     // width: MediaQuery.sizeOf(context).width * 0.9- 20,
      //                             child:  const ChartsWidget(
      //                             start: 7,
      //                             second: 6,
      //                             third: 8,
      //                             fourth: 10,
      //                             fith: 10,
      //                             width: 80,
      //                             chartCOlor: Color(0xffFFC09D),)
      //                             ),
      //                   ),
      //                 ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       SizedBox(
      //         child: Image.asset('assets/img.png'),
      //       ),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Column(
      //           children: listSub.map((e){
      //             return Padding(
      //               padding: const EdgeInsets.all(8.0),
      //               child: Container(
      //                     height: 50,
      //                     width: double.infinity,
      //                     alignment: Alignment.centerLeft,
      //                     decoration:  BoxDecoration(
      //                       border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.4)),
      //                       bottom: BorderSide(color: Colors.grey.withOpacity(0.4)))
      //                     ),
      //                     child: Column(
      //                       crossAxisAlignment: CrossAxisAlignment.center,
      //                       mainAxisAlignment: MainAxisAlignment.center,
      //                       children: [
      //                         CustomTextWidget(text: e.title, fontsize: 14,),
      //                         CustomTextWidget(text: e.datesSub, fontsize: 12,),
      //                       ],
      //                     ),
      //                   ),
      //             );
      //           }).toList(),
      //         ),
      //       )
      //       // SizedBox(
      //       //   height: MediaQuery.sizeOf(context).height * 0.3,
      //       //   width: MediaQuery.sizeOf(context).width,
      //       //   child:SfCartesianChart(
      //       //               primaryXAxis: const CategoryAxis(),
      //       //               // primaryYAxis: CategoryAxis(),
      //       //               series: <CartesianSeries>[
      //       //                   StackedAreaSeries<ChartData, String>(
      //       //                     trendlines: [
      //       //                       Trendline(
      //       //                       type: TrendlineType.polynomial,
      //       //                       polynomialOrder: 3,
      //       //                       color: Colors.red),
      //       //                       ],
      //       //                     color: const Color(0xffA4D9E4),
      //       //                       dataSource: data1,
      //       //                       xValueMapper: (ChartData data, _) => data.x,
      //       //                       yValueMapper: (ChartData data, _) => data.y
      //       //                   ),
      //       //                   StackedAreaSeries<ChartData, String>(
      //       //                       trendlines: [
      //       //                         Trendline(
      //       //                       type: TrendlineType.polynomial,
      //       //                       polynomialOrder: 2,
      //       //                       color: Colors.green),
      //       //                        Trendline(
      //       //                       type: TrendlineType.polynomial,
      //       //                       polynomialOrder: 8,
      //       //                       color: Colors.purpleAccent),
      //       //                         ],
      //       //                     color: const Color(0xff04A6EA),
      //       //                       dataSource: data2,
      //       //                       xValueMapper: (ChartData data, _) => data.x,
      //       //                       yValueMapper: (ChartData data, _) => data.y
      //       //                   ),
      //       //                   StackedAreaSeries<ChartData, String>(
      //       //                      trendlines: [
      //       //                       Trendline(
      //       //                       type: TrendlineType.polynomial,
      //       //                       polynomialOrder: 3,
      //       //                       color: Colors.orange),
      //       //                       ],
      //       //                       dataSource: data3,
      //       //                       xValueMapper: (ChartData data, _) => data.x,
      //       //                       yValueMapper: (ChartData data, _) => data.y
      //                         // ),
      //                     // ]
      //                 // )
      //     ],
      //   ),
      // ),

//manage screen old code
// class ManageScreen extends StatefulWidget {
//   const ManageScreen({super.key});

//   @override
//   State<ManageScreen> createState() => _ManageScreenState();
// }

// class _ManageScreenState extends State<ManageScreen> {
//   final box = GetStorage();
//   //for club
//   Map<String, dynamic>? removeClubData;
//   Map<String, dynamic>? getClubData;
//   bool isLoad = false;
//   sendClubData(String clubName) async {
//     final url = Uri.parse(clubPostApiUrl);
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final body =
//         jsonEncode({"id": box.read('profileData')['id'], "club": clubName});

//     try {
//       final response = await http.post(url, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         removeClubData = jsonDecode(response.body) as Map<String, dynamic>;

//         setState(() {
//           //isLoad = true;
//         });
//       } else {
//        failedSnackBar(message: response.body.toString());
//       }
//     } catch (error) {
//      failedSnackBar(message: error.toString());
//     }
//   }

//   //for team
//    Map<String, dynamic>? removeTeamData;
//   sendTeamData(String teamID) async {
//     final url = Uri.parse(teamPostApiUrl);
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final body =
//         jsonEncode({"id": box.read('profileData')['id'], "team": teamID});

//     try {
//       final response = await http.post(url, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         removeTeamData = jsonDecode(response.body) as Map<String, dynamic>;

//         setState(() {
//           //isLoad = true;
//         });
//       } else {
//         failedSnackBar(message: response.body.toString());
//       }
//     } catch (error) {
//      failedSnackBar(message: error.toString());
//     }
//   }

//   // for favourite
//   Future<Map<String, dynamic>> userClubInfo() async {
//     final response = await http.get(
//       Uri.parse(userInfoApiUrl),
//       headers: {
//         'Authorization': 'Bearer ${box.read('user')['id_token']}',
//         "alg": "HS256",
//         "typ": "JWT"
//       },
//     );

//     if (response.statusCode == 200) {
//       getClubData = jsonDecode(response.body) as Map<String, dynamic>;
//       setState(() {});
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to fetch user info ${response.body}');
//     }
//   }

//   bool clubItemExpanded = false;
//   bool teamItemExpanded = false;
//   bool leagueItemExpanded = false;

//   //for search
//   TextEditingController searchController = TextEditingController();
//   List<dynamic> searchResultsForClub = [];
//   List<dynamic> searchResultsForTeam = [];
//   List<dynamic> searchResultsForLeague = [];
//   bool isLoading = false;
//   Timer? _debounce;

//   void _onSearchChanged() {
//     if (_debounce?.isActive ?? false) _debounce?.cancel();
//     _debounce = Timer(const Duration(milliseconds: 500), () {
//       search(searchController.text);
//     });
//   }

//   Future<void> search(String term) async {
//     if (term.isEmpty) {
//       setState(() {
//         searchResultsForClub = [];
//         searchResultsForTeam = [];
//         searchResultsForLeague = [];
//       });
//       return;
//     }

//     setState(() {
//       isLoading = true;
//     });

//     final url = Uri.parse(searchApiUrl);
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final body = box.hasData('filterData')
//         ? jsonEncode({
//             "term": term,
//             "scope": [
//               {"club": true},
//               {"team": true},
//               {"league": true}
//             ],
//             "filters": [
//               {
//                 "sex": [
//                   {"${box.read('filterData')['sex']}": true}
//                 ],
//                 "age": [
//                   {"${box.read('filterData')['age']}": true}
//                 ]
//               }
//             ]
//           })
//         : jsonEncode({
//             "term": term,
//             "scope": [
//               {"club": true},
//               {"team": true},
//               {"league": true}
//             ]
//           });

//     try {
//       final response = await http.post(url, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         setState(() {
//           searchResultsForClub = responseData['clubs'];
//           searchResultsForTeam = responseData['teams'];
//           searchResultsForLeague = responseData['leagues'];
//           isLoading = false;
//         });
//       } else {
//          failedSnackBar(message: response.body.toString());
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//      failedSnackBar(message: error.toString());
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   @override
//   void initState() {
//     userClubInfo();
//     searchController.addListener(_onSearchChanged);
//     super.initState();
//   }

//   @override
//   void dispose() {
//     searchController.removeListener(_onSearchChanged);
//     searchController.dispose();
//     _debounce?.cancel();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     var width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 topBar(context),
//                 appTitleText('Manage'),
//                 const SizedBox(
//                   height: 10,
//                 ),
//                 searchBar(context, searchController),

//                 const SizedBox(
//                   height: 15,
//                 ),
//                 //for team
//                 Card(
//                   child: Theme(
//                     data: Theme.of(context)
//                         .copyWith(dividerColor: Colors.transparent),
//                     child: ExpansionTile(
//                       title: const Text('My Teams'),
//                       trailing: teamItemExpanded
//                           ? const Icon(Icons.keyboard_arrow_down, size: 25)
//                           : const Icon(
//                               Icons.arrow_forward_ios,
//                               size: 15,
//                             ),
//                       leading: Image.asset('assets/icons/team.png',
//                           color: buttonPrimaryColor),
//                       children: [
//                         //for team
//                         getClubData == null
//                             ? Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Align(
//                                     alignment: Alignment.topLeft,
//                                     child: reuseableButton(
//                                         width / 2, Colors.green, () {
//                                       sendTeamData(
//                                               "0673b678-3edf-4e83-ba8d-ae81fb6b7a2e")
//                                           .then((value) {
//                                         setState(() {
//                                           userClubInfo();
//                                         });
//                                       });
//                                     }, '+ Add a Team', Colors.white,
//                                         Colors.green)),
//                               )
//                             : getClubData!['message']['teams'].isEmpty ||
//                                     getClubData!['message']['teams'] == null
//                                 ? Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Align(
//                                         alignment: Alignment.topLeft,
//                                         child: reuseableButton(
//                                             width / 2, Colors.green, () {
//                                           sendTeamData(
//                                                   "0673b678-3edf-4e83-ba8d-ae81fb6b7a2e")
//                                               .then((value) {
//                                             setState(() {
//                                               userClubInfo();
//                                             });
//                                           });
//                                         }, '+ Add a Team', Colors.white,
//                                             Colors.green)),
//                                   )
//                                 : SizedBox(
//                                     height: getClubData!['message']['teams']
//                                             .length *
//                                         40.0,
//                                     child: ListView.builder(
//                                         itemCount: getClubData!['message']
//                                                 ['teams']
//                                             .length,
//                                         itemBuilder: (context, index) {
//                                           return InkWell(
//                                             onTap: () {
//                                               // Navigator.push(
//                                               //     context,
//                                               //     MaterialPageRoute(
//                                               //         builder: (_) =>
//                                               //             MyClubViewScreen(
//                                               //                 '${getClubData!['message']['clubs'][index]['club']}')));
//                                             },
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Row(
//                                                 mainAxisAlignment:
//                                                     MainAxisAlignment
//                                                         .spaceBetween,
//                                                 children: [
//                                                   Text(getClubData!['message']
//                                                           ['teams'][index]['id']
//                                                       .toString()),
//                                                   circleIconButton(Icons.remove,
//                                                       () {
//                                                     sendTeamData(getClubData![
//                                                                     'message']
//                                                                 ['teams'][index]
//                                                             ['id'])
//                                                         .then((value) {
//                                                       setState(() {
//                                                         userClubInfo();
//                                                       });
//                                                     });
//                                                   })
//                                                 ],
//                                               ),
//                                             ),
//                                           );
//                                         }),
//                                   ),

//                         //for search
//                         isLoading
//                             ? const SizedBox.shrink()
//                             : searchResultsForTeam.isEmpty
//                                 ? const SizedBox.shrink()
//                                 : SizedBox(
//                                     height: searchResultsForTeam.length * 40.0,
//                                     child: ListView.builder(
//                                       itemCount: searchResultsForTeam.length,
//                                       itemBuilder: (context, index) {
//                                         final result =
//                                             searchResultsForTeam[index];
//                                         return InkWell(
//                                           onTap: () {
//                                             //  addClubData(result['club']);
//                                           },
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   result['name'] ??
//                                                       'No name available',
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                 ),
//                                                 circleIconButton(Icons.add, () {
//                                                   sendTeamData(result['id']);
//                                                 })
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                       ],
//                       onExpansionChanged: (bool expanded) {
//                         setState(() {
//                           teamItemExpanded = expanded;
//                         });
//                       },
//                     ),
//                   ),
//                 ),

//                 //for club
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 7),
//                   child: Card(
//                     child: Theme(
//                       data: Theme.of(context)
//                           .copyWith(dividerColor: Colors.transparent),
//                       child: ExpansionTile(
//                         title: const Text('My Clubs'),
//                         trailing: clubItemExpanded
//                             ? const Icon(Icons.keyboard_arrow_down, size: 25)
//                             : const Icon(
//                                 Icons.arrow_forward_ios,
//                                 size: 15,
//                               ),
//                         leading: Image.asset('assets/icons/club.png'),
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: getClubData == null
//                                 ? Align(
//                                     alignment: Alignment.topLeft,
//                                     child: reuseableButton(
//                                         width / 2, Colors.green, () {
//                                       sendClubData("Next Level Soccer (AZ)")
//                                           .then((value) {
//                                         setState(() {
//                                           userClubInfo();
//                                         });
//                                       });
//                                     }, '+ Add a Club', Colors.white,
//                                         Colors.green))
//                                 : getClubData!['message']['clubs'].isEmpty ||
//                                         getClubData!['message']['clubs'] == null
//                                     ? Align(
//                                         alignment: Alignment.topLeft,
//                                         child: reuseableButton(
//                                             width / 2, Colors.green, () {
//                                           sendClubData("Next Level Soccer (AZ)")
//                                               .then((value) {
//                                             setState(() {
//                                               userClubInfo();
//                                             });
//                                           });
//                                         }, '+ Add a Club', Colors.white,
//                                             Colors.green))
//                                     : Column(
//                                         children: [
//                                           //for my club
//                                           SizedBox(
//                                             height: getClubData!['message']
//                                                         ['clubs']
//                                                     .length *
//                                                 40.0,
//                                             child: ListView.builder(
//                                                 itemCount:
//                                                     getClubData!['message']
//                                                             ['clubs']
//                                                         .length,
//                                                 itemBuilder: (context, index) {
//                                                   return Padding(
//                                                     padding:
//                                                         const EdgeInsets.only(
//                                                             top: 0),
//                                                     child: InkWell(
//                                                       onTap: () {
//                                                         Navigator.push(
//                                                             context,
//                                                             MaterialPageRoute(
//                                                                 builder: (_) =>
//                                                                     MyClubViewScreen(
//                                                                         '${getClubData!['message']['clubs'][index]['club']}')));
//                                                       },
//                                                       child: Padding(
//                                                         padding:
//                                                             const EdgeInsets
//                                                                 .all(8.0),
//                                                         child: Row(
//                                                           mainAxisAlignment:
//                                                               MainAxisAlignment
//                                                                   .spaceBetween,
//                                                           children: [
//                                                             Text(
//                                                                 '${getClubData!['message']['clubs'][index]['club']}'),
//                                                             circleIconButton(
//                                                                 Icons.remove,
//                                                                 () {
//                                                               sendClubData(
//                                                                       '${getClubData!['message']['clubs'][index]['club']}')
//                                                                   .then(
//                                                                       (value) {
//                                                                 setState(() {
//                                                                   userClubInfo();
//                                                                 });
//                                                               });
//                                                             })
//                                                           ],
//                                                         ),
//                                                       ),
//                                                     ),
//                                                   );
//                                                 }),
//                                           ),
//                                           //for search
//                                           isLoading
//                                               ? const SizedBox.shrink()
//                                               : searchResultsForClub.isEmpty
//                                                   ? const SizedBox.shrink()
//                                                   : SizedBox(
//                                                       height:
//                                                           searchResultsForClub
//                                                                   .length *
//                                                               40.0,
//                                                       child: ListView.builder(
//                                                         itemCount:
//                                                             searchResultsForClub
//                                                                 .length,
//                                                         itemBuilder:
//                                                             (context, index) {
//                                                           final result =
//                                                               searchResultsForClub[
//                                                                   index];
//                                                           return InkWell(
//                                                             onTap: () {
//                                                               //  addClubData(result['club']);
//                                                             },
//                                                             child: Padding(
//                                                               padding:
//                                                                   const EdgeInsets
//                                                                       .all(8.0),
//                                                               child: Row(
//                                                                 mainAxisAlignment:
//                                                                     MainAxisAlignment
//                                                                         .spaceBetween,
//                                                                 children: [
//                                                                   Text(
//                                                                       result['club'] ??
//                                                                           'No name available',
//                                                                       overflow:
//                                                                           TextOverflow
//                                                                               .ellipsis),
//                                                                   circleIconButton(
//                                                                       Icons.add,
//                                                                       () {
//                                                                     sendClubData(
//                                                                         result[
//                                                                             'club']);
//                                                                   })
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                           );
//                                                         },
//                                                       ),
//                                                     ),
//                                         ],
//                                       ),
//                           )
//                         ],
//                         onExpansionChanged: (bool expanded) {
//                           setState(() {
//                             clubItemExpanded = expanded;
//                           });
//                         },
//                       ),
//                     ),
//                   ),
//                 ),
//                 //for league
//                 Card(
//                   color: Colors.white,
//                   elevation: 2,
//                   child: Theme(
//                     data: Theme.of(context)
//                         .copyWith(dividerColor: Colors.transparent),
//                     child: ExpansionTile(
//                       title: const Text('My Leagues'),
//                       trailing: leagueItemExpanded
//                           ? const Icon(Icons.keyboard_arrow_down, size: 25)
//                           : const Icon(
//                               Icons.arrow_forward_ios,
//                               size: 15,
//                             ),
//                       leading: Image.asset('assets/icons/league.png',
//                           color: buttonPrimaryColor),
//                       children: [
//                         Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: getClubData == null
//                                 ? Align(
//                                     alignment: Alignment.topLeft,
//                                     child: reuseableButton(
//                                         width / 2, Colors.green, () {
//                                       //  sendClubData("Next Level Soccer (AZ)");
//                                     }, '+ Add a League', Colors.white,
//                                         Colors.green))
//                                 : getClubData!['message']['leagues'].isEmpty ||
//                                         getClubData!['message']['leagues'] ==
//                                             null
//                                     ? Align(
//                                         alignment: Alignment.topLeft,
//                                         child: reuseableButton(
//                                             width / 2,
//                                             Colors.green,
//                                             () {},
//                                             '+ Add a League',
//                                             Colors.white,
//                                             Colors.green))
//                                     : const Text('data')),
//                         //for search
//                         isLoading
//                             ? const SizedBox.shrink()
//                             : searchResultsForLeague.isEmpty
//                                 ? const SizedBox.shrink()
//                                 : SizedBox(
//                                     height:
//                                         searchResultsForLeague.length * 40.0,
//                                     child: ListView.builder(
//                                       itemCount: searchResultsForLeague.length,
//                                       itemBuilder: (context, index) {
//                                         final result =
//                                             searchResultsForLeague[index];
//                                         return InkWell(
//                                           onTap: () {
//                                             //  addClubData(result['club']);
//                                           },
//                                           child: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Text(
//                                                         '${result['location']}-',
//                                                         overflow: TextOverflow
//                                                             .ellipsis),
//                                                     Text(
//                                                         result['agebracket'] ??
//                                                             '',
//                                                         overflow: TextOverflow
//                                                             .ellipsis),
//                                                   ],
//                                                 ),
//                                                 circleIconButton(
//                                                     Icons.add, () {})
//                                               ],
//                                             ),
//                                           ),
//                                         );
//                                       },
//                                     ),
//                                   ),
//                       ],
//                       onExpansionChanged: (bool expanded) {
//                         setState(() {
//                           leagueItemExpanded = expanded;
//                         });
//                       },
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

// team old code
// class MyTeamEmptyScreen extends StatefulWidget {
//   const MyTeamEmptyScreen({
//     super.key,
//   });

//   @override
//   State<MyTeamEmptyScreen> createState() => _MyTeamEmptyScreenState();
// }

// class _MyTeamEmptyScreenState extends State<MyTeamEmptyScreen> {
//   Map<String, dynamic>? teamData;
//   sendTeamData() async {
//     final url = Uri.parse(teamPostApiUrl);
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final body = jsonEncode({
//       "id": "2e5693fd-6b56-4e77-ae60-33d2878d4056",
//       "team": "0673b678-3edf-4e83-ba8d-ae81fb6b7a2e"
//     });

//     try {
//       final response = await http.post(url, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         teamData = jsonDecode(response.body) as Map<String, dynamic>;

//         setState(() {
//           //   isLoad = false;
//         });
//         return teamData;
//       } else {
//          failedSnackBar(message: response.body.toString());
      
//       }
//     } catch (error) {
//        failedSnackBar(message: error.toString());
      
//     }
//   }
  
//    TextEditingController searchController = TextEditingController();
//   @override
//   void initState() {
//     sendTeamData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: SafeArea(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             topBar(context),
//             appTitleText('My Teams'),
//             const SizedBox(
//               height: 10,
//             ),
//             searchBar(context, searchController),
//             teamData == null
//                 ? appEmptyScreen(
//                     'Please add your team details', 'Add a Team', context, () {
//                     sendTeamData();
//                     // Navigator.push(
//                     //     context,
//                     //     MaterialPageRoute(
//                     //         builder: (_) => const MyTeamViewScreen()));
//                   })
//                 : teamData!['message']['teams'].isEmpty ||
//                         teamData!['message']['teams'] == null
//                     ? appEmptyScreen(
//                         'Please add your team details', 'Add a Team', context,
//                         () {
//                         sendTeamData();
//                         // Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //         builder: (_) => const MyTeamViewScreen()));
//                       })
//                     : Expanded(
//                         child: ListView.builder(
//                             itemCount: teamData!['message']['teams'].length,
//                             itemBuilder: (context, index) {
//                               return Padding(
//                                 padding: const EdgeInsets.only(top: 20),
//                                 child: InkWell(
//                                   onTap: () {
//                                     Navigator.push(
//                                         context,
//                                         MaterialPageRoute(
//                                             builder: (_) =>
//                                                 const MyTeamViewScreen()));
//                                   },
//                                   child: Card(
//                                       child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                         '${teamData!['message']['teams'][index]['name']}'),
//                                   )),
//                                 ),
//                               );
//                             }),
//                       ),
//           ],
//         ),
//       ),
//     ));
//   }
// }




// filter screen old code 
// class FilterScreen extends StatefulWidget {
//   const FilterScreen({super.key});

//   @override
//   State<FilterScreen> createState() => _FilterScreenState();
// }

// class _FilterScreenState extends State<FilterScreen> {

//   var box = GetStorage();

//   //sex
//   List<Sex> sexList = [];
//   String? selectedSex;
//   void fetchSexsFromStorage() {
//     List<dynamic> jsonData = box.read('profileData')['message']['filters']
//             ['genders'] ??[];
//     sexList = parseSexs(jsonData);
//     if (sexList.isNotEmpty) {
//       selectedSex = sexList.first.name;
//     }
//     setState(() {});
//   }

//   List<Sex> parseSexs(List<dynamic> jsonData) {
//     return jsonData.map((json) => Sex.fromJson(json)).toList();
//   }

//   //age
//   List<Age> ageList = [];
//   Age? selectedAge;
//   void fetchAgesFromStorage() {
//     List<dynamic> jsonData = box.read('profileData')['message']['filters']
//             ['ages'] ??
//         []; // Fetch the list from Get Storage
//     ageList = parseAges(jsonData);
//     if (ageList.isNotEmpty) {
//       selectedAge =
//           ageList.first; // Set the initial value to the first item in the list
//     }
//     setState(() {}); // Refresh the UI
//   }

//   List<Age> parseAges(List<dynamic> jsonData) {
//     return jsonData.map((json) => Age.fromJson(json)).toList();
//   }

//   //location
//   List<Location> locationList = [];
//   Location? selectedLocation;
//   void fetchLocationFromStorage() {
//     List<dynamic> jsonData = box.read('profileData')['message']['filters']
//             ['locations'] ??
//         []; // Fetch the list from Get Storage
//     locationList = parseLocations(jsonData);
//     if (locationList.isNotEmpty) {
//       selectedLocation = locationList
//           .first; // Set the initial value to the first item in the list
//     }
//     setState(() {});
//   }

//   List<Location> parseLocations(List<dynamic> jsonData) {
//     return jsonData.map((json) => Location.fromJson(json)).toList();
//   }

//   @override
//   void initState() {
//     fetchSexsFromStorage();
//     fetchAgesFromStorage();
//     fetchLocationFromStorage();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: const CustomTextWidget(text: 'Filter'),
//         leading: IconButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             icon: const Icon(Icons.close)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             const CustomTextWidget(text: 'Select Sex'),
//             Expanded(
//               child: SizedBox(
//                 child: ListView.builder(
//                     itemCount: sexList.length,
//                     itemBuilder: (context, index) {
//                       final sex = sexList[index];
//                       return CheckboxListTile(
//                         title: Text(sex.name),
//                         value: selectedSex == sex.name,
//                         onChanged: (bool? value) {
//                           setState(() {
//                             if (value == true) {
//                               selectedSex = sex.name;
//                             } else {
//                               selectedSex = null;
//                             }
//                           });
//                         },
//                       );
//                     }),
//               ),
//             ),
//             const CustomTextWidget(text: 'Select Age'),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey, width: 1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<Age>(
//                   isExpanded: true,
//                   value: selectedAge,
//                   items: ageList.map((Age age) {
//                     return DropdownMenuItem<Age>(
//                       value: age,
//                       child: Text('U${age.name}'),
//                     );
//                   }).toList(),
//                   onChanged: (Age? newValue) {
//                     setState(() {
//                       selectedAge = newValue;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 10,
//             ),
//             const CustomTextWidget(text: 'Select Location'),
//             const SizedBox(
//               height: 10,
//             ),
//             Container(
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey, width: 1),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 12),
//               child: DropdownButtonHideUnderline(
//                 child: DropdownButton<Location>(
//                   isExpanded: true,
//                   value: selectedLocation,
//                   items: locationList.map((Location location) {
//                     return DropdownMenuItem<Location>(
//                       value: location,
//                       child: Text(location.name),
//                     );
//                   }).toList(),
//                   onChanged: (Location? newValue) {
//                     setState(() {
//                       selectedLocation = newValue;
//                     });
//                   },
//                 ),
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 reuseableButton(MediaQuery.of(context).size.width / 2.5,
//                     buttonOptionalColor, () {
//                   try {
//                     box.remove('filterData');
//                     successSnackBar(message: 'Filter Data Remove');

//                     Navigator.pop(context);
//                   } catch (e) {
//                     failedSnackBar(message: e.toString());
//                   }
//                 }, 'Clear', buttonPrimaryColor, buttonPrimaryColor),
//                 reuseableButton(
//                     MediaQuery.of(context).size.width / 2.5, buttonPrimaryColor,
//                     () {
//                   try {
//                     Map filterData = {
//                       'sex': selectedSex,
//                       'age': 'U${selectedAge!.name}',
//                       'location': selectedLocation!.name
//                     };
//                     box.write('filterData', filterData);

//                     successSnackBar(message: 'Filter Data Added');
//                     Navigator.pop(context);
//                   } catch (e) {
//                     ScaffoldMessenger.of(context)
//                         .showSnackBar(failedSnackBar(message: e.toString()));
//                   }
//                 }, 'Add Filter', Colors.white, buttonPrimaryColor),
//               ],
//             ),
//             const Expanded(child: SizedBox.shrink())
//           ],
//         ),
//       ),
//     );
//   }
// }



// game chart view old code

// class GameChart extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final List<double> offenseValues = [1, 6, 5, 2, 4, 3];
//     final List<double> defenseValues = [7, 4, 2, 5, 6, 1];

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Game Chart'),
//       ),
//       body: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               // LineChart(
//               //   LineChartData(
//               //     minX: 0,
//               //     maxX: 5,
//               //     minY: 1,
//               //     maxY: 7,
//               //     lineBarsData: [
//               //       LineChartBarData(
//               //         spots: List.generate(offenseValues.length,
//               //             (index) => FlSpot(index.toDouble(), offenseValues[index])),
//               //         isCurved: true,
//               //         color: Colors.green,
//               //         barWidth: 4,
//               //         isStrokeCapRound: true,
//               //         belowBarData: BarAreaData(show: false),
//               //       ),
//               //       LineChartBarData(
//               //         spots: List.generate(defenseValues.length,
//               //             (index) => FlSpot(index.toDouble(), defenseValues[index])),
//               //         isCurved: true,
//               //         color: Colors.red,
//               //         barWidth: 4,
//               //         isStrokeCapRound: true,
//               //         belowBarData: BarAreaData(show: false),
//               //       ),
//               //     ],
//               //     gridData: FlGridData(show: true),
//               //     titlesData: FlTitlesData(
//               //       bottomTitles:  AxisTitles(sideTitles: SideTitles(showTitles: true)),
//               //       leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//               //     ),
//               //     borderData: FlBorderData(show: true),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 100,
//                 child: LineChart(
//                   LineChartData(
//                     minX: 0,
//                     maxX: 5,
//                     minY: 1,
//                     maxY: 7,
//                     lineBarsData: [
//                       LineChartBarData(
//                         spots: List.generate(offenseValues.length,
//                             (index) => FlSpot(index.toDouble(), offenseValues[index])),
//                         isCurved: true,
//                         color: Colors.green,
//                         barWidth: 4,
//                        isStrokeCapRound: true,
//                         belowBarData: BarAreaData(show: false),
                        
//                       ),
                     
//                     ],
//                     gridData: FlGridData(show: false),
//                     titlesData: FlTitlesData(
//                       topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       bottomTitles:  AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     ),
//                     borderData: FlBorderData(show: false),
//                   ),
//                 ),
//               ),
//               Divider(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   appSubTitleText('G1'),
//                   appSubTitleText('G2'),
//                   appSubTitleText('G3'),
//                   appSubTitleText('G4'),
//                   appSubTitleText('G5'),
//                   appSubTitleText('G6'),

//                 ],
//               ),
//               SizedBox(
//                 height: 100,
//                 child: LineChart(
//                   LineChartData(
//                     minX: 0,
//                     maxX: 5,
//                     minY: 1,
//                     maxY: 7,
//                     lineBarsData: [
                      
//                       LineChartBarData(
//                         spots: List.generate(defenseValues.length,
//                             (index) => FlSpot(index.toDouble(), defenseValues[index])),
//                         isCurved: true,
//                         color: Colors.red,
//                         barWidth: 4,
//                         isStrokeCapRound: true,
//                         belowBarData: BarAreaData(show: false),
//                         aboveBarData: BarAreaData(show: false),
//                       ),
//                     ],
//                     gridData: FlGridData(show: false),
//                     titlesData: FlTitlesData(
//                       topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       bottomTitles:  AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                       leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
//                     ),
//                     borderData: FlBorderData(show: false),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }




  // Future<void> addClubData(String clubName) async {
  //   final url = Uri.parse(clubPostApiUrl);
  //   final headers = {
  //     'Content-Type': 'application/json',
  //   };
  //   final body = jsonEncode({
  //     "id": box.read('profileData')['id'],
  //     "club": clubName,
  //   });

  //   try {
  //     final response = await http.post(url, headers: headers, body: body);

  //     if (response.statusCode == 200) {
  //       // var data = jsonDecode(response.body)['message']['clubs'] as List;
  //       // var newData = Club.fromJson(data.last);
  //       // getClubData.add(newData);
  //       userClubInfo();
  //       successSnackBar(message: 'Successfully Added a Club');
  //     } else {
  //       Get.snackbar("Error", response.body.toString());
  //     }
  //   } catch (error) {
  //     Get.snackbar("Error", error.toString());
  //   }
  // }


    // Future<void> userClubInfo() async {
  //   final response = await http.get(
  //     Uri.parse(userInfoApiUrl),
  //     headers: {
  //       'Authorization': 'Bearer ${box.read('user')['id_token']}',
  //       "alg": "HS256",
  //       "typ": "JWT",
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     getClubData.value = jsonDecode(response.body);
  //     // var data = jsonDecode(response.body)['message']['clubs'] as List;
  //     // getClubData.value = data.map((club) => Club.fromJson(club)).toList();
  //   } else {
  //     Get.snackbar("Error", "Failed to fetch user info ${response.body}");
  //   }
  // }

  // club view old code

// class MyClubViewScreen extends StatefulWidget {
//   MyClubViewScreen(this.clubName, {super.key});
//   String clubName;

//   @override
//   State<MyClubViewScreen> createState() => _MyClubViewScreenState();
// }

// class _MyClubViewScreenState extends State<MyClubViewScreen> {
//   var box = GetStorage();
//   List clubData = [];
//   Future<void> readClubDetailsData() async {
//     final url = Uri.parse(clubGetApiUrl);
//     final headers = {
//       'Content-Type': 'application/json',
//     };
//     final body = jsonEncode({"name": widget.clubName});

//     try {
//       final response = await http.post(url, headers: headers, body: body);

//       if (response.statusCode == 200) {
//         clubData = jsonDecode(response.body);

//         setState(() {
//           isLoad = false;
//         });
//       } else {
//         failedSnackBar(message: response.body.toString());
//        }
//     } catch (error) {
//        failedSnackBar(message: error.toString());
     
//     }
//   }

//   bool isLoad = true;

//   @override
//   void initState() {
//     super.initState();
//     readClubDetailsData();
//   }
//   late final String matchDatetimeString;
//   String formatMatchDateTime(String matchDatetimeString) {
//   DateTime matchDatetime = DateTime.parse(matchDatetimeString);
//   String formattedDate = DateFormat('dd MMM yyyy, hh:mm a').format(matchDatetime);
//   return formattedDate;
// }
//   @override
//   Widget build(BuildContext context) {
   
//     return Scaffold(
//       body: isLoad
//           ? const Center(
//               child: CircularProgressIndicator.adaptive(),
//             )
//           : SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     topBar(context),
//                     Row(
//                       children: [
//                         IconButton(onPressed: (){
//                           Get.back();
//                         }, icon: const Icon(Icons.arrow_back_ios)),
//                         appTitleText('My Clubs'),
//                       ],
//                     ),
                    
//                     const SizedBox(
//                       height: 5,
//                     ),
//                     Expanded(
//                       child: ListView.builder(
//                           itemCount: clubData.length,
//                           itemBuilder: (context, index) {
//                             var clubIndexData = clubData[index];
//                             String formattedDate = formatMatchDateTime(clubIndexData['match_datetime']);
//                             return Card(
//                               elevation: 0,
//                              // shadowColor: Color(0xff6B7989).withOpacity(0.15),
//                               color: Colors.white,
//                               child: Padding(
//                                 padding: const EdgeInsets.all(12.0),
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Wrap(
//                                       children: [
//                                         Container(
//                                           height: 25,
//                                           decoration: BoxDecoration(
//                                               borderRadius:
//                                                   BorderRadius.circular(16),
//                                               color: buttonPrimaryColor
//                                                   .withOpacity(0.1)),
//                                           child: Padding(
//                                             padding: const EdgeInsets.symmetric(
//                                                 vertical: 2, horizontal: 10),
//                                             child: Text(
//                                               formattedDate,
//                                               style: const TextStyle(
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.w500,
//                                                   color: buttonPrimaryColor),
//                                             ),
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                      Padding(
//                                       padding:const EdgeInsets.symmetric(vertical: 10),
//                                       child: CustomTextWidget(
//                                         text: clubIndexData['home_name'],
//                                         fontsize: 14,
//                                         fontWeight: FontWeight.w700,
//                                       ),
//                                     ),
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 16,
//                                           backgroundColor: buttonPrimaryColor
//                                               .withOpacity(0.1),
//                                           child: const Icon(
//                                             Icons.flag,
//                                             color: buttonPrimaryColor,
//                                             size: 17,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         Expanded(
//                                           child: Column(
//                                             crossAxisAlignment: CrossAxisAlignment.start,
//                                             children: [
//                                               Wrap(
//                                                 children: [CustomTextWidget(
//                                                 text: clubIndexData['home_name'],
//                                                 fontsize: 14,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               const CustomTextWidget(
//                                                 text: ' vs ',
//                                                 fontsize: 14,
//                                                 fontWeight: FontWeight.w400,
//                                               ),
//                                               CustomTextWidget(
//                                                 text: clubIndexData['away_name'],
//                                                 fontsize: 14,
//                                                 fontWeight: FontWeight.w400,
//                                               ),],
//                                               ),
//                                               shadowText('${clubIndexData['home_score']} (O+${clubIndexData['away_score']},D+${clubIndexData['home_score']}) - ${clubIndexData['away_score']} (O-${clubIndexData['away_score']},D+${clubIndexData['home_score']})')
//                                             ],
//                                           ),
//                                         )
//                                       ],
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                     Row(
//                                       children: [
//                                         CircleAvatar(
//                                           radius: 15,
//                                           backgroundColor: buttonPrimaryColor
//                                               .withOpacity(0.1),
//                                           child: const Icon(
//                                             Icons.flag,
//                                             color: buttonPrimaryColor,
//                                             size: 17,
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         CustomTextWidget(
//                                           text: clubData[index]['home_name'],
//                                           fontsize: 14,
//                                           fontWeight: FontWeight.w400,
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             );
//                           }),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//     );
//   }
// }
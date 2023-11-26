import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Memebers/event_list.dart';
import 'package:csec/homePage/Memebers/scrollable_icons.dart';
import 'package:csec/login_signup/login.dart';
import 'package:csec/main.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/text_icons/text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:csec/theming/change.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  final String id;
  const Profile({super.key, required this.id});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final List<String> _nameOfEvents = ["Contest", "Contest Analysis", "Lecture"];
  final List<IconData> _iconsData = [
    Icons.computer,
    Icons.analytics_outlined,
    Icons.book
  ];

  Map<String, dynamic> _curentUser = {};
  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleRefresh() async {
    setState(() async {
      // Simulate a delay of 2 seconds (replace this with your actual refresh logic)
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: LiquidPullToRefresh(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 2), () {
              setState(() {});
            });
          },
          child: CustomScrollView(
            slivers: [
              //expandable app bar

              SliverAppBar(
                //header icons
                title: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme();
                      });
                    },
                    icon: Icon(
                        Provider.of<ThemeProvider>(context, listen: false)
                            .iconData),
                  ),
                ),
                automaticallyImplyLeading: false,
                collapsedHeight: Dimensions.screenHeight * 0.13,
                pinned: true,
                backgroundColor: Colors.blue[300],
                expandedHeight: Dimensions.screenHeight * 0.3,

                flexibleSpace: FlexibleSpaceBar(
                  background: Image.asset(
                    "assets/images/csec.jpg",
                    fit: BoxFit.cover,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(0),
                  child: Container(
                    width: Dimensions.screenWidth,
                    padding: EdgeInsets.only(
                        left: Dimensions.width5 * 3,
                        top: Dimensions.height5,
                        right: Dimensions.width5 * 3,
                        bottom: Dimensions.height5),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10))),
                  ),
                ),
              ),
              // body part
              SliverToBoxAdapter(
                child: FutureBuilder(
                    future: DatabaseService().getCurrentUserStates(widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        _curentUser = snapshot.data!;

                        return Column(
                          children: [
                            SizedBox(
                              height: Dimensions.height5 * 4,
                            ),
                            Container(
                              width: Dimensions.screenWidth * 0.8,
                              height: Dimensions.screenWidth * 0.2,
                              padding: EdgeInsets.all(Dimensions.height5),
                              child: Card(
                                  elevation: 2,
                                  color: Provider.of<ThemeProvider>(context)
                                              .themeData ==
                                          lightMode
                                      ? Color.fromARGB(255, 255, 255,
                                          255) // Use light primary color
                                      : Color.fromARGB(255, 79, 79, 79),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width5 * 4),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: NormalText(
                                            text:
                                                "Name:  ${_curentUser["name"]}"),
                                      ))),
                            ),
                            SizedBox(
                              height: Dimensions.height5 * 4,
                            ),
                            Container(
                              width: Dimensions.screenWidth * 0.8,
                              height: Dimensions.screenWidth * 0.2,
                              padding: EdgeInsets.all(Dimensions.height5),
                              child: Card(
                                  elevation: 2,
                                  color: Provider.of<ThemeProvider>(context)
                                              .themeData ==
                                          lightMode
                                      ? Color.fromARGB(255, 255, 255,
                                          255) // Use light primary color
                                      : Color.fromARGB(255, 79, 79, 79),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width5 * 4),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: NormalText(
                                            text:
                                                "Department: ${_curentUser["Department"]}"),
                                      ))),
                            ),
                            SizedBox(
                              height: Dimensions.height5 * 4,
                            ),
                            Container(
                              width: Dimensions.screenWidth * 0.8,
                              height: Dimensions.screenWidth * 0.2,
                              padding: EdgeInsets.all(Dimensions.height5),
                              child: Card(
                                  elevation: 2,
                                  color: Provider.of<ThemeProvider>(context)
                                              .themeData ==
                                          lightMode
                                      ? Color.fromARGB(255, 255, 255,
                                          255) // Use light primary color
                                      : Color.fromARGB(255, 79, 79, 79),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width5 * 4),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: NormalText(
                                            text:
                                                "ID: ${_curentUser["SchoolId"]}"),
                                      ))),
                            ),
                            SizedBox(
                              height: Dimensions.height5 * 4,
                            ),
                            Container(
                              width: Dimensions.screenWidth * 0.8,
                              height: Dimensions.screenWidth * 0.2,
                              padding: EdgeInsets.all(Dimensions.height5),
                              child: Card(
                                  elevation: 2,
                                  color: Provider.of<ThemeProvider>(context)
                                              .themeData ==
                                          lightMode
                                      ? Color.fromARGB(255, 255, 255,
                                          255) // Use light primary color
                                      : Color.fromARGB(255, 79, 79, 79),
                                  child: Padding(
                                      padding: EdgeInsets.only(
                                          left: Dimensions.width5 * 4),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: NormalText(
                                            text:
                                                "Batch: ${_curentUser["Bach"]} year"),
                                      ))),
                            ),
                            SizedBox(
                              height: Dimensions.width5 * 4,
                            ),
                          ],
                        );
                      }
                    }),
              )
            ],
          ),
        ),
        floatingActionButton: Container(
            child: FutureBuilder(
                future: DatabaseService().getCurrentUserStates(widget.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: SpinKitWanderingCubes(
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: Provider.of<ThemeProvider>(context)
                                        .themeData ==
                                    lightMode
                                ? const Color.fromARGB(
                                    255, 85, 86, 87) // Use light primary color
                                : const Color.fromARGB(255, 197, 200, 197),
                          ),
                        );
                      },
                    ));
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    _curentUser = snapshot.data!;
                    return SpeedDial(
                      animatedIcon: AnimatedIcons.menu_close,
                      children: [
                        SpeedDialChild(
                            onTap: () {
                              print("samu");
                              Get.toNamed("/edit-profile", arguments: {
                                "id": widget.id,
                                "userName": snapshot.data!["name"],
                                "schoolIdUser": snapshot.data!["SchoolId"],
                                "userDepartment": snapshot.data!["Department"],
                                "userBatch": snapshot.data!["Bach"],
                              });
                            },
                            child: const Icon(Icons.edit),
                            label: "Edit Profile"),
                        SpeedDialChild(
                            onTap: () {
                              Get.toNamed(
                                "/security-issue",
                                arguments: FirebaseAuth.instance.currentUser,
                              );
                            },
                            child: const Icon(Icons.key),
                            label: "Security"),
                        SpeedDialChild(
                            child: MaterialButton(
                              onPressed: () {
                                FirebaseAuth.instance.signOut();
                                Get.offAllNamed("/");
                                // ignore: use_build_context_synchronously
                              },
                              child: const Icon(Icons.logout),
                            ),
                            label: "Logout")
                      ],
                    );
                  }
                })));
  }
}

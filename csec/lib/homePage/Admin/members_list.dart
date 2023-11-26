import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Admin/feach_data_student_list.dart';
import 'package:csec/homePage/Memebers/event_list.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class MembersListViews extends StatefulWidget {
  const MembersListViews({super.key});

  @override
  State<MembersListViews> createState() => _MembersListViewsState();
}

class _MembersListViewsState extends State<MembersListViews> {
  List _eventList = [];
  List _attedndance = [];
  @override
  void initState() {
    super.initState();
  }

  Future<void> feachData() async {
    try {
      dynamic results = await DatabaseService().getUserDataMembers();

      if (results != null) {
        setState(() {
          _eventList = results;
        });
      }
    } catch (error) {
      // Handle error if needed
      print("Error fetching data: $error");
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeProvider>(context).themeData == lightMode
                ? Colors.lightBlue // Use light primary color
                : Color.fromARGB(255, 64, 65, 64),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: NormalText(
            text: "CSEC Members",
            colors: const Color.fromARGB(255, 255, 255, 255),
            fontWeights: FontWeight.w800,
            fontSize: 25,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              });
            },
            icon: Icon(
                Provider.of<ThemeProvider>(context, listen: false).iconData),
          ),
          SizedBox(
            width: Dimensions.width5,
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.menu),
          )
        ],
      ),
      body: LiquidPullToRefresh(
        height: Dimensions.screenHeight * 0.2,
        showChildOpacityTransition: true,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2), () {
            setState(() {});
          });
        },
        child: Container(
          padding: EdgeInsets.fromLTRB(Dimensions.width5 * 4,
              Dimensions.height5, Dimensions.width5, Dimensions.height5),
          child: FutureBuilder(
            future: DatabaseService().getUserDataMembers(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                _eventList = snapshot.data!;

                return ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _eventList.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: DatabaseService()
                            .getIndividualAttendance(_eventList[index]["Id"]),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container(
                              margin: const EdgeInsets.all(10),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            _attedndance = snapshot.data!;
                            print(_attedndance);
                            print(_eventList);
                            return Container(
                              margin: const EdgeInsets.all(10),
                              child: StudentListForAdmin(
                                name: _eventList[index]["name"],
                                userType: _eventList[index]["UserType"],
                                present: _attedndance[0],
                                total: _attedndance[3],
                              ),
                            );
                          }
                        });
                  },
                );
              }
            },
          ),
        ),
      ),
      floatingActionButton: Ink(
        decoration: const ShapeDecoration(
          color: Colors.blue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: () {
            print(1234);
            // Your onPressed logic here

            Get.toNamed("/register");
          },
          icon: const Icon(Icons.add),
          // Set the icon color
        ),
      ),
    );
  }
}

import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Memebers/attendance_list.dart';
import 'package:csec/homePage/Memebers/event_list.dart';
import 'package:csec/homePage/Memebers/scrollable_icons.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/text_icons/text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class AttendanceManage extends StatefulWidget {
  const AttendanceManage({super.key});

  @override
  State<AttendanceManage> createState() => _AttendanceManageState();
}

class _AttendanceManageState extends State<AttendanceManage> {
  List _attendanceList = [];
  @override
  void initState() {
    super.initState();
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
          child: BigText(
            text: "CSEC ASTU",
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
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NormalText(
                    text: "Attendance",
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 4,
                  ),
                  SizedBox(
                    child: FutureBuilder(
                      future: DatabaseService().attendanceList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: SpinKitWanderingCubes(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Provider.of<ThemeProvider>(context)
                                              .themeData ==
                                          lightMode
                                      ? Color.fromARGB(255, 85, 86,
                                          87) // Use light primary color
                                      : Color.fromARGB(255, 197, 200, 197),
                                ),
                              );
                            },
                          ));
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          _attendanceList = snapshot.data!;

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _attendanceList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: AttendanceList(
                                  name: _attendanceList[index]["Name"],
                                  startTime: _attendanceList[index]
                                      ["StartTime"],
                                  date: _attendanceList[index]["Date"],
                                  totalStudent: _attendanceList[index]
                                      ["TotalNumber"],
                                  indexs: index,
                                ),
                                // child: EventsLists(
                                //   name: _attendanceList[index]["Name"],
                                //   time: _attendanceList[index]["Time"],
                                //   locations: _attendanceList[index]["Locations"],
                                //   date: _attendanceList[index]["Date"],
                                // ),
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final user = await FirebaseAuth.instance.currentUser;

          Get.toNamed("/add-attendance", arguments: user);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

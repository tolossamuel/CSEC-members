import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Memebers/present_absent.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class Attendance extends StatefulWidget {
  final String id;
  const Attendance({super.key, required this.id});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List _attendance = [];
  List _userEventAttendance = [];
  double present = 0;
  double authorized = 0;
  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> _presentAbsentList = ["P", "P", "P", "P", "A", "E", "A", "P"];
    return Scaffold(
      body: LiquidPullToRefresh(
        height: Dimensions.screenHeight * 0.2,
        showChildOpacityTransition: true,
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 2), () {
            setState(() {});
          });
        },
        child: Container(
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
                  icon: Icon(Provider.of<ThemeProvider>(context, listen: false)
                      .iconData),
                ),
              ),
              automaticallyImplyLeading: false,
              collapsedHeight: Dimensions.screenHeight * 0.13,
              pinned: true,
              backgroundColor:
                  Provider.of<ThemeProvider>(context).themeData == lightMode
                      ? Colors.lightBlue // Use light primary color
                      : Color.fromARGB(255, 64, 65, 64),
              expandedHeight: Dimensions.screenHeight * 0.3,
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  Container(
                    margin: EdgeInsets.only(top: Dimensions.height5 * 10),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(Dimensions.width5 * 4),
                          child: CircleAvatar(
                              radius: Dimensions.height5 * 12,
                              child: ClipOval(
                                  child:
                                      Image.asset("assets/images/csec.jpg"))),
                        ),
                        Expanded(
                            child: FutureBuilder(
                                future: DatabaseService()
                                    .getIndividualAttendance(widget.id),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center();
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else {
                                    _attendance = snapshot.data!;
                                    present = (_attendance[0] * 100) /
                                        (_attendance[3]);
                                    authorized =
                                        ((_attendance[0] + _attendance[2]) *
                                                100) /
                                            (_attendance[3]);
                                    print(_attendance);
                                    print(widget.id);
                                    return Container(
                                      margin: EdgeInsets.only(
                                          top: Dimensions.height5 * 4),
                                      padding: EdgeInsets.only(
                                          top: Dimensions.height5 * 8),
                                      alignment: Alignment.center,
                                      height: Dimensions.screenHeight * 0.2,
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            NormalText(
                                                text: present < 0
                                                    ? "No attendance"
                                                    : "Real:  ${present.toStringAsFixed(2)}%",
                                                fontSize: 18,
                                                fontWeights: FontWeight.bold,
                                                colors: present >= 85
                                                    ? const Color.fromARGB(
                                                        255, 1, 79, 4)
                                                    : present >= 70
                                                        ? Colors.yellow
                                                        : Colors.red),
                                            NormalText(
                                                text: authorized < 0
                                                    ? ""
                                                    : "Total Attendance:  ${authorized.toStringAsFixed(2)}%",
                                                fontSize: 18,
                                                fontWeights: FontWeight.bold,
                                                colors: authorized >= 85
                                                    ? const Color.fromARGB(
                                                        255, 1, 83, 4)
                                                    : authorized >= 70
                                                        ? Colors.yellow
                                                        : Colors.red),
                                            SizedBox(
                                              height: Dimensions.height5,
                                            ),
                                            NormalText(
                                              text:
                                                  "total class ${_attendance[3]}",
                                              colors: Colors.white,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height5,
                                            ),
                                            NormalText(
                                              text:
                                                  "attended class ${_attendance[0]}",
                                              colors: Colors.white,
                                            ),
                                            SizedBox(
                                              height: Dimensions.height5,
                                            ),
                                          ]),
                                    );
                                  }
                                }))
                      ],
                    ),
                  )
                ]),
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
                child: Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(Dimensions.width5 * 4,
                    Dimensions.height5, Dimensions.width5, Dimensions.height5),
                child: Expanded(
                  child: Container(
                      alignment: Alignment.topCenter,
                      width: Dimensions.screenWidth,
                      child: Column(children: [
                        SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: NormalText(
                                    text: "Attendance",
                                    fontWeights: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerRight,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.green,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: Dimensions.width5,
                                        ),
                                        NormalText(
                                          text: "Present",
                                          fontSize: 12,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.red,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: Dimensions.width5,
                                        ),
                                        NormalText(
                                          text: "Absent",
                                          fontSize: 12,
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.circle,
                                          color: Colors.yellow,
                                          size: 8,
                                        ),
                                        SizedBox(
                                          width: Dimensions.width5,
                                        ),
                                        NormalText(
                                          text: "Authorized",
                                          fontSize: 12,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        FutureBuilder(
                            future: DatabaseService()
                                .userEventAttendedList(widget.id),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              }
                              _userEventAttendance = snapshot.data!;
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: _userEventAttendance.length,
                                    itemBuilder: (context, index) {
                                      return PresentAbsentList(
                                        isPresentOrAbsent:
                                            _userEventAttendance[index]
                                                        ["Attend"] ==
                                                    1
                                                ? "P"
                                                : _userEventAttendance[index]
                                                            ["Attend"] ==
                                                        2
                                                    ? "A"
                                                    : "E",
                                        name: _userEventAttendance[index]
                                            ["EventName"],
                                        date: _userEventAttendance[index]
                                            ["Date"],
                                      );
                                    }),
                              );
                            })
                      ])),
                ),
              ),
            ))
          ],
        )),
      ),
    );
  }
}

import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Attendance extends StatefulWidget {
  const Attendance({super.key});

  @override
  State<Attendance> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            backgroundColor: Colors.blue[300],
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
                                child: Image.asset("assets/images/csec.jpg"))),
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.only(top: Dimensions.height5 * 4),
                          padding: EdgeInsets.only(top: Dimensions.height5 * 8),
                          alignment: Alignment.center,
                          height: Dimensions.screenHeight * 0.2,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                NormalText(
                                  text: "75.5%",
                                  fontSize: 25,
                                  fontWeights: FontWeight.bold,
                                  colors: Color.fromARGB(255, 244, 245, 245),
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                                NormalText(
                                  text: "total class 50",
                                  colors: Colors.white,
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                                NormalText(
                                  text: "attended class 40",
                                  colors: Colors.white,
                                ),
                                SizedBox(
                                  height: Dimensions.height5,
                                ),
                              ]),
                        ),
                      )
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
              child: Container(
            padding: EdgeInsets.fromLTRB(Dimensions.width5 * 4,
                Dimensions.height5, Dimensions.width5, Dimensions.height5),
            child: Container(
                alignment: Alignment.topCenter,
                height: Dimensions.height5 * 5,
                width: Dimensions.screenWidth,
                child: Row(children: [
                  NormalText(
                    text: "Attendance",
                  ),
                ])),
          ))
        ],
      )),
    );
  }
}

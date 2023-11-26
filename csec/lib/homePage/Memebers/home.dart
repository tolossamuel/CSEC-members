import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Memebers/event_list.dart';
import 'package:csec/homePage/Memebers/scrollable_icons.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/text_icons/text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:flutter/material.dart';
import 'package:csec/theming/change.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  final String id;
  const HomePage({super.key, required this.id});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<String> _nameOfEvents = ["Contest", "Contest Analysis", "Lecture"];
  final List<IconData> _iconsData = [
    Icons.computer,
    Icons.analytics_outlined,
    Icons.book
  ];

  List _eventList = [];
  Map<String, dynamic> _curentUserData = {};
  @override
  void initState() {
    super.initState();
  }

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  feachData() async {
    dynamic results = await DatabaseService().getEventList();

    if (results == null) {
    } else {
      setState(() {
        _eventList = results;
      });
    }
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FutureBuilder(
                              future: DatabaseService()
                                  .getCurrentUserStates(widget.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Center();
                                } else if (snapshot.hasError) {
                                  return Text('Error: ${snapshot.error}');
                                } else {
                                  _curentUserData = snapshot.data!;
                                  return NormalText(
                                    text: "Hello! ${_curentUserData["name"]}",
                                    fontSize: 20,
                                  );
                                }
                              }),
                          SizedBox(
                            height: Dimensions.height5 * 2,
                          ),
                          NormalText(
                            text: "leet explore what happing nearby",
                            fontSize: 17,
                          )
                        ],
                      ),
                      SizedBox(
                        width: Dimensions.width5,
                      ),
                      Expanded(
                        child: CircleAvatar(
                          radius: Dimensions.height5 * 8,
                          child: ClipOval(
                              child: Image.asset(
                            "assets/images/csec.jpg",
                          )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 4,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: NormalText(
                      text: "All Events",
                      fontWeights: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 4,
                  ),
                  SizedBox(
                    height: Dimensions.screenHeight * 0.12,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ScrollableIcons(
                          name: _nameOfEvents[index],
                          icons: _iconsData[index],
                        ); // Assuming this is a widget you want to display
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 8,
                  ),
                  NormalText(
                    text: "Popular Events",
                    fontSize: 20,
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 4,
                  ),
                  SizedBox(
                    child: FutureBuilder(
                      future: DatabaseService().getEventList(),
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
                          _eventList = snapshot.data!;

                          return ListView.builder(
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: _eventList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: const EdgeInsets.all(10),
                                child: EventsLists(
                                  name: _eventList[index]["Name"],
                                  time: _eventList[index]["Time"],
                                  locations: _eventList[index]["Locations"],
                                  date: _eventList[index]["Date"],
                                ),
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
    );
  }
}

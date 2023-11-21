import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Memebers/event_list.dart';
import 'package:csec/homePage/Memebers/scrollable_icons.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/text_icons/text.dart';
import 'package:csec/theming/change.dart';
import 'package:flutter/material.dart';
import 'package:csec/theming/change.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[300],
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
      body: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NormalText(
                        text: "Hello! User name",
                        fontSize: 20,
                      ),
                      SizedBox(
                        height: Dimensions.height5 * 2,
                      ),
                      NormalText(
                        text: "leet explore what happing nearby",
                        fontSize: 17,
                      )
                    ],
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
              EventsLists(),
            ],
          )),
    );
  }
}

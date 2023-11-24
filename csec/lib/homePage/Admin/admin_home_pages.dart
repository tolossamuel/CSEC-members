import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Memebers/event_list.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePages extends StatefulWidget {
  const AdminHomePages({Key? key}) : super(key: key);

  @override
  State<AdminHomePages> createState() => _AdminHomePagesState();
}

class _AdminHomePagesState extends State<AdminHomePages> {
  List _eventList = [];

  @override
  void initState() {
    super.initState();
    feachData();
  }

  Future<void> feachData() async {
    try {
      dynamic results = await DatabaseService().getEventList();

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Provider.of<ThemeProvider>(context).themeData == lightMode
                ? Colors.lightBlue // Use light primary color
                : const Color.fromARGB(255, 63, 172, 119),
        scrolledUnderElevation: 10,
        flexibleSpace: FlexibleSpaceBar(
          collapseMode: CollapseMode.parallax,
          stretchModes: const [
            StretchMode.zoomBackground,
            StretchMode.blurBackground,
            StretchMode.fadeTitle,
          ],
          centerTitle: true,
          expandedTitleScale: 2,
          title: NormalText(
            text: "CSEC ASTU",
            fontSize: 30,
            fontWeights: FontWeight.bold,
          ),
        ),
        actions: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {
                setState(() {
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme();
                });
              },
              icon: Icon(
                Provider.of<ThemeProvider>(context, listen: false).iconData,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: DatabaseService().getEventList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      height: Dimensions.screenHeight,
                      width: Dimensions.screenWidth,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  _eventList = snapshot.data!;
                  print("SamuelTolossa ${_eventList.length}");
                  return ListView.builder(
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "/add-events");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

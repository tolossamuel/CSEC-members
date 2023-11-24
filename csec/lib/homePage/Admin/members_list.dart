import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Admin/feach_data_student_list.dart';
import 'package:csec/homePage/Memebers/event_list.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MembersListViews extends StatefulWidget {
  const MembersListViews({super.key});

  @override
  State<MembersListViews> createState() => _MembersListViewsState();
}

class _MembersListViewsState extends State<MembersListViews> {
  List _eventList = [];
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
      body: SizedBox(
        child: Stack(children: [
          CustomScrollView(
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
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SliverToBoxAdapter(
                child: Container(
                  padding: EdgeInsets.fromLTRB(
                      Dimensions.width5 * 4,
                      Dimensions.height5,
                      Dimensions.width5,
                      Dimensions.height5),
                  child: FutureBuilder(
                    future: DatabaseService().getUserDataMembers(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
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
                              child: StudentListForAdmin(
                                name: _eventList[index]["name"],
                                userType: _eventList[index]["UserType"],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
      floatingActionButton: Ink(
        decoration: const ShapeDecoration(
          color: Colors.blue,
          shape: CircleBorder(),
        ),
        child: IconButton(
          onPressed: () {
            // Your onPressed logic here
            Navigator.pushNamed(context, "/register");
          },
          icon: const Icon(Icons.add),
          // Set the icon color
        ),
      ),
    );
  }
}

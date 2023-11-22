import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Admin/add_event_forms.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEvents extends StatefulWidget {
  const AddEvents({super.key});

  @override
  State<AddEvents> createState() => _AddEventsState();
}

class _AddEventsState extends State<AddEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child: CustomScrollView(
      slivers: [
        //expandable app bar

        SliverAppBar(
          //header icons
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              Align(
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
            ],
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
                decoration: BoxDecoration(
                    color: Provider.of<ThemeProvider>(context).themeData ==
                            lightMode
                        ? const Color.fromARGB(
                            255, 255, 255, 255) // Use light primary color
                        : const Color.fromARGB(255, 60, 60, 60),
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10))),
                child: Center(
                  child: NormalText(
                    text: "Add Events",
                    fontSize: 25,
                  ),
                )),
          ),
        ),

        SliverToBoxAdapter(
          child: Container(
            child: const AddEventsForms(),
          ),
        )
      ],
    )));
  }
}

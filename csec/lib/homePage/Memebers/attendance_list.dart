import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AttendanceList extends StatelessWidget {
  final String name;
  final String startTime;
  final int indexs;
  final String date;
  final int totalStudent;
  const AttendanceList(
      {super.key,
      required this.name,
      required this.startTime,
      required this.date,
      required this.totalStudent,
      required this.indexs});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.screenHeight * 0.18,
      width: Dimensions.screenWidth,
      decoration: BoxDecoration(
        color: Color.fromRGBO(157, 159, 159, 0.4),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                  text: "Name : $name",
                  fontSize: 25,
                  fontWeights: FontWeight.bold,
                ),
                NormalText(
                  text: "Start Time: $startTime",
                  fontSize: 17,
                ),
                NormalText(
                  text: "Date: $date",
                  fontSize: 17,
                ),
                NormalText(
                  text: "Total Students Present: $totalStudent",
                  fontSize: 17,
                ),
              ],
            ),
          ),
          SizedBox(
            width: Dimensions.width5 * 2,
          ),
        ],
      ),
    );
  }
}

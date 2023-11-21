import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:flutter/material.dart';

class PresentAbsentList extends StatelessWidget {
  final String name;
  final String date;
  final String isPresentOrAbsent;
  const PresentAbsentList(
      {super.key,
      required this.name,
      required this.date,
      required this.isPresentOrAbsent});

  @override
  Widget build(BuildContext context) {
    late Color colors;
    if (isPresentOrAbsent == "P") {
      colors = Colors.green;
    } else if (isPresentOrAbsent == "A") {
      colors = Colors.red;
    } else {
      colors = Colors.yellow;
    }
    return Container(
      margin: EdgeInsets.all(10),
      height: Dimensions.screenHeight * 0.1,
      width: Dimensions.screenWidth,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(Dimensions.height5 * 4),
      ),
      child: Card(
        elevation: 2,
        color: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          margin: EdgeInsets.all(10),
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  NormalText(
                    text: name,
                    fontSize: 25,
                    fontWeights: FontWeight.bold,
                  ),
                  NormalText(
                    text: date,
                    fontSize: 17,
                  ),
                ],
              ),
              Icon(
                Icons.circle,
                color: colors,
              )
            ],
          ),
        ),
      ),
    );
  }
}

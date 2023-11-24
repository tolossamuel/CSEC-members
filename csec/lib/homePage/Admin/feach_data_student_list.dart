import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StudentListForAdmin extends StatelessWidget {
  final String name;

  final String userType;
  const StudentListForAdmin(
      {super.key, required this.name, required this.userType});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.screenHeight * 0.15,
      width: Dimensions.screenWidth,
      decoration: BoxDecoration(
        color: Color.fromRGBO(157, 159, 159, 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: Dimensions.screenWidth * 0.6,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                NormalText(
                  text: name,
                  fontSize: 25,
                ),
                NormalText(
                  text: userType,
                  fontSize: 17,
                ),
              ],
            ),
          ),
          SizedBox(
            width: Dimensions.width5 * 2,
          ),
          Expanded(
            child: Container(
              height: Dimensions.screenHeight * 0.17,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(157, 159, 159, 0.4),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  child: Image.asset(
                    "assets/images/csec.jpg",
                    fit: BoxFit.cover,
                  )),
            ),
          )
        ],
      ),
    );
  }
}

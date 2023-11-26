import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StudentListForAdmin extends StatefulWidget {
  final String name;

  final String userType;
  final int present;
  final int total;
  const StudentListForAdmin(
      {super.key,
      required this.name,
      required this.userType,
      required this.present,
      required this.total});

  @override
  State<StudentListForAdmin> createState() => _StudentListForAdminState();
}

class _StudentListForAdminState extends State<StudentListForAdmin> {
  double pessontAttendacne = 0;
  @override
  void initState() {
    super.initState();
    pessontAttendacne = (100 * widget.present) / (widget.total);
  }

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
            child: widget.present == -1
                ? Container()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      NormalText(
                        text: "Name:   ${widget.name}",
                        fontSize: 20,
                      ),
                      NormalText(
                          text: pessontAttendacne == -100
                              ? "Note Attend any envents"
                              : "Attendance:   ${pessontAttendacne.toStringAsFixed(2)}%",
                          fontSize: 17,
                          colors: pessontAttendacne > 90
                              ? Colors.green
                              : pessontAttendacne > 80
                                  ? Colors.yellow
                                  : Colors.red),
                      NormalText(
                        text: "User type:   ${widget.userType}",
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

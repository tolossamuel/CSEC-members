import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:csec/variable/variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class StudentListAttendance extends StatefulWidget {
  final String name;
  final List studentList;
  final String date;
  final int index;
  final String idName;
  const StudentListAttendance({
    super.key,
    required this.name,
    required this.studentList,
    required this.index,
    required this.date,
    required this.idName,
  });
  int get getNumberPresent {
    print(_StudentListAttendanceState().numberPresent);
    return _StudentListAttendanceState().numberPresent;
  }

  @override
  State<StudentListAttendance> createState() => _StudentListAttendanceState();
}

class _StudentListAttendanceState extends State<StudentListAttendance> {
  int selectedOption = 0;

  int numberPresent = 0;

  List counter = [];
  @override
  void initState() {
    super.initState();
  }

  int get totalNumber {
    return numberPresent;
  }

  @override
  Widget build(BuildContext context) {
    if (selectedOption == 0) {
      totallCounter = 0;
    }
    if (selectedOption == 1) {
      if (!counter.contains(widget.index)) {
        totallCounter += 1;
        print(totallCounter);
        counter.add(widget.index);
      }
    } else {
      if (counter.contains(widget.index)) {
        totallCounter -= 1;
        counter.remove(widget.index);
      }
    }
    print(widget.studentList);
    return Row(
      children: <Widget>[
        Expanded(flex: 2, child: NormalText(text: widget.name)),
        Expanded(
          child: Radio(
            value: 1,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
                DatabaseService().addAttendanceBaseOnUser(
                    widget.studentList[widget.index]["Id"],
                    selectedOption,
                    widget.name,
                    widget.date,
                    widget.idName);
                print("Button value: $value");
              });
            },
          ),
        ),
        Expanded(
          child: Radio(
            value: 2,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
                DatabaseService().addAttendanceBaseOnUser(
                    widget.studentList[widget.index]["Id"],
                    selectedOption,
                    widget.name,
                    widget.date,
                    widget.idName);
                print("Button value: $value");
              });
            },
          ),
        ),
        Expanded(
          child: Radio(
            value: 3,
            groupValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value!;
                DatabaseService().addAttendanceBaseOnUser(
                    widget.studentList[widget.index]["Id"],
                    selectedOption,
                    widget.name,
                    widget.date,
                    widget.idName);
                print("Button value: $value");
              });
            },
          ),
        ),
        // Add more Radio buttons as needed
      ],
    );
  }
}

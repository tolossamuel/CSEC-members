import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/homePage/Admin/name_students_with_attendance.dart';

import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:csec/variable/variable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddAttendance extends StatefulWidget {
  final User user;
  const AddAttendance({Key? key, required this.user}) : super(key: key);

  @override
  State<AddAttendance> createState() => _AddAttendanceState();
}

class _AddAttendanceState extends State<AddAttendance> {
  DateTime? selectedDate;
  DateTime? endSelectedTime;
  TimeOfDay? selectedTime;

  TextEditingController _endTime = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _totalStudents = TextEditingController();
  late String _palceError;
  late String _timeError;
  late String _nameError;
  late String _dateError;
  late int selectedOption;
  late String idName;
  late List studentList;
  List counter = [];
  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _name = TextEditingController();
    _totalStudents = TextEditingController();
    _timeController = TextEditingController();
    _endTime = TextEditingController();
    _nameError = "";
    _palceError = "";
    _timeError = "";
    _dateError = "";
    selectedOption = 1;
    print("user True");
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _dateController.text =
            "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}";
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
        _timeController.text = "${selectedTime!.hour}:${selectedTime!.minute}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.height5 * 8),
      borderSide: const BorderSide(),
    );

    return Scaffold(
      appBar: AppBar(
        title: NormalText(text: "New Attendance"),
        centerTitle: true,
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
                  Provider.of<ThemeProvider>(context, listen: false).iconData),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: Dimensions.screenWidth * 0.9,
              height: Dimensions.screenHeight * 0.07,
              child: TextField(
                controller: _name,
                autocorrect: true,
                enableSuggestions: false,
                decoration: InputDecoration(
                  labelText: "Attendance Name",
                  border: border,
                  focusedBorder: border,
                  errorText: _name.text.isEmpty
                      ? _nameError.isEmpty
                          ? null
                          : _nameError
                      : null,
                ),
              ),
            ),
            _buildPopupField("Start Time", Icons.access_time, _timeController,
                _selectTime, _timeError),
            _buildPopupField("Date", Icons.date_range, _dateController,
                _selectDate, _dateError),
            (_name.text.isEmpty ||
                    _timeController.text.isEmpty ||
                    _dateController.text.isEmpty)
                ? Container()
                : Container(
                    padding: EdgeInsets.all(Dimensions.height5 * 2),
                    child: Column(children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: NormalText(
                              text: "Name",
                            ),
                          ),
                          Expanded(child: NormalText(text: "P")),
                          Expanded(child: NormalText(text: "A")),
                          Expanded(child: NormalText(text: "E")),
                        ],
                      ),
                      FutureBuilder(
                          future: DatabaseService().getUserDataMembers(),
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
                              studentList = snapshot.data!;
                              idName =
                                  "${_name.text}${_timeController.text}${_endTime.text}";
                              for (int i = 0;
                                  i < _dateController.text.length;
                                  i++) {
                                if (_dateController.text[i] != "/") {
                                  idName += _dateController.text[i];
                                }
                              }
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: studentList.length,
                                  itemBuilder: (context, index) {
                                    print(studentList);
                                    return StudentListAttendance(
                                      name: studentList[index]["name"],
                                      index: index,
                                      studentList: studentList,
                                      date: _dateController.text,
                                      idName: idName,
                                    );
                                  });
                            }
                          })
                      // const StudentAttendance(),
                    ]),
                  ),
            Container(
                margin: EdgeInsets.all(10),
                child: OutlinedButton(
                  onPressed: () {
                    DatabaseService().addAttendanceToDatabase(
                        _name.text,
                        _dateController.text,
                        _timeController.text,
                        totallCounter);
                  },
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<OutlinedBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            20.0), // Set the desired border radius
                      ),
                    ),
                    minimumSize: MaterialStateProperty.all<Size>(Size(
                        Dimensions.screenWidth * 0.9,
                        Dimensions.screenHeight * 0.07)),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(ColorsHome.mainColor),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(color: ColorsHome.mainColor, width: 2.0),
                    ),
                  ),
                  child: const Text(
                    "Add Attendance",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildPopupField(
    String label,
    IconData suffixIcon,
    TextEditingController controller,
    Function(BuildContext) onTap,
    String errors,
  ) {
    return Container(
      margin: EdgeInsets.all(10),
      width: Dimensions.screenWidth * 0.9,
      height: Dimensions.screenHeight * 0.07,
      child: TextFormField(
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          errorText: controller.text.isEmpty
              ? errors.isEmpty
                  ? null
                  : errors
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height5 * 8),
            borderSide: const BorderSide(),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Dimensions.height5 * 8),
            borderSide: const BorderSide(),
          ),
          suffixIcon: InkWell(
            onTap: () => onTap(context),
            child: Icon(suffixIcon),
          ),
        ),
        controller: controller,
      ),
    );
  }
}

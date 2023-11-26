import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class AddEventsForms extends StatefulWidget {
  const AddEventsForms({Key? key}) : super(key: key);

  @override
  State<AddEventsForms> createState() => _AddEventsFormsState();
}

class _AddEventsFormsState extends State<AddEventsForms> {
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _name = TextEditingController();
  TextEditingController _place = TextEditingController();
  late String _palceError;
  late String _timeError;
  late String _nameError;
  late String _dateError;

  @override
  void initState() {
    super.initState();
    _dateController = TextEditingController();
    _name = TextEditingController();
    _place = TextEditingController();
    _timeController = TextEditingController();
    _nameError = "";
    _palceError = "";
    _timeError = "";
    _dateError = "";
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

    return Column(
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
              labelText: "Event Name",
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
        _buildPopupField("Time", Icons.access_time, _timeController,
            _selectTime, _timeError),
        _buildPopupField(
            "Date", Icons.date_range, _dateController, _selectDate, _dateError),
        Container(
          margin: EdgeInsets.all(10),
          width: Dimensions.screenWidth * 0.9,
          height: Dimensions.screenHeight * 0.07,
          child: TextField(
            keyboardType: TextInputType.text,
            autocorrect: true,
            controller: _place,
            enableSuggestions: true,
            decoration: InputDecoration(
              labelText: "Place",
              border: border,
              focusedBorder: border,
              errorText: _place.text.isEmpty
                  ? _palceError.isEmpty
                      ? null
                      : _palceError
                  : null,
            ),
          ),
        ),
        Container(
            margin: EdgeInsets.all(10),
            child: OutlinedButton(
              onPressed: () async {
                if (_name.text.isEmpty) {
                  setState(() {
                    _nameError = "Event Name can't be empty";
                  });
                } else if (_timeController.text.isEmpty) {
                  setState(() {
                    _timeError = "Time can't be empty";
                  });
                } else if (_dateController.text.isEmpty) {
                  setState(() {
                    _dateError = "Date can't be empty";
                  });
                } else if (_place.text.isEmpty) {
                  setState(() {
                    _palceError = "Place Name can't be empty";
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("wait..."),
                    duration: Duration(seconds: 100),
                  ));

                  final value = await DatabaseService().addEvent(_name.text,
                      _place.text, _timeController.text, _dateController.text);
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  if (value == "successfully") {
                    // ignore: use_build_context_synchronously

                    Navigator.pop(context);
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("New Event added successfully"),
                      duration: Duration(seconds: 3),
                    ));
                  } else {
                    // ignore: use_build_context_synchronously
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Pleas try again"),
                      duration: Duration(seconds: 3),
                    ));
                  }
                }
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
                "Add Event",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ))
      ],
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

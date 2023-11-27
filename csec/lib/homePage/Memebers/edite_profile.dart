import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/firebase_options.dart';
import 'package:csec/homePage/Admin/send_email_to_user_his_her_password.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/text_icons/text.dart';
import 'package:csec/theming/change.dart';
import 'package:csec/theming/themes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class EditProfile extends StatefulWidget {
  final String id;
  final String userName;
  final String schoolIdUser;
  final String userDepartment;
  final String userBatch;

  const EditProfile(
      {Key? key,
      required this.id,
      required this.userName,
      required this.schoolIdUser,
      required this.userDepartment,
      required this.userBatch})
      : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final TextEditingController _name;
  late final TextEditingController _shcoolId;

  bool _isLoadingOrNot = true;
  bool _loading = false;
  String selectedUserType = "Members"; // Initialize with the default value
  List<String> userTypes = ["Members", "Admin"];
  List<String> bachOfYear = ["1st", "2nd", "3rd", "4th", "5th"];
  List<String> departments = [
    "Freshman",
    "School",
    "Software",
    "CSE",
    "Communications",
    "Power and Control",
    "Mechanical",
    "Chemical",
    "Material",
    "Civil",
    "Architecture",
    "Water",
  ];

  late String selectedBach;
  late String selectedDepartment;
  String showError = "";

  IconData iconForPassword = Icons.remove_red_eye_outlined;
  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.height5 * 8),
    borderSide: const BorderSide(),
  );

  @override
  void initState() {
    _name = TextEditingController();

    _shcoolId = TextEditingController();
    _name.text = widget.userName;
    selectedBach = widget.userBatch;

    selectedDepartment = widget.userDepartment;

    _shcoolId.text = widget.schoolIdUser;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          height: Dimensions.screenHeight,
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Dimensions.width5 * 2,
              Dimensions.height5,
              Dimensions.width5 * 2,
              Dimensions.height5,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.height5),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const SizedBox(
                            child: Icon(Icons.arrow_back_ios),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: Dimensions.screenHeight * 0.15,
                        width: Dimensions.screenWidth * 0.6,
                        child: BigText(
                          text: "Edit Profile",
                          fontSize: 30,
                          colors: Provider.of<ThemeProvider>(context)
                                      .themeData ==
                                  lightMode
                              ? Color.fromARGB(
                                  255, 45, 45, 45) // Use light primary color
                              : const Color.fromARGB(255, 197, 200, 197),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            Provider.of<ThemeProvider>(context, listen: false)
                                .toggleTheme();
                          });
                        },
                        icon: Icon(
                          Provider.of<ThemeProvider>(context, listen: false)
                              .iconData,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 3,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: NormalText(
                      text: showError,
                      colors: Colors.red,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 3,
                  ),
                  SizedBox(
                    width: Dimensions.screenWidth * 0.9,
                    height: Dimensions.screenHeight * 0.07,
                    child: TextField(
                      controller: _name,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        hintText: "Full Name",
                        border: border,
                        focusedBorder: border,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height5 * 5),
                  SizedBox(
                    width: Dimensions.screenWidth * 0.9,
                    height: Dimensions.screenHeight * 0.07,
                    child: TextField(
                      controller: _shcoolId,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        hintText: "School Id",
                        border: border,
                        focusedBorder: border,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height5 * 5),
                  SizedBox(
                    width: Dimensions.screenWidth * 0.9,
                    height: Dimensions.screenHeight * 0.08,
                    child: DropdownButtonFormField<String>(
                      value:
                          selectedBach, // You need to manage the selected batch value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedBach = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Batch of Year",
                        border: border,
                        focusedBorder: border,
                      ),
                      items: bachOfYear
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: Dimensions.height5 * 5),
                  SizedBox(
                    width: Dimensions.screenWidth * 0.9,
                    height: Dimensions.screenHeight * 0.08,
                    child: DropdownButtonFormField<String>(
                      value:
                          selectedDepartment, // You need to manage the selected batch value
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDepartment = newValue!;
                        });
                      },
                      decoration: InputDecoration(
                        hintText: "Department",
                        border: border,
                        focusedBorder: border,
                      ),
                      items: departments
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: Dimensions.height5 * 5),
                  SizedBox(
                    height: Dimensions.height5 * 8,
                  ),
                  OutlinedButton(
                    onPressed: _loading
                        ? null
                        : () async {
                            setState(() {
                              _loading = true;
                            });

                            final name = _name.text;
                            if (_name.text.isNotEmpty) {
                              if (true) {
                                if (true) {
                                  try {
                                    if (true) {
                                      // Use the correct parameter name 'fullname' instead of 'name'
                                      await DatabaseService().editUserInfo(
                                          name,
                                          widget.id,
                                          selectedBach,
                                          selectedDepartment,
                                          _shcoolId.text);

                                      // Send email only if the user is successfully registered
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == "email-already-in-use") {
                                      setState(() {
                                        showError = "email already in use";
                                      });
                                    } else if (e.code == "invalid-email") {
                                      setState(() {
                                        showError = "invalid email";
                                      });
                                    } else {}
                                  } finally {
                                    setState(() {
                                      _loading = false;
                                    });
                                  }
                                }
                              }
                            }
                          },
                    style: ButtonStyle(
                      minimumSize: MaterialStateProperty.all<Size>(
                        Size(
                          Dimensions.screenWidth * 0.9,
                          Dimensions.screenHeight * 0.07,
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        ColorsHome.mainColor,
                      ),
                      side: MaterialStateProperty.all<BorderSide>(
                        const BorderSide(
                          color: ColorsHome.mainColor,
                          width: 2.0,
                        ),
                      ),
                    ),
                    child: _loading
                        ? SpinKitCircle(
                            itemBuilder: (BuildContext context, int index) {
                              return DecoratedBox(
                                decoration: BoxDecoration(
                                  color: Provider.of<ThemeProvider>(context)
                                              .themeData ==
                                          lightMode
                                      ? const Color.fromARGB(255, 85, 86,
                                          87) // Use light primary color
                                      : const Color.fromARGB(
                                          255, 197, 200, 197),
                                ),
                              );
                            },
                          )
                        : const Text(
                            "Edit Profile",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

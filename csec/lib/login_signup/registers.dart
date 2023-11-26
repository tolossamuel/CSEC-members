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

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  late final TextEditingController _configPassword;
  late final TextEditingController _bach;
  late final TextEditingController _shcoolId;
  late final TextEditingController _department;

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
    "Water"
  ];
  String selectedBach = "1st";
  String selectedDepartment = "Freshman";
  String showError = "";
  bool _isPasswordVisible = false;
  bool _isPasswordVisibleForNext = false;
  IconData iconForPassword = Icons.remove_red_eye_outlined;
  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.height5 * 8),
    borderSide: const BorderSide(),
  );

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _configPassword = TextEditingController();
    _bach = TextEditingController();
    _department = TextEditingController();
    _shcoolId = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          return Center(
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
                              text: "CSEC ASTU",
                              fontSize: 30,
                              colors: ColorsHome.mainColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
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
                        height: Dimensions.screenHeight * 0.07,
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
                        height: Dimensions.screenHeight * 0.07,
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
                        width: Dimensions.screenWidth * 0.9,
                        height: Dimensions.screenHeight * 0.07,
                        child: DropdownButtonFormField<String>(
                          value: selectedUserType,
                          onChanged: (newValue) {
                            setState(() {
                              selectedUserType = newValue!;
                            });
                          },
                          items: userTypes.map((type) {
                            return DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            );
                          }).toList(),
                          decoration: InputDecoration(
                            hintText: "User Type",
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
                          autocorrect: false,
                          keyboardType: TextInputType.emailAddress,
                          controller: _email,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            hintText: "Email",
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
                          controller: _password,
                          obscureText: !_isPasswordVisible,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            hintText: "Password",
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
                          obscureText: !_isPasswordVisibleForNext,
                          autocorrect: false,
                          controller: _configPassword,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisibleForNext
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisibleForNext =
                                      !_isPasswordVisibleForNext;
                                });
                              },
                            ),
                            hintText: "Config password",
                            border: border,
                            focusedBorder: border,
                          ),
                        ),
                      ),
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
                                final email = _email.text;
                                final password = _password.text;
                                final configPassword = _configPassword.text;
                                final name = _name.text;
                                if (_name.text.isNotEmpty &&
                                    _email.text.isNotEmpty &&
                                    _password.text.isNotEmpty) {
                                  if (password == configPassword) {
                                    if (password.length >= 8) {
                                      try {
                                        await FirebaseAuth.instance
                                            .createUserWithEmailAndPassword(
                                          email: email,
                                          password: password,
                                        );
                                        User? user =
                                            FirebaseAuth.instance.currentUser;
                                        if (user != null) {
                                          // Use the correct parameter name 'fullname' instead of 'name'
                                          await DatabaseService().userInfoData(
                                              name,
                                              selectedUserType,
                                              user.uid,
                                              _password.text,
                                              _email.text,
                                              selectedBach,
                                              selectedDepartment,
                                              _shcoolId.text,
                                              user.uid);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text(
                                                "new user added successfully"),
                                            duration: Duration(seconds: 3),
                                          ));

                                          // Send email only if the user is successfully registered

                                          sendEmail(
                                            name,
                                            password,
                                            email,
                                          );
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
                                        } else {
                                          print(e.code);
                                        }
                                      }
                                      cathc(e) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          content: Text(e.code),
                                          duration: Duration(seconds: 3),
                                        ));
                                        setState(() {
                                          _loading = false;
                                        });
                                      }
                                    } else {
                                      setState(() {
                                        showError =
                                            "The length of password at least 8";
                                      });
                                    }
                                  } else {
                                    setState(() {
                                      showError = "Password is not similar";
                                    });
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
                                "Add Student",
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
          );
        },
      ),
    );
  }
}

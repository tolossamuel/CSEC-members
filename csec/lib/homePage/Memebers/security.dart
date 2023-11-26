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

class SecurityIssue extends StatefulWidget {
  final User user;

  const SecurityIssue({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<SecurityIssue> createState() => _SecurityIssueState();
}

class _SecurityIssueState extends State<SecurityIssue> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _configer;
  late final TextEditingController _currentPassword;
  bool _loading = false;

  String selectedBach = "";
  String selectedDepartment = "";
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
    _configer = TextEditingController();
    _currentPassword = TextEditingController();
    _password = TextEditingController();
    _email.text = widget.user.email!;

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
                          text: "CSEC ASTU",
                          fontSize: 30,
                          colors: ColorsHome.mainColor,
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
                      readOnly: true,
                      controller: _email,
                      autocorrect: false,
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        hintText: "Email",
                        border: border,
                        focusedBorder: border,
                      ),
                    ),
                  ),
                  SizedBox(height: Dimensions.height5 * 10),
                  Divider(
                    height: Dimensions.height5,
                    thickness: 2,
                  ),
                  SizedBox(height: Dimensions.height5 * 5),
                  NormalText(
                    text: "Change Password",
                    fontSize: 25,
                    fontWeights: FontWeight.bold,
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 8,
                  ),
                  SizedBox(
                    width: Dimensions.screenWidth * 0.9,
                    height: Dimensions.screenHeight * 0.07,
                    child: TextField(
                      controller: _currentPassword,
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
                        hintText: "Current password",
                        border: border,
                        focusedBorder: border,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Dimensions.height5 * 8,
                  ),
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
                        hintText: "new password",
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
                      controller: _configer,
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
                        hintText: "confirm password",
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
                            final config = _configer.text;

                            if (_email.text.isNotEmpty &&
                                _email.text.isNotEmpty &&
                                _password.text.isNotEmpty) {
                              if (password == config) {
                                if (password.length >= 8) {
                                  try {
                                    if (widget.user != null) {
                                      AuthCredential credential =
                                          EmailAuthProvider.credential(
                                        email: _email.text,
                                        password: _currentPassword
                                            .text, // The user's current password
                                      );

                                      try {
                                        await FirebaseAuth.instance.currentUser
                                            ?.reauthenticateWithCredential(
                                                credential);
                                        await widget.user
                                            .updatePassword(_password.text);

                                        // Now you can perform the sensitive operation (e.g., updating the password)
                                      } catch (e) {
                                        // Handle reauthentication failure (e.g., wrong password)
                                        // ignore: use_build_context_synchronously
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(const SnackBar(
                                          content: Text(
                                              "current password is not correct"),
                                          duration: Duration(seconds: 3),
                                        ));
                                      }
                                      // Use the correct parameter name 'fullname' instead of 'name'

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
                            "Change Password",
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

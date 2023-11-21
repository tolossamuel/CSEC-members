import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/firebase_options.dart';
import 'package:csec/service/database.dart';
import 'package:csec/text_icons/normal_text.dart';
import 'package:csec/text_icons/text.dart';
import 'package:csec/theming/change.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;
  late final TextEditingController _configPassword;
  String showError = "";
  bool _isPasswordVisible = false;
  bool _isPasswordVisibleForNext = false;
  IconData iconForPassword = Icons.remove_red_eye_outlined;
  final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Dimensions.height5 * 8),
      borderSide: const BorderSide(
        color: Color.fromARGB(255, 255, 255, 255),
      ));
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
    _configPassword = TextEditingController();
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
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(
                  width: Dimensions.screenWidth,
                  height: Dimensions.screenHeight,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(
                        Dimensions.width5 * 2,
                        Dimensions.height5,
                        Dimensions.width5 * 2,
                        Dimensions.height5),
                    child: Column(children: [
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
                              )),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                Provider.of<ThemeProvider>(context,
                                        listen: false)
                                    .toggleTheme();
                              });
                            },
                            icon: Icon(Provider.of<ThemeProvider>(context,
                                    listen: false)
                                .iconData),
                          )
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
                            )),
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
                            )),
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
                            )),
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
                            )),
                      ),
                      SizedBox(
                        height: Dimensions.height5 * 8,
                      ),
                      OutlinedButton(
                        onPressed: () async {
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
                                          email: email, password: password);
                                  User? user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user != null) {
                                    // Use the correct parameter name 'fullname' instead of 'name'
                                    await DatabaseService()
                                        .userInfoData(name, "Admin", user.uid);
                                    print("register successfully");
                                  }

                                  if (user?.emailVerified ?? false) {
                                    print("verified");
                                  } else {
                                    print("not");
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
                          minimumSize: MaterialStateProperty.all<Size>(Size(
                              Dimensions.screenWidth * 0.9,
                              Dimensions.screenHeight * 0.07)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              ColorsHome.mainColor),
                          side: MaterialStateProperty.all<BorderSide>(
                            const BorderSide(
                                color: ColorsHome.mainColor, width: 2.0),
                          ),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height5 * 10,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: Dimensions.width5),
                        child: Row(
                          children: [
                            BigText(
                              text: "Already have account",
                            ),
                            TextButton(
                                onPressed: () {},
                                child: BigText(
                                  text: "Login",
                                  colors: ColorsHome.mainColor,
                                ))
                          ],
                        ),
                      )
                    ]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}

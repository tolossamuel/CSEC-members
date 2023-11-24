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

class Login extends StatefulWidget {
  const Login({Key? key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  bool _loading = false;
  bool _isPasswordVisible = false;
  bool _isPasswordVisibleForNext =
      false; // Add this variable to track loading state
  final OutlineInputBorder border = OutlineInputBorder(
    borderRadius: BorderRadius.circular(Dimensions.height5 * 8),
    borderSide: const BorderSide(
      color: Color.fromARGB(255, 255, 255, 255),
    ),
  );

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
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
    bool userChecked = false;
    return Scaffold(
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          Future<void> checkUser() async {
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              // User is signed in

              Map<String, String> userData =
                  await DatabaseService().getUserInfo(user.uid);

              if (userData["UserType"] == "Admin") {
                Navigator.pushReplacementNamed(context, '/admin-login');
              } else {
                Navigator.pushReplacementNamed(context, '/home',
                    arguments: user.uid);
              }
            } else {
              // No user is signed in
              print("not login");
            }
            userChecked = true;
          }

          if (snapshot.connectionState == ConnectionState.done &&
              !userChecked) {
            checkUser();
          }

          // Wait until user check is complete before building UI
          if (!userChecked) {
            return Center(child: CircularProgressIndicator());
          }

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
                    Dimensions.height5,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: Dimensions.screenHeight * 0.15,
                            width: Dimensions.screenWidth * 0.8,
                            child: BigText(
                              text: "CSEC ASTU",
                              fontSize: 30,
                              colors: ColorsHome.mainColor,
                              fontWeights: FontWeight.bold,
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
                          )
                        ],
                      ),
                      SizedBox(
                        width: Dimensions.screenWidth * 0.9,
                        height: Dimensions.screenHeight * 0.07,
                        child: TextField(
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          autocorrect: false,
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            hintText: "Email",
                            border: border,
                            focusedBorder: border,
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.height5 * 5),
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
                      SizedBox(
                        height: Dimensions.height5 * 8,
                      ),
                      OutlinedButton(
                        onPressed: _loading
                            ? null // Disable button if loading
                            : () async {
                                setState(() {
                                  _loading = true; // Set loading to true
                                });

                                final email = _email.text;
                                final password = _password.text;

                                try {
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                    email: email,
                                    password: password,
                                  );

                                  final user =
                                      FirebaseAuth.instance.currentUser;
                                  if (user != null) {
                                    Map<String, String> userData =
                                        await DatabaseService()
                                            .getUserInfo(user.uid);
                                    DatabaseService()
                                        .getCurrentUserStates(user.uid);

                                    if (userData["UserType"] == "Admin") {
                                      Navigator.pushReplacementNamed(
                                          context, '/admin-login');
                                    } else {
                                      Navigator.pushReplacementNamed(
                                          context, '/home');
                                    }
                                  }
                                } on FirebaseAuthException catch (e) {
                                  print(e.code);
                                  print("name");
                                  // Handle FirebaseAuthException
                                } finally {
                                  setState(() {
                                    _loading =
                                        false; // Set loading to false after operation
                                  });
                                }
                              },
                        style: ButtonStyle(
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  20.0), // Set the desired border radius
                            ),
                          ),
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
                            BorderSide(
                              color: ColorsHome.mainColor,
                              width: 2.0,
                            ),
                          ),
                        ),
                        child: _loading
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              )
                            : const Text(
                                "Log in",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                      ),
                      SizedBox(
                        height: Dimensions.height5 * 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {},
                          child: NormalText(
                            text: "Forget Password",
                            colors: null,
                            // You can set the color if needed
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: Dimensions.height5 * 0.5,
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

import 'package:csec/colors_dimensions/colors.dart';
import 'package:csec/colors_dimensions/dimensions.dart';
import 'package:csec/firebase_options.dart';
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
                        children: [
                          Container(
                              alignment: Alignment.center,
                              height: Dimensions.screenHeight * 0.15,
                              width: Dimensions.screenWidth * 0.8,
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
                        width: Dimensions.screenWidth * 0.9,
                        height: Dimensions.screenHeight * 0.07,
                        child: TextField(
                            controller: _name,
                            keyboardType: TextInputType.emailAddress,
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
                            obscureText: true,
                            autocorrect: false,
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
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            enableSuggestions: false,
                            decoration: InputDecoration(
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
                            obscureText: true,
                            autocorrect: false,
                            controller: _configPassword,
                            enableSuggestions: false,
                            decoration: InputDecoration(
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
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            print("login");
                            final user = FirebaseAuth.instance.currentUser;
                            if (user?.emailVerified ?? false) {
                              print("not login");
                            } else {
                              print("samuel");
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == "user-not-found") {
                              print("user-not-found");
                            } else if (e.code == "wrong-password") {
                              print("email or password not correct");
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

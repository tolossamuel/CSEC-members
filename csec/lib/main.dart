import 'package:csec/homePage/Memebers/atendance.dart';
import 'package:csec/homePage/Memebers/home.dart';
import 'package:csec/homePage/Memebers/navigations_buttons.dart';
import 'package:csec/login_signup/login.dart';
import 'package:csec/login_signup/registers.dart';
import 'package:csec/theming/change.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          ThemeProvider(), // Create an instance of your provider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CSEC ASTU',
      home: const NavigatorBottom(),
      theme: Provider.of<ThemeProvider>(context).themeData,
      // routes: {
      //   "/register": (context) => const Register(),
      //   "/home": (context) => const HomePage(),
      // },
    );
  }
}

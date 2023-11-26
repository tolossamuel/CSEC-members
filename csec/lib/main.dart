import 'package:csec/homePage/Admin/addEvents.dart';
import 'package:csec/homePage/Admin/add_new_attendance.dart';
import 'package:csec/homePage/Admin/admin_all_pages_with_navigator.dart';
import 'package:csec/homePage/Admin/admin_home_pages.dart';
import 'package:csec/homePage/Admin/members_list.dart';
import 'package:csec/homePage/Memebers/atendance.dart';
import 'package:csec/homePage/Memebers/edite_profile.dart';
import 'package:csec/homePage/Memebers/home.dart';
import 'package:csec/homePage/Memebers/navigations_buttons.dart';
import 'package:csec/homePage/Memebers/security.dart';
import 'package:csec/login_signup/login.dart';
import 'package:csec/login_signup/registers.dart';
import 'package:csec/login_signup/reseat.dart';
import 'package:csec/theming/change.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  print(1234567890);

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
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'CSEC ASTU',
            home: const Login(),
            theme: Provider.of<ThemeProvider>(context).themeData,
            routes: {
              "/register": (context) => const Register(),
              "/home": (context) {
                final argument =
                    ModalRoute.of(context)?.settings.arguments as String;
                return NavigatorBottom(uid: argument);
              },
              "/admin-login": (context) {
                final arguments = Get.arguments as String;
                return AdminNavigatorButtons(uid: arguments);
              },
              "/add-events": (context) => const AddEvents(),
              "/edit-profile": (context) {
                final arguments = Get.arguments as Map<String, dynamic>;
                return EditProfile(
                  id: arguments['id'],
                  userName: arguments['userName'],
                  schoolIdUser: arguments['schoolIdUser'],
                  userDepartment: arguments['userDepartment'],
                  userBatch: arguments['userBatch'],
                );
              },
              "/security-issue": (context) {
                final arguments = Get.arguments as User;

                return SecurityIssue(
                  user: arguments,
                );
              },
              "/add-attendance": (context) {
                final arguments = Get.arguments as User;
                return AddAttendance(
                  user: arguments,
                );
              },
              "/reseat": (context) => ResetScreen(),
            },
          );
        }

        return const MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}

// import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<String> sendEmail(String name, String password, String email) async {
  final smtpServer =
      gmail("astucsec2@gmail.com", "y h y m l j x g c a b g l r t f");

  final message = Message()
    ..from = Address("astucsec2@gmail.com" 'CSEC ASTU')
    ..recipients.add(email)
    ..subject = 'New Members Email and Password'
    ..text = 'This is the plain text.\nThis is line 2 of the text part.'
    ..html =
        "<h1>For New Members</h1>\n<p>Hey $name, welcome to CSEC ASTU members. You have selected to become members of CSEC. Now you can access the members app by your email and password.\nEmail: $email\nPassword: $password</p>";

  try {
    final sendReport = await send(message, smtpServer);
  } on MailerException catch (e) {
    for (var p in e.problems) {}
  }
  return "";
}

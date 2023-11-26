// ignore_for_file: empty_catches

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csec/homePage/Admin/send_email_to_user_his_her_password.dart';

class DatabaseService {
  final CollectionReference _userInfo =
      FirebaseFirestore.instance.collection("UserInfo");
  Map<String, dynamic> _currentUser = {};
  get currentUser async {
    print("samulllllllllllllllllllll");
    print(_currentUser["name"]);
    print("llllllllllllllllllllllll");
    return _currentUser;
  }

  Future<List> getUserDataMembers() async {
    List itemList = [];
    try {
      var querySnapshot = await _userInfo.get();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((elements) {
          itemList.add(elements.data());
        });
        print("Data fetched successfully");

        if (itemList.isNotEmpty &&
            itemList[0] is Map &&
            itemList[0].containsKey("Name")) {
          print("Name: ${itemList[0]["Name"]}");
        } else {
          print("Error: Empty list or missing 'Name' key");
        }
      } else {
        print("Error: No documents found");
      }

      return itemList;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<Map<String, dynamic>> getCurrentUserStates(String id) async {
    _currentUser = {};
    final data = await _userInfo.doc(id).get();
    _currentUser = data.data() as Map<String, dynamic>;
    return _currentUser;
  }

  Future userInfoData(
      String fullName,
      String userType,
      String userId,
      String password,
      String email,
      String bach,
      String department,
      String schoolId,
      String id) async {
    try {
      sendEmail(fullName, password, email);
      await _userInfo.doc(userId).set({
        "name": fullName,
        "UserType": userType,
        "Email": email,
        "Bach": bach,
        "Department": department,
        "SchoolId": schoolId,
        "Id": id
      });
    } catch (e) {
      // Handle the exception, log it, or show an error message to the user.
      print("Error adding user information: $e");
    }
  }

  Future<void> editUserInfo(String fullName, String userId, String bach,
      String department, String schoolId) async {
    await _userInfo.doc(userId).set({
      "name": fullName,
      "Bach": bach,
      "Department": department,
      "SchoolId": schoolId,
    });
  }

  Future<Map<String, String>> getUserInfo(String userId) async {
    DocumentSnapshot snapshot = await _userInfo.doc(userId).get();

    if (snapshot.exists) {
      Map<String, dynamic> userData = snapshot.data() as Map<String, dynamic>;

      // Convert dynamic map to Map<String, String>
      Map<String, String> userStringData =
          userData.map((key, value) => MapEntry(key, value.toString()));

      return userStringData;
    } else {
      // Handle the case where the document doesn't exist
      return {};
    }
  }

  // Event list =========================================

  final CollectionReference _eventList =
      FirebaseFirestore.instance.collection("EventsList");

  Future<List> getEventList() async {
    List itemList = [];

    try {
      print(12000);
      var querySnapshot = await _eventList.get();
      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((elements) {
          itemList.add(elements.data());
        });
        print("Data fetched successfully");

        if (itemList.isNotEmpty &&
            itemList[0] is Map &&
            itemList[0].containsKey("Name")) {
          print("Name: ${itemList[0]["Name"]}");
        } else {
          print("Error: Empty list or missing 'Name' key");
        }
      } else {
        print("Error: No documents found");
      }

      return itemList;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  // Add event to database
  Future<void> addEvent(
      String name, String locations, String time, String date) async {
    try {
      await _eventList.add({
        "Name": name,
        "Locations": locations,
        "Time": time,
        "Date": date

        // Add other fields as needed
      });
      print("Event added successfully");
    } catch (e) {
      print("Error adding event: $e");
    }
  }

  // attendance========================

  final CollectionReference _allAttendanceNameList = FirebaseFirestore.instance
      .collection("Attendance")
      .doc("AttendanceName")
      .collection("TotallAtendaceName");

  final CollectionReference _attendanceStudent = FirebaseFirestore.instance
      .collection("Attendance")
      .doc("StudentInfoAttendance")
      .collection("Student");

  Future<List> attendanceList() async {
    List attendanceListStudents = [];

    print(_allAttendanceNameList);
    try {
      var querySnapshot = await _allAttendanceNameList.get();

      if (querySnapshot.docs.isNotEmpty) {
        querySnapshot.docs.forEach((element) {
          print(element);
          attendanceListStudents.add(element.data());
        });

        print("Data fetched successfully");
      } else {
        print("Error: No documents found");
      }
      print(attendanceListStudents);
      return attendanceListStudents;
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }

  Future<void> addAttendanceToDatabase(
      String name, String date, String startTime, int total) async {
    try {
      await _allAttendanceNameList.add({
        "Name": name,
        "Date": date,
        "StartTime": startTime,
        "TotalNumber": total
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> addAttendanceBaseOnUser(
    String id,
    int attend,
    String eventName,
    String date,
    String idName,
  ) async {
    try {
      DocumentReference studentDocRef = _attendanceStudent.doc(id);

      CollectionReference subcollectionRef =
          studentDocRef.collection('newSubcollection');

      await subcollectionRef
          .doc(idName)
          .set({"Attend": attend, "EventName": eventName, "Date": date});
    } catch (e) {
      print(e);
    }
  }

  // individual attendance
  Future<List<dynamic>> getIndividualAttendance(String id) async {
    List<dynamic> value = [];
    List<dynamic> counter = [];
    int present = 0;
    int absent = 0;
    int authorized = 0; // Corrected the typo in the variable name
    try {
      DocumentReference studentDocRef = _attendanceStudent.doc(id);

      CollectionReference subcollectionRef =
          studentDocRef.collection('newSubcollection');
      var getData = await subcollectionRef.get(); // Added 'await' here
      if (getData.docs.isNotEmpty) {
        getData.docs.forEach((element) {
          print(element);
          counter.add(element.data()); // Added semicolon here
        });
        for (int i = 0; i < counter.length; i++) {
          if (counter[i]["Attend"] == 2) {
            absent += 1;
          } else if (counter[i]["Attend"] == 1) {
            present += 1;
          } else {
            authorized += 1;
          }
        }
        value.add(present);
        value.add(absent);
        value.add(authorized);
        value.add(counter.length);
        return value;
      }
    } catch (e) {
      return [1, 1, 1, -1];
    }
    return [1, 1, 1, -1];
  }

  Future<List> userEventAttendedList(String id) async {
    print(123456555555);
    List<dynamic> counter = [];
    try {
      DocumentReference studentDocRef = _attendanceStudent.doc(id);

      CollectionReference subcollectionRef =
          studentDocRef.collection('newSubcollection');
      var getData = await subcollectionRef.get(); // Added 'await' here
      if (getData.docs.isNotEmpty) {
        getData.docs.forEach((element) {
          print(element);
          counter.add(element.data()); // Added semicolon here
        });
      }
      return counter;
    } catch (e) {
      return [];
    }
  }
}

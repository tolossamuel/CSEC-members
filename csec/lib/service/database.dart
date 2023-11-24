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
      String schoolId) async {
    try {
      sendEmail(fullName, password, email);
      await _userInfo.doc(userId).set({
        "name": fullName,
        "UserType": userType,
        "email": email,
        "Bach": bach,
        "Department": department,
        "SchoolId": schoolId,
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
}

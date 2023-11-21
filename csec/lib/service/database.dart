import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference _userInfo =
      FirebaseFirestore.instance.collection("UserInfo");
  Future userInfoData(String fullName, String userType, String userId) async {
    return await (_userInfo
        .doc(userId)
        .set({"name": fullName, "UserType": userType}));
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
}

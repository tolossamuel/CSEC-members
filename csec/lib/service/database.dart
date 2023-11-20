import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final CollectionReference _userInfo =
      FirebaseFirestore.instance.collection("UserInfo");
  Future userInfoData(String fullName, String userId) async {
    return await (_userInfo.doc(userId).set({"name": fullName}));
  }
}

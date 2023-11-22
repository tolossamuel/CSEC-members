import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csec/homePage/Admin/Controller/repository.dart';
import 'package:csec/service/database.dart';
import 'package:get/get.dart';

class Controller extends GetxController {
  late final AdminRepo _repository;
  Controller({required AdminRepo repository}) {
    _repository = repository;
  }
}

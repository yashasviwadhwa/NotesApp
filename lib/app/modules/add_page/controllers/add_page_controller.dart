import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/app/models/notes.dart';
import 'package:notes_app/app/services/Database_helper.dart';

class AddPageController extends GetxController {

  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final updatedAtController = TextEditingController();
  @override
  void onInit() {
    super.onInit();
  }

  Future<void> addData(String title, String content, DateTime updatedAt) async {
    try {
      final note = Notes(title: title, content: content, updatedAt: updatedAt);
      await DatabaseHelper().insertNote(note);
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        'Title',
        'This is a GetX Snackbar message!',
        snackPosition: SnackPosition.BOTTOM, 
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}

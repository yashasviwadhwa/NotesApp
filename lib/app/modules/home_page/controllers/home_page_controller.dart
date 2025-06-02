import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes_app/app/models/notes.dart';
import 'package:notes_app/app/services/Database_helper.dart';

class HomePageController extends GetxController {
  final RxList<Notes> allNotes = <Notes>[].obs;
  final RxList<Notes> filteredNotes = <Notes>[].obs;

  final TextEditingController searchController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  final updatedAtController = TextEditingController();

  final RxBool isLoading = false.obs;

  final StreamController<List<Notes>> _notesStreamController =
      StreamController.broadcast();
  Stream<List<Notes>> get notesStream => _notesStreamController.stream;

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(() {
      filterNotes(searchController.text);
    });
    loadNotes();
  }

  Future<void> loadNotes() async {
    try {
      isLoading.value = true;
      final notes = await DatabaseHelper().getNotes();
      allNotes.assignAll(notes);
      filterNotes(searchController.text);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load notes: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void filterNotes(String enterKeyword) {
    List<Notes> notesToFilter = allNotes;

    if (enterKeyword.isNotEmpty) {
      notesToFilter =
          notesToFilter.where((note) {
            return note.title.toLowerCase().contains(
                  enterKeyword.toLowerCase(),
                ) ||
                note.content.toLowerCase().contains(enterKeyword.toLowerCase());
          }).toList();
    }

    filteredNotes.assignAll(notesToFilter);
    _notesStreamController.add(filteredNotes);
  }

  Future<void> deleteNote(int id) async {
    try {
      await DatabaseHelper().deleteNote(id);
      allNotes.removeWhere((note) => note.id == id);
      filterNotes(searchController.text);
      Get.snackbar(
        "Success",
        "Note deleted successfully!",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to delete note: $e",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> updateNotess({
    required String title,
    required String content,
    required DateTime update,
  }) async {
    try {
      final updatedNotes = Notes(
        title: titleController.text.trim(),
        content: contentController.text.trim(),
        updatedAt: DateTime.parse(updatedAtController.text.trim()),
      );
      await DatabaseHelper().updateNote(updatedNotes);
      Get.back();
      refreshNotes();
      Get.snackbar(
        'Success',
        'Notes refreshed successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green.withValues(alpha: 0.8),
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong: $e');
    }
  }

  void sortByTitle() {
    filteredNotes.sort(
      (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
    );
    _notesStreamController.add(filteredNotes);
  }

  void sortByDate() {
    filteredNotes.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    _notesStreamController.add(filteredNotes);
  }

  Future<void> refreshNotes() async {
    await loadNotes();
  }

  @override
  void onClose() {
    searchController.dispose();
    titleController.dispose();
    contentController.dispose();
    updatedAtController.dispose();
    _notesStreamController.close();
    super.onClose();
  }

  var themeMode = ThemeMode.light.obs;

  void toggleTheme() {
    themeMode.value =
        themeMode.value == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    Get.changeThemeMode(themeMode.value);
  }

  bool get isDarkMode => themeMode.value == ThemeMode.dark;
}

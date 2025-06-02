import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/add_page_controller.dart';

class AddPageView extends GetView<AddPageController> {
  AddPageView({super.key});

  @override
  final AddPageController control = Get.put(AddPageController());
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text(
          'Add New Note',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.background,
                Theme.of(context).colorScheme.surface,
                Theme.of(context).colorScheme.onBackground,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              children: [
                SizedBox(height: 15.h),
                TextFormField(
                  controller: control.titleController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Note Title",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(Icons.title, color: Colors.grey),
                    filled: true,
                    fillColor: const Color(0xFF2C2C2E),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF2C5364),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter a title'
                              : null,
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: control.contentController,
                  maxLines: 7,
                  style: const TextStyle(color: Colors.white),
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: "Note Content",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: const Icon(Icons.description, color: Colors.grey),
                    ),
                    alignLabelWithHint: true,
                    filled: true,
                    fillColor: const Color(0xFF2C2C2E),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF2C5364),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please enter content'
                              : null,
                ),
                SizedBox(height: 20.h),
                TextFormField(
                  controller: control.updatedAtController,
                  readOnly: true,
                  onTap: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                      builder: (context, child) {
                        return Theme(
                          data: ThemeData.dark().copyWith(
                            colorScheme: const ColorScheme.dark(
                              primary: Color(0xFF2C5364),
                              onPrimary: Colors.white,
                              surface: Color(0xFF203A43),
                              onSurface: Colors.white,
                            ),
                          ),
                          child: child!,
                        );
                      },
                    );

                    if (pickedDate != null) {
                      control.updatedAtController.text =
                          "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Last Updated Date",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    prefixIcon: const Icon(
                      Icons.calendar_today,
                      color: Colors.grey,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF2C2C2E),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(
                        color: Color(0xFF2C5364),
                        width: 2,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Colors.red, width: 2),
                    ),
                  ),
                  validator:
                      (value) =>
                          value == null || value.isEmpty
                              ? 'Please select a date'
                              : null,
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final parsedDate = DateTime.parse(
                  control.updatedAtController.text.trim(),
                );
                control.addData(
                  control.titleController.text.trim(),
                  control.contentController.text.trim(),
                  parsedDate,
                );
                Get.snackbar(
                  "Success",
                  "Form is valid! You can now save the note.",
                  backgroundColor: Colors.green.withValues(alpha: 0.7),
                  colorText: Colors.white,
                );
              } else {
                Get.snackbar(
                  "Error",
                  "Please fill all fields correctly.",
                  backgroundColor: Colors.red.withValues(alpha: 0.7),
                  colorText: Colors.white,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2C5364),
              padding: EdgeInsets.symmetric(vertical: 15.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
              elevation: 5,
            ),
            child: Text(
              "Add Note",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

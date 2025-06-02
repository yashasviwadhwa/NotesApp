import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:notes_app/app/modules/add_page/views/add_page_view.dart';
import '../controllers/home_page_controller.dart';

class HomePageView extends GetView<HomePageController> {
  HomePageView({super.key});
  @override
  final HomePageController controller = Get.put(HomePageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 12.h),
          child: Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.sortByTitle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C5364),
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 5,
                  ),
                  child: Text(" Sort By Title"),
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: controller.sortByDate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2C5364),
                    padding: EdgeInsets.symmetric(vertical: 15.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                    elevation: 5,
                  ),
                  child: Text("Sort By Date "),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: Theme.of(context).appBarTheme.elevation,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        foregroundColor: Theme.of(context).appBarTheme.foregroundColor,
        leading: IconButton(
          icon: Obx(() {
            final isDark = controller.isDarkMode;
            return Icon(isDark ? Icons.light_mode : Icons.dark_mode);
          }),
          onPressed: () {
            controller.toggleTheme();
          },
        ),
        title: const Text(
          'Notes',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              await Get.to(() => AddPageView());
            },
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: DecoratedBox(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 14.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: TextField(
                  controller: controller.searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Theme.of(context).inputDecorationTheme.fillColor,
                    hintText: "Search Notes",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  onChanged: (value) {
                    controller.filterNotes(value);
                  },
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 13.0),
                child: Text(
                  "Sort by",
                  style: TextStyle(
                    color: Theme.of(context).appBarTheme.titleTextStyle?.color,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: controller.notesStream,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          color: Theme.of(context).progressIndicatorTheme.color,
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          'Error: ${snapshot.error}',
                          style: TextStyle(
                            color:
                                Theme.of(
                                  context,
                                ).appBarTheme.titleTextStyle?.color,
                            fontSize: 16,
                          ),
                        ),
                      );
                    } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(
                        child: Text(
                          controller.searchController.text.isNotEmpty
                              ? 'No notes found for "${controller.searchController.text}"'
                              : 'No notes available. Add one!',
                          style: TextStyle(
                            color:
                                Theme.of(
                                  context,
                                ).appBarTheme.titleTextStyle?.color,
                            fontSize: 16,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    } else {
                      return ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        itemCount: controller.filteredNotes.length,
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: ValueKey(controller.filteredNotes[index].id),
                            direction: DismissDirection.endToStart,
                            background: Container(
                              height: 50.h,
                              decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.error,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              alignment: Alignment.centerRight,
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              child: Icon(
                                Icons.delete,
                                color: Theme.of(context).colorScheme.onError,
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              return await Get.dialog(
                                    AlertDialog(
                                      title: const Text("Delete Note"),
                                      content: const Text(
                                        "Are you sure you want to delete this note?",
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed:
                                              () => Get.back(result: false),
                                          child: const Text("Cancel"),
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Get.back(result: true),
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) ??
                                  false;
                            },
                            onDismissed: (direction) {
                              controller.deleteNote(
                                controller.filteredNotes[index].id!,
                              );
                            },
                            child: Card(
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              elevation: 3,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              color:
                                  Theme.of(
                                    context,
                                  ).appBarTheme.titleTextStyle?.color,
                              child: ListTile(
                                leading: CircleAvatar(
                                  radius: 16.r,
                                  backgroundColor: Colors.blue.shade100,
                                  child: Text(
                                    snapshot.data![index].id.toString(),
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                                title: Text(
                                  snapshot.data![index].title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey.shade800,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  snapshot.data![index].content,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey.shade600,
                                    height: 1.4,
                                  ),
                                  maxLines: 4,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                onTap: () {
                                  Get.dialog(
                                    AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          16.r,
                                        ),
                                      ),
                                      title: const Text(
                                        'Update Note',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18,
                                        ),
                                      ),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          children: [
                                            TextField(
                                              controller:
                                                  controller.titleController,
                                              decoration: InputDecoration(
                                                labelText: 'Title',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.r,
                                                      ),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 14.h,
                                                      horizontal: 12.w,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(height: 12.h),

                                            TextField(
                                              controller:
                                                  controller.contentController,
                                              maxLines: 3,
                                              decoration: InputDecoration(
                                                labelText: 'Content',
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                      vertical: 14,
                                                      horizontal: 12,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(height: 12.h),

                                            TextField(
                                              controller:
                                                  controller
                                                      .updatedAtController,
                                              readOnly: true,
                                              onTap: () async {
                                                final pickedDate =
                                                    await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(2000),
                                                      lastDate: DateTime(2100),
                                                    );
                                                if (pickedDate != null) {
                                                  controller
                                                          .updatedAtController
                                                          .text =
                                                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                                                }
                                              },
                                              decoration: InputDecoration(
                                                labelText: 'Updated At',
                                                suffixIcon: const Icon(
                                                  Icons.calendar_today,
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                contentPadding:
                                                    EdgeInsets.symmetric(
                                                      vertical: 14.h,
                                                      horizontal: 12.w,
                                                    ),
                                              ),
                                            ),
                                            SizedBox(height: 20.h),

                                            ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 14.w,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                        10.r,
                                                      ),
                                                ),
                                                backgroundColor: const Color(
                                                  0xFF2C5364,
                                                ),
                                              ),
                                              onPressed: () async {
                                                await controller.updateNotess(
                                                  title:
                                                      controller
                                                          .titleController
                                                          .text
                                                          .trim(),
                                                  content:
                                                      controller
                                                          .contentController
                                                          .text
                                                          .trim(),
                                                  update: DateTime.parse(
                                                    controller
                                                        .updatedAtController
                                                        .text
                                                        .trim(),
                                                  ),
                                                );
                                              },
                                              child: const Text(
                                                'Update',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

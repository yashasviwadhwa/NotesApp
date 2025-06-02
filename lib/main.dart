import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:notes_app/app/modules/home_page/views/home_page_view.dart";
import "package:notes_app/app/services/Database_helper.dart";
import "package:notes_app/app/theme.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(
    () async => DatabaseHelper().database.then((_) => DatabaseHelper()),
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      child: Builder(
        builder: (context) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            darkTheme: darkTheme,
            home: HomePageView(),
          );
        },
      ),
    );
  }
}

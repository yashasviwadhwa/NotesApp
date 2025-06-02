import 'package:get/get.dart';
import '../modules/add_page/bindings/add_page_binding.dart';
import '../modules/add_page/views/add_page_view.dart';
import '../modules/home_page/bindings/home_page_binding.dart';
import '../modules/home_page/views/home_page_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME_PAGE;

  static final routes = [
    GetPage(
      name: _Paths.HOME_PAGE,
      page: () => HomePageView(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PAGE,
      page: () => AddPageView(),
      binding: AddPageBinding(),
    ),
  ];
}

import 'package:get/get.dart';
import 'package:localization/pages/file_list/file_list_binding.dart';
import 'package:localization/pages/file_list/file_list_view.dart';
import 'package:localization/pages/home/home_binding.dart';
import 'package:localization/pages/home/home_view.dart';
import 'app_routes.dart';

class AppPages {
  // static const INITIAL = AppRoutes.home;

  static final routes = [
    GetPage(
        name: AppRoutes.home,
        page: () => const HomePage(),
        binding: HomeBinding()),
    GetPage(
      name: AppRoutes.fileList,
      page: () => const FileListPage(),
      transition: Transition.native,
      binding: FileListBinding(),
    ),
  ];
}

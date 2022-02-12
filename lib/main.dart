import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/route_manager.dart';
import 'package:localization/router/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'FTDriver',
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      //debug下 是否显示右上角 DEBUG标志
      themeMode: ThemeMode.light,
      getPages: AppPages.routes, //路由
      // home: home,
    );
  }
}

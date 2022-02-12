import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class FileListController extends GetxController {
  late Map fileMap = {};
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    if (Get.arguments == null) {
      return;
    }
    fileMap = Get.arguments["data"];
    update();
  }

  @override
  void onClose() {}

  void copyContent(String? content) {
    if (content != null && content != '') {
      Clipboard.setData(ClipboardData(text: content));
      EasyLoading.showToast("复制成功");
    }
  }
}

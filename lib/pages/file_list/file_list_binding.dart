import 'package:get/get.dart';
import 'file_list_controller.dart';

class FileListBinding extends Bindings {
    @override
    void dependencies() {
    Get.lazyPut<FileListController>(() => FileListController());
    }
}

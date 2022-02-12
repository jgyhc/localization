import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:localization/router/app_routes.dart';

enum LocalizationFileType { strings, json, xml }

class HomeController extends GetxController {
  final count = 0.obs;
  String fileName = "";
  FilePickerResult? pickedFile;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {}

  @override
  void onClose() {}

  void selectFile() {
    openExcel();
  }

  void openExcel() async {
    pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );
    // var file = pickedFile.names.first;
    if (pickedFile == null) {
      return;
    }
    fileName = pickedFile!.names.first!;
    update();
  }

  void createFile(LocalizationFileType type) {
    if (pickedFile == null) {
      EasyLoading.showToast("请先选择文件");
      return;
    }

    /// file might be picked
    if (pickedFile != null) {
      var bytes = pickedFile!.files.single.bytes;
      var excel = Excel.decodeBytes(bytes!);

      for (var table in excel.tables.keys) {
        print(table); //sheet Name
        print(excel.tables[table]?.maxCols);
        print(excel.tables[table]?.maxRows);

        //获取到当前表格
        var tableObj = excel.tables[table];
        //表如果是空的  则跳过
        if (tableObj!.rows.isEmpty) {
          continue;
        }
        //第一行一般为标题  作为文件名
        var firstRow = tableObj.rows[0];
        Map fileMap = {}; //用来保存
        for (var i = 0; i < firstRow.length; i++) {
          var item = firstRow[i];
          if (i == 0) {
            continue; //第一列为key  不用建文件
          }
          if (item!.value == null) {
            //如果标题不存在 就不管了
            continue;
          }
          var fileName = item.value; //获取第一行 每一列作为文件 名
          fileMap[fileName] = "";
        }
        print(fileMap);
        //第一行 不用再遍历
        for (var i = 1; i < tableObj.rows.length; i++) {
          var row = tableObj.rows[i]; //每一行的数据
          var key = "";
          for (var j = 0; j < row.length; j++) {
            //第一列作为key
            var data = row[j];
            var value = data?.value ?? "";
            if (j == 0) {
              key = value;
              continue;
            }
            var title = tableObj
                .cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: 0));
            String totalValue = fileMap[title.value];
            switch (type) {
              case LocalizationFileType.strings:
                totalValue = totalValue + createStringsContent(key, value);
                break;
              case LocalizationFileType.json:
                totalValue = totalValue + createJsonContent(key, value);
                break;
              case LocalizationFileType.xml:
                totalValue = totalValue + createXmlContent(key, value);
                break;
              default:
            }

            fileMap[title.value.toString()] = totalValue;
          }
          //
        }
        Get.toNamed(AppRoutes.fileList, arguments: {"data": fileMap});
      }
    }
  }

  void createStringsFile() {
    createFile(LocalizationFileType.strings);
  }

  void createJsonFile() {
    createFile(LocalizationFileType.json);
  }

  void createXmlFile() {
    createFile(LocalizationFileType.xml);
  }

  String createStringsContent(String key, String value) {
    var string = "";
    string = string + "\"$key\" = \"$value\";";
    string = string + "\n";
    return string;
  }

  String createJsonContent(String key, String value) {
    var string = "";
    string = string + "\"$key\" : \"$value\",";
    string = string + "\n";
    return string;
  }

  //<string name="sun">日</string>
  String createXmlContent(String key, String value) {
    var string = "";
    string = string + "<string name=\"$key\">$value</string>";
    string = string + "\n";
    return string;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'file_list_controller.dart';

class FileListPage extends GetView<FileListController> {
  const FileListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FileListController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("文件列表"),
        ),
        body: ListView.builder(
            itemCount: controller.fileMap.keys.length,
            itemBuilder: (context, index) {
              String key = controller.fileMap.keys.toList()[index];
              var content = controller.fileMap[key];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(key),
                          TextButton(
                              onPressed: () {
                                controller.copyContent(content);
                              },
                              child: const Text("复制内容")),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                      child: Text(
                        content,
                        maxLines: 4,
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
              );
            }),
      );
    });
  }
}

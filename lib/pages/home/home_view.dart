import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (controller) {
      return Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("选择文件"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                    onPressed: controller.selectFile,
                    child: const Text("选择文件")),
                Container(
                  child: Text(
                    controller.fileName,
                  ),
                  padding: const EdgeInsets.only(top: 20),
                ),
                Container(
                  child: TextButton(
                      onPressed: controller.createStringsFile,
                      child: const Text("生成strings文件格式(iOS)")),
                  padding: const EdgeInsets.only(top: 20),
                ),
                Container(
                  child: TextButton(
                      onPressed: controller.createJsonFile,
                      child: const Text("生成json文件格式(Flutter)")),
                  padding: const EdgeInsets.only(top: 20),
                ),
                Container(
                  child: TextButton(
                      onPressed: controller.createXmlFile,
                      child: const Text("生成xml文件格式(Android)")),
                  padding: const EdgeInsets.only(top: 20),
                )
              ],
            ),
          ));
    });
  }
}

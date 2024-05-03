import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  RxBool flag = false.obs;
  // 说白了就是通过监听listview的滚动举例来改变flag，通过flag的三目运算来改变appbar的样式，所以会见到大量的有关flag的三目运算
  final ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(() {
      if (scrollController.position.pixels > 10) {
        if (flag.value == false) {
          // print("position.pixels > 10");
          flag.value = true;
          update();
        }
      }
      if (scrollController.position.pixels < 10) {
        if (flag.value == true) {
            // print("position.pixels < 10");
          flag.value = false;
          update();
        }
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}

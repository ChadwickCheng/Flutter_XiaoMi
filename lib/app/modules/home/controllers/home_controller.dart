import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomeController extends GetxController {
  Dio dio = new Dio();

  // 浮动导航开关
  RxBool flag = false.obs;
  // 说白了就是通过监听listview的滚动举例来改变flag，通过flag的三目运算来改变appbar的样式，所以会见到大量的有关flag的三目运算
  final ScrollController scrollController = ScrollController();
  // 轮播图
  RxList swiperList = [].obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    // 请求轮播图数据
    getFocusData();
  }

  void scrollControllerListener(){
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

  getFocusData() async{
    var res = await dio.get('https://miapp.itying.com/api/focus');
    swiperList.value = res.data['result'];
    update();
  }
}

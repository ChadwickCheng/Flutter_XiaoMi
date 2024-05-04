import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../../models//focus_model.dart';
import '../../../models/category_model.dart';
import '../../../models/plist_model.dart';

class HomeController extends GetxController {
  Dio dio = Dio();

  // 浮动导航开关
  RxBool flag = false.obs;
  // 说白了就是通过监听listview的滚动举例来改变flag，通过flag的三目运算来改变appbar的样式，所以会见到大量的有关flag的三目运算
  final ScrollController scrollController = ScrollController();
  // 轮播图
  RxList<FocusItemModel> swiperList = <FocusItemModel>[].obs;
  // 分类
  RxList<CategoryItemModel> categoryList = <CategoryItemModel>[].obs;
  // 甄选商品
  RxList<PlistItemModel> sellingPlist = <PlistItemModel>[].obs;
  // 甄选轮播图
  RxList<FocusItemModel> bestSellingSwiperList = <FocusItemModel>[].obs;  
  // 热门商品
  RxList<PlistItemModel> bestPlist = <PlistItemModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    // 请求轮播图数据
    getFocusData();
    // 请求分类数据
    getCategoryData();
    // 甄选轮播图
    getSellingSwiperData();
    // 甄选商品
    getSellingPlistData();
    // 获取热门商品
    getBestPlistData();
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
  // 轮播图数据
  getFocusData() async{
    var res = await dio.get('https://miapp.itying.com/api/focus');
    var focus = FocusModel.fromJson(res.data);
    swiperList.value = focus.result!;
    update();
  }

  // 首页分类数据
  getCategoryData() async {
    var response = await Dio().get("https://miapp.itying.com/api/bestCate");
    var category=CategoryModel.fromJson(response.data); 
    categoryList.value=category.result!;
    update();
  }

  // 甄选轮播图
  getSellingSwiperData() async {
    var response = await Dio().get("https://miapp.itying.com/api/focus?position=2");
    var sellingSwiper=FocusModel.fromJson(response.data);     
    bestSellingSwiperList.value=sellingSwiper.result!;
    update();
  }

  // 甄选商品
  getSellingPlistData() async {
    var response = await Dio().get("https://miapp.itying.com/api/plist?is_hot=1&pageSize=3");
    var plist=PlistModel.fromJson(response.data);     
    sellingPlist.value=plist.result!;
    update();
  }

  // 热门商品
  getBestPlistData() async {
    var response = await Dio().get("https://miapp.itying.com/api/plist?is_best=1");
    var plist=PlistModel.fromJson(response.data);     
    bestPlist.value=plist.result!;
    update();
  }
}

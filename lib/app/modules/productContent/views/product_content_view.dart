import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/product_content_controller.dart';
import "../../../services/screenAdapter.dart";
import './first_page_view.dart';
import './second_page_view.dart';
import "./third_page_view.dart";

class ProductContentView extends GetView<ProductContentController> {
  const ProductContentView({Key? key}) : super(key: key);

  //bottomSheet更新流数据需要使用 GetBuilder 来渲染数据
  void showBottomAttr() {
    Get.bottomSheet(
    GetBuilder<ProductContentController>(
      init: controller,
      builder: (controller) {
        return Container(
          color: Colors.white,
          padding: EdgeInsets.all(ScreenAdapter.width(20)),
          width: double.infinity,
          height: ScreenAdapter.height(1200),
          child: ListView(
              children: controller.pcontent.value.attr!.map((v) {
            return Wrap(
              children: [
                Container(
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.height(20),
                      left: ScreenAdapter.width(20)),
                  width: ScreenAdapter.width(1040),
                  child: Text("${v.cate}",
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: ScreenAdapter.height(20),
                      left: ScreenAdapter.width(20)),
                  width: ScreenAdapter.width(1040),
                  child: Wrap(
                      children: v.attrList!.map((value) {
                    return InkWell(
                      onTap: () {
                        controller.changeAttr(v.cate, value["title"]);
                      },
                      child: Container(
                        margin: EdgeInsets.all(ScreenAdapter.width(20)),
                        child: Chip(
                            padding: EdgeInsets.only(
                                left: ScreenAdapter.width(20),
                                right: ScreenAdapter.width(20)),
                            backgroundColor: value["checked"] == true
                                ? Colors.red
                                : const Color.fromARGB(31, 223, 213, 213),
                            label: Text(value["title"])),
                      ),
                    );
                  }).toList()),
                )
              ],
            );
          }).toList()),
        );
      },
    ));
  }

  Widget _appBar(BuildContext context) {
    return Obx(
      () => AppBar(
        leading: Container(
          alignment: Alignment.center,
          child: SizedBox(
              width: ScreenAdapter.width(88),
              height: ScreenAdapter.width(88),
              child: ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                style: ButtonStyle(
                    //注意:去掉button默认的padding
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                child: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
              )),
        ),
        title: SizedBox(
          width: ScreenAdapter.width(400),
          height: ScreenAdapter.height(96),
          child: controller.showTabs.value
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: controller.tabsList.map((v) {
                    return InkWell(
                        onTap: () {
                          controller.changeSelectedTabsIndex(v["id"]);
                          //跳转到指定的容器
                          if (v["id"] == 1) {
                            Scrollable.ensureVisible(
                                controller.gk1.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 100));
                          } else if (v["id"] == 2) {
                            Scrollable.ensureVisible(
                                controller.gk2.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 100));
                          } else {
                            Scrollable.ensureVisible(
                                controller.gk3.currentContext as BuildContext,
                                duration: const Duration(milliseconds: 500));
                          }
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${v["title"]}",
                              style: TextStyle(
                                  fontSize: ScreenAdapter.fontSize(36)),
                            ),
                            v["id"] == controller.selectedTabsIndex.value
                                ? Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenAdapter.height(10)),
                                    width: ScreenAdapter.width(100),
                                    height: ScreenAdapter.height(2),
                                    color: Colors.red,
                                  )
                                : Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenAdapter.height(10)),
                                    width: ScreenAdapter.width(100),
                                    height: ScreenAdapter.height(2),
                                  )
                          ],
                        ));
                  }).toList())
              : const Text(""),
        ),
        centerTitle: true,
        backgroundColor:
            Colors.white.withOpacity(controller.opcity.value), //实现透明导航
        elevation: 0, //实现透明导航
        actions: [
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(88),
            height: ScreenAdapter.width(88),
            child: ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                    //注意:去掉button默认的padding
                    padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                child: const Icon(
                  Icons.file_upload_outlined,
                )),
          ),
          Container(
            margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
            width: ScreenAdapter.width(88),
            height: ScreenAdapter.width(88),
            child: ElevatedButton(
                onPressed: () {
                  showMenu(
                      color: Colors.black87.withOpacity(0.7),
                      context: context,
                      position: RelativeRect.fromLTRB(
                          ScreenAdapter.width(800),
                          ScreenAdapter.height(220),
                          ScreenAdapter.width(20),
                          0),
                      items: [
                        PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(Icons.home, color: Colors.white),
                              Text("首页", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(Icons.message, color: Colors.white),
                              Text("消息", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        ),
                        PopupMenuItem(
                          child: Row(
                            children: const [
                              Icon(Icons.star, color: Colors.white),
                              Text("收藏", style: TextStyle(color: Colors.white))
                            ],
                          ),
                        )
                      ]);
                },
                style: ButtonStyle(
                    //注意
                    padding: MaterialStateProperty.all(EdgeInsets.all(0)),
                    alignment: Alignment.center,
                    backgroundColor: MaterialStateProperty.all(Colors.black12),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all(const CircleBorder())),
                child: const Icon(
                  Icons.more_horiz_rounded,
                )),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      controller: controller.scrollController,
      child: Column(
        children: [
          FirstPageView(showBottomAttr),
          SecondPageView(),
          ThirdPageView(),
        ],
      ),
    );
  }

  Widget _bottom() {
    return Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          height: ScreenAdapter.height(160),
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(
                      width: ScreenAdapter.width(2), color: Colors.black12))),
          child: Row(
            children: [
              SizedBox(
                width: ScreenAdapter.width(200),
                height: ScreenAdapter.height(160),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.shopping_cart),
                    Text(
                      "购物车",
                      style: TextStyle(fontSize: ScreenAdapter.fontSize(32)),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdapter.height(120),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(255, 165, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              // CircleBorder()
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        showBottomAttr();
                      },
                      child: Text("加入购物车"),
                    ),
                  )),
              Expanded(
                  flex: 1,
                  child: Container(
                    height: ScreenAdapter.height(120),
                    margin: EdgeInsets.only(right: ScreenAdapter.width(20)),
                    child: ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(253, 1, 0, 0.9)),
                          foregroundColor:
                              MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                              // CircleBorder()
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)))),
                      onPressed: () {
                        showBottomAttr();
                      },
                      child: Text("立即购买"),
                    ),
                  ))
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, //实现透明导航
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(ScreenAdapter.height(120)),
          child: _appBar(context)),
      body: Stack(
        children: [
          _body(),
          _bottom(),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';

import 'dart:io';

void main() {
  // 禁用日志
  if (Platform.isAndroid) {
    // const bool.fromEnvironment('FLUTTER_DEBUG', defaultValue: false);
    debugPrint = (String? message, {int? wrapWidth}) {};
  }
  

  //配置透明的状态栏 让手机最顶部的状态栏透明，和app的背景色一样
  SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(statusBarColor: Colors.transparent);
  SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  runApp(
    ScreenUtilInit(
      designSize: const Size(1080, 2400),   //设计稿的宽度和高度 px
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context , child) {
        return  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey, // 返回按钮
          ),
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          defaultTransition: Transition.rightToLeft, // ios风格的切换动画
        );
      }
    )
  );
}

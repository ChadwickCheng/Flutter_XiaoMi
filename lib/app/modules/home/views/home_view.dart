import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

import '../../../services/keepAliveWrapper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            width: 1080.w,
            height: 690.h,
            color: Colors.red,
          ),
          SizedBox(height: 20.h),
          Container(
            width: 540.w,
            height: 690.h,
            color: Colors.pink,
            child: Text(
              'hello flutter home',
              style: TextStyle(
                fontSize: 32.sp,
              ),
            ),
          ),
        ],
      ),
    ));
  }
}

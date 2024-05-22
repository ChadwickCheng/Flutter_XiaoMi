import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../services/screenAdapter.dart';
import '../controllers/product_content_controller.dart';

// class ThirdPageView extends GetView {
//   @override
//   final ProductContentController controller = Get.find();
//   ThirdPageView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       key: controller.gk3,
//       alignment: Alignment.center,
//       width: ScreenAdapter.width(1080),
//       height: ScreenAdapter.height(2200),
//       color: Colors.red,
//       child: const Text("推荐", style: TextStyle(fontSize: 100)),
//     );
//   }
// }

class ThirdPageView extends GetView {
  @override
  final ProductContentController controller = Get.find();
  ThirdPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: <Widget>[
            Container(
              height: 200.0,
              color: Colors.blue,
              child: Center(child: Text('Header Image')),
            ),
            ListView.builder(
              padding: EdgeInsets.only(top: 200.0),
              itemCount: 50,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Container(
                    color: Colors.red,
                    child: ListTile(title: Text('Red Div')),
                  );
                } else {
                  return ListTile(title: Text('Item $index'));
                }
              },
            ),
          ],
        );
  }
}
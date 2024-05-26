import 'package:get/get.dart';

import '../../../services/storage.dart';

class CheckoutController extends GetxController {
  RxList checkoutList = [].obs;
  @override
  void onInit() {
    super.onInit();
    getCheckoutData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  getCheckoutData() async {
    List tempList = await Storage.getData("checkoutList");
    checkoutList.value = tempList;
    update();
  }
}

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../models/pcontent_model.dart';
import '../../../services/httpsClient.dart';
class ProductContentController extends GetxController {
  final ScrollController scrollController = ScrollController();
  HttpsClient httpsClient = HttpsClient();
  GlobalKey gk1 = GlobalKey();
  GlobalKey gk2 = GlobalKey();
  GlobalKey gk3 = GlobalKey();  
  //导航的透明度
  RxDouble opcity=0.0.obs;
  //是否显示tabs
  RxBool showTabs=false.obs;

  //详情数据
  var pcontent=PcontentItemModel().obs;

  
  List tabsList=[
    { 
      "id":1,
      "title":"商品",      
    },
    { "id":2,
      "title":"详情"
    },
    { 
      "id":3,
      "title":"推荐"
    }
  ];
  RxInt selectedTabsIndex=1.obs;

  @override
  void onInit() {
    super.onInit();
    scrollControllerListener();
    getContentData();
  }
  //监听滚动条滚动事件
  void scrollControllerListener() {
    scrollController.addListener(() {
      if (scrollController.position.pixels <= 100) {
        opcity.value=scrollController.position.pixels/100;
        if(showTabs.value==true){
          showTabs.value=false;          
        }
        update();
      } else{
        if(showTabs.value==false){
          showTabs.value=true;
          update();
        }
      }  
    });
  }


  @override
  void onClose() {
    super.onClose();
  }
  //改变tab切换
  void changeSelectedTabsIndex(index){
    selectedTabsIndex.value=index;
    update();
  }

  
  //获取详情数据
  getContentData() async {
    var response = await httpsClient.get("api/pcontent?id=${Get.arguments["id"]}");
    if (response != null) {
      var tempData = PcontentModel.fromJson(response.data);     
      pcontent.value=tempData.result!;
      update();
    }
  }

}

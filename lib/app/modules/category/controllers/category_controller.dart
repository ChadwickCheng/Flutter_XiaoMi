import 'package:get/get.dart';
import '../../../models/category_model.dart';
import '../../../services/httpsClient.dart';

class CategoryController extends GetxController {
  HttpsClient httpsClient = HttpsClient();
  // 点击按钮是否选中 所谓的带指示器按钮就是个定位容器内包含两个容器，一个是按钮，一个是指示器
  RxInt  selectIndex = 0.obs;
  // 左侧导航
  RxList<CategoryItemModel> leftCategoryList = <CategoryItemModel>[].obs;
  // 右侧导航
  RxList<CategoryItemModel> rightCategoryList = <CategoryItemModel>[].obs;
  /*
  点击左右导航，右侧渲染数据的思路：
  1. 点击左侧导航，获取左侧导航的id，然后根据id获取右侧导航数据
  */

  @override
  void onInit() {
    super.onInit();
    // 获取左侧导航数据
    getLeftCategoryData();
  }

  void changeIndex(index,id) {
    selectIndex.value=index;
    getRightCategoryData(id);
    update();
  }

  // 获取左侧导航数据
  getLeftCategoryData() async{
    var response = await httpsClient.get("api/pcate");
    if(response!=null){
      var category=CategoryModel.fromJson(response.data); 
      leftCategoryList.value=category.result!;
      getRightCategoryData(leftCategoryList[0].sId!);
      update();
    }
  }
  // 获取右侧商品数据
  getRightCategoryData(String pid) async{
    var response = await httpsClient.get("api/pcate?pid=$pid");
    if(response!=null){
      var category=CategoryModel.fromJson(response.data); 
      rightCategoryList.value=category.result!;
      update();
    }
  }
}

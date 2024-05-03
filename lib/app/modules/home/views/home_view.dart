import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../../services/keepAliveWrapper.dart';
import '../../../services/screenAdapter.dart';
import '../../../services/ityingFonts.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  // 顶部导航
  Widget _appBar(){
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Obx(() => AppBar(
        leading: controller.flag.value?const Text(""):const Icon(
          ItyingFonts.xiaomi,
          color: Colors.white,
        ),
        leadingWidth:controller.flag.value?ScreenAdapter.width(40):ScreenAdapter.width(140) ,
        title: AnimatedContainer(
          width: controller.flag.value?ScreenAdapter.width(800):ScreenAdapter.width(620),
          height: ScreenAdapter.height(96),
          decoration: BoxDecoration(
            color: const Color.fromARGB(230, 252, 243, 236),
            borderRadius: BorderRadius.circular(30),
          ),
          duration: const Duration(milliseconds: 600),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(ScreenAdapter.width(34), 0, ScreenAdapter.width(10), 0),
                child: const Icon(Icons.search),
              ),
              Text(
                "手机",
                style: TextStyle(
                  color: Colors.black54,
                  fontSize: ScreenAdapter.fontSize(32)
                )
              )
            ],
          ),
        ),
        centerTitle: true,
        backgroundColor: controller.flag.value?Colors.white:Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.qr_code,color:controller.flag.value?Colors.black87:Colors.white,)
          ),
          IconButton(
            onPressed: () {}, 
            icon: Icon(Icons.message,color:controller.flag.value?Colors.black87:Colors.white)
          )
        ],
      )),
    );
  }

  // 内容区域
  Widget _homePage(){
    return Positioned(
      top: -40,
      left: 0,
      right:0,
      bottom: 0,
      child: ListView(
        controller: controller.scrollController,
        children: [
          _focus(),
          _banner(),
          _category(),
          _banner2(),
          _bestSelling(),
          const SizedBox(height: 100,)
        ],
      )
    );
  }

  // 轮播图
  Widget _focus(){
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(682),
      child: Obx(()=>Swiper(
        itemCount: controller.swiperList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          String picUrl = "https://miapp.itying.com/${controller.swiperList[index].pic}";
          return Image.network(
            picUrl.replaceAll('\\', '/'),
            fit: BoxFit.fill,
          );
        },
        pagination: const SwiperPagination(
          builder: SwiperPagination.rect, // 分页指示器样式
        ),
        loop: true,
      )),
    );
  }

  // banner
  Widget _banner(){
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(92),
      child: Image.asset(
        "assets/images/xiaomiBanner.png",
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _banner2(){
    return Padding(
      padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20),
          ScreenAdapter.height(20), ScreenAdapter.width(20), 0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenAdapter.width(20)),
          color: Colors.red,
          image: const DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage("assets/images/xiaomiBanner2.png")
            )
          ),
        height: ScreenAdapter.height(420),
      ),
    );
  }

  // 分类
  Widget _category(){
    return SizedBox(
      width: ScreenAdapter.width(1080),
      height: ScreenAdapter.height(470),
      child: Obx(() => Swiper(
        itemBuilder: (context, index) { // index 0-1
          return GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: ScreenAdapter.width(20),
              mainAxisSpacing: ScreenAdapter.height(20),
            ),
            itemBuilder: (context, i) { // i 0-9
            String picUrl = "https://miapp.itying.com/${controller.categoryList[index * 10 + i].pic}";
              return Column(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: ScreenAdapter.height(140),
                    height: ScreenAdapter.height(140),
                    child: Image.network(
                      picUrl.replaceAll('\\', '/'),
                      fit: BoxFit.fitHeight
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, ScreenAdapter.height(4), 0, 0),
                    child: Text(
                      "${controller.categoryList[index * 10 + i].title}",
                      style: TextStyle(
                        fontSize: ScreenAdapter.fontSize(34)
                      )
                    ),
                  )
                ],
              );
            }
          );
        },
        itemCount: controller.categoryList.length ~/ 10, // ~/ 为取整运算符 如果写死2，那么一开始数组没数据会报错
        pagination: SwiperPagination(
          margin: const EdgeInsets.all(0.0),
          builder: SwiperCustomPagination(
            builder:(BuildContext context, SwiperPluginConfig config) {
              return ConstrainedBox(
                constraints: BoxConstraints.expand(height: ScreenAdapter.height(20)),
                child: Row(
                  children: <Widget>[                            
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: const RectSwiperPaginationBuilder(
                          color: Colors.black12,
                          activeColor: Colors.black54,
                        ).build(context, config),
                      ),
                    )
                  ],
                ),
              );
            }
          )
        ),
      )),
    );
  }

  //热销臻选
  Widget _bestSelling() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(
              ScreenAdapter.width(30),
              ScreenAdapter.height(20),
              ScreenAdapter.width(30),
              ScreenAdapter.height(20)),
          child: Row( // 一个flex的左右布局
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("热销臻选",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: ScreenAdapter.fontSize(46)
                )
              ),
              Text("更多手机推荐 >",
                style: TextStyle(fontSize: ScreenAdapter.fontSize(38))
              )
            ],
          )
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(ScreenAdapter.width(20), 0,
              ScreenAdapter.width(20), ScreenAdapter.height(20)),
          child: Row(
            children: [
              //左侧
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: ScreenAdapter.height(738),
                  child: Swiper(
                    itemBuilder: (context, index) {
                      String picUrl =
                          "https://www.itying.com/images/b_focus0${index + 1}.png";
                      return Image.network(
                        picUrl,
                        fit: BoxFit.fill,
                      );
                    },
                    itemCount: 3,
                    autoplay: true,
                    loop: true,
                    pagination: SwiperPagination(
                        margin: const EdgeInsets.all(0.0),
                        builder: SwiperCustomPagination(builder:
                            (BuildContext context,
                                SwiperPluginConfig config) {
                          return ConstrainedBox(
                            constraints: BoxConstraints.expand(
                                height: ScreenAdapter.height(36)),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child:
                                        const RectSwiperPaginationBuilder(
                                      color: Colors.black12,
                                      activeColor: Colors.black54,
                                    ).build(context, config),
                                  ),
                                )
                              ],
                            ),
                          );
                        }))),
                )
              ),
              SizedBox(width: ScreenAdapter.width(20)),
              //右侧
              Expanded(
                flex: 1,
                child: SizedBox(
                  height: ScreenAdapter.height(738),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                    SizedBox(height: ScreenAdapter.height(20)),
                                    Text("空气炸烤箱",style: TextStyle(fontSize: ScreenAdapter.fontSize(38),fontWeight: FontWeight.bold)),
                                    SizedBox(height: ScreenAdapter.height(20)),
                                    Text("大容量专业炸考",style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                                    SizedBox(height: ScreenAdapter.height(20)),
                                    Text("众筹价￥345元",style: TextStyle(fontSize: ScreenAdapter.fontSize(34)))
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(ScreenAdapter.height(8)),
                                  child: Image.network("https://www.itying.com/images/kaoxiang.png",fit: BoxFit.cover),
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                      SizedBox(height: ScreenAdapter.height(20)),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                      SizedBox(height: ScreenAdapter.height(20)),
                                      Text("空气炸烤箱",style: TextStyle(fontSize: ScreenAdapter.fontSize(38),fontWeight: FontWeight.bold)),
                                    SizedBox(height: ScreenAdapter.height(20)),
                                    Text("大容量专业炸考",style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                                    SizedBox(height: ScreenAdapter.height(20)),
                                    Text("众筹价￥345元",style: TextStyle(fontSize: ScreenAdapter.fontSize(34)))
                                  ],
                              ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(ScreenAdapter.height(8)),
                                  child: Image.network("https://www.itying.com/images/shouji.png",fit: BoxFit.cover),
                                ),
                              )
                            ],
                          ),
                        )
                      ),
                      SizedBox(height: ScreenAdapter.height(20)),
                      Expanded(
                        flex: 1,
                        child: SizedBox(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  children: [
                                      SizedBox(height: ScreenAdapter.height(20)),
                                      Text("空气炸烤箱",style: TextStyle(fontSize: ScreenAdapter.fontSize(38),fontWeight: FontWeight.bold)),
                                    SizedBox(height: ScreenAdapter.height(20)),
                                    Text("大容量专业炸考",style: TextStyle(fontSize: ScreenAdapter.fontSize(28))),
                                    SizedBox(height: ScreenAdapter.height(20)),
                                    Text("众筹价￥345元",style: TextStyle(fontSize: ScreenAdapter.fontSize(34)))
                                  ],
                              ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: EdgeInsets.all(ScreenAdapter.height(8)),
                                  child: Image.network("https://www.itying.com/images/shouji.png",fit: BoxFit.cover),
                                ),
                              )
                            ],
                          ),
                        )
                      )
                    ],
                  ),
                )
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return KeepAliveWrapper(
      child: Scaffold(
        body: Stack(
          children: [
            _homePage(),
            _appBar(),
          ],
        ),
      )
    );
  }
}

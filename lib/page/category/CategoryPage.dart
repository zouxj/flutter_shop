import 'package:flutter/material.dart';
import 'package:flutter_shop/Application.dart';
import 'package:flutter_shop/provider/ChildCategoryProvider.dart';
import 'package:flutter_shop/page/category/model/category_goods_list_model_entity.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'dart:convert';
import 'package:flutter_shop/page/category/model/category_page_model_entity.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String text = "加载数据";
  List categoryList = [];
  int indexLast = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategory().then((value) {
      var model = json.decode(value);
      CategoryEntity categoryEntity = CategoryEntity.fromJson(model);
      setState(() {
        categoryList = categoryEntity.data;
      });
      Provide.value<ChildCategory>(context)
          .getChildCategory(categoryList[indexLast].bxMallSubDto, '4');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('商品分类')),
        body: Container(
          child: Row(
            children: <Widget>[
              leftCategoryNav(),
              Column(
                children: <Widget>[
                  rightCategoryNav(),
                  rightCategoryGoodsList()
                ],
              )
            ],
          ),
        ));
  }

  //左侧导航栏
  Widget leftCategoryNav() {
    return Container(
        width: adapterPixel(180),
        decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: ListView.builder(
            itemCount: categoryList.length,
            itemBuilder: (context, index) {
              return _leftInkWel(index);
            }));
  }

  Widget _leftInkWel(int index) {
    bool isClick = false;
    isClick = indexLast == index ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          indexLast = index;
        });
        Provide.value<ChildCategory>(context).getChildCategory(
            categoryList[index].bxMallSubDto,
            categoryList[index].mallCategoryId);
        Provide.value<ChildCategory>(context).changeChildIndex(0, '');
      },
      child: Container(
        height: adapterPixel(100),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Text(categoryList[index].mallCategoryName,
            style: TextStyle(fontSize: adapterPixel(28))),
      ),
    );
  }
}

//分类商品列表
// ignore: camel_case_types
class rightCategoryGoodsList extends StatefulWidget {
  @override
  _rightCategoryGoodsListState createState() => _rightCategoryGoodsListState();
}

// ignore: camel_case_types
class _rightCategoryGoodsListState extends State<rightCategoryGoodsList> {
  @override
  void initState() {
    super.initState();
  }

  var scrollController = new ScrollController();
  String homePageContent = "正在获取数据...";
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  Widget build(BuildContext context) {
    Provide.value<ChildCategory>(context).getGoodList();
    try {
      if (Provide.value<ChildCategory>(context).page == 1) {
        scrollController.jumpTo(0.0);
      }
    } catch (e) {
      print('进入页面第一次初始化：${e}');
    }
    return Provide<ChildCategory>(
      builder: (context, child, data) {
        return Container(
          width: adapterPixel(570),
          height: adapterPixel(1200),
          child: EasyRefresh(
            refreshFooter: ClassicsFooter(
                key: _footerKey,
                bgColor: Colors.white,
                textColor: Colors.pink,
                moreInfoColor: Colors.pink,
                showMore: true,
                noMoreText: '',
                moreInfo: '加载中',
                loadReadyText: '上拉加载....'),
            child: ListView.builder(
              itemCount: data.childCategoryList.length,
              controller: scrollController,
              itemBuilder: (context, index) {
                return __ListWidget(data.childCategoryList, index);
              },
            ),
            loadMore: () {
              Provide.value<ChildCategory>(context).addPage();
              Provide.value<ChildCategory>(context).getGoodList();
            },
          ),
        );
      },
    );
  }

  //商品列表

  // ignore: non_constant_identifier_names
  Widget __ListWidget(List<CategoryGoodsListModelData> goodsList, int index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, "/detail?id=${goodsList[index].goodsId}");
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(goodsList, index),
            Column(
              children: <Widget>[
                _goodsName(goodsList, index),
                _goodsPrice(goodsList, index)
              ],
            )
          ],
        ),
      ),
    );
  }

  //图片
  Widget _goodsImage(List<CategoryGoodsListModelData> goodsList, int index) {
    return Container(
      width: adapterPixel(200.0),
      child: Image.network(goodsList[index].image),
    );
  }

  //名字
  Widget _goodsName(List<CategoryGoodsListModelData> goodsList, int index) {
    return Container(
      padding: EdgeInsets.only(top: 5.0),
      width: adapterPixel(370.0),
      child: Text(
        goodsList[index].goodsName,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: adapterPixel(28)),
      ),
    );
  }

  //价格
  Widget _goodsPrice(List<CategoryGoodsListModelData> goodsList, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: adapterPixel(370),
      child: Row(
        children: <Widget>[
          Text(
            '￥${goodsList[index].presentPrice}',
            style: TextStyle(color: Colors.pink, fontSize: adapterPixel(30)),
          ),
          Text(
            '￥${goodsList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}

// ignore: camel_case_types
class rightCategoryNav extends StatefulWidget {
  @override
  _rightCategoryNavState createState() => _rightCategoryNavState();
}

// ignore: camel_case_types
class _rightCategoryNavState extends State<rightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Provide<ChildCategory>(
      builder: (context, child, childCategory) {
        return Container(
            height: adapterPixel(80.0),
            width: adapterPixel(570.0),
            decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: childCategory.childMallSubdtoList.length,
              itemBuilder: (context, index) {
                return _rightInkWell(
                    index, childCategory.childMallSubdtoList[index]);
              },
            ));
      },
    );
  }

  Widget _rightInkWell(int index, CategoryPageModelDataBxmallsubdto item) {
    bool isCheck = false;
    isCheck = Provide.value<ChildCategory>(context).childIndex == index
        ? true
        : false;

    return InkWell(
      onTap: () {
        Provide.value<ChildCategory>(context)
            .changeChildIndex(index, item.mallSubId);
        Provide.value<ChildCategory>(context).getGoodList();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              fontSize: adapterPixel(28),
              color: isCheck ? Colors.pink : Colors.black),
        ),
      ),
    );
  }
}

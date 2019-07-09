import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/page/category/model/category_goods_list_model_entity.dart';
import 'package:flutter_shop/page/category/model/category_page_model_entity.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/utils/LogUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChildCategory with ChangeNotifier {
  List<CategoryPageModelDataBxmallsubdto> childMallSubdtoList = [];
  int childIndex = 0;
  String categoryId = '4';
  String mallSubId = '';
  int page = 1; //列表页数，当改变大类或者小类时进行改变
  String noMoreText = ''; //显示更多的标识
  getChildCategory(List<CategoryPageModelDataBxmallsubdto> list, String id) {
    CategoryPageModelDataBxmallsubdto all = CategoryPageModelDataBxmallsubdto();
    all.mallSubId = '';
    all.mallCategoryId = '';
    all.mallSubName = '全部';
    all.comments = 'null';
    childIndex = 0;
    categoryId = id;
    childMallSubdtoList = [all];
    childMallSubdtoList.addAll(list);
    noMoreText = '';
    page = 1;
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(index, subId) {
    childIndex = index;
    mallSubId = subId;
    noMoreText = '';
    page = 1;
    notifyListeners();
  }

  List<CategoryGoodsListModelData> childCategoryList = [];

  getChildListCategory(List<CategoryGoodsListModelData> list) {
    childCategoryList = list;
    notifyListeners();
  }

  //添加页数
  addPage() {
    page++;
    notifyListeners();
  }

  //改变noMoreText数据
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }

  void getGoodList() {
    var data = {
      'categoryId': categoryId,
      'categorySubId': mallSubId,
      'page': page
    };
    LogUtil.v("=====>$page");
    getMallGoods(data).then((value) {
      var model = json.decode(value);
      CategoryGoodsListModelEntity categoryGoodsList =
          CategoryGoodsListModelEntity.fromJson(model);
      if (categoryGoodsList.data!=null) {
        if (page == 1) {
          childCategoryList = categoryGoodsList.data;
        } else {
          childCategoryList.addAll(categoryGoodsList.data);
        }
      } else {
        if(page>1){
          noMoreText = '没有更多数据';
          Fluttertoast.showToast(
              msg: '没有更多数据',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIos: 1,
              backgroundColor: Colors.pink,
              textColor: Colors.white,
              fontSize: 16.0);
        }else{
          childCategoryList = [];
        }

      }

      notifyListeners();
    });
  }
}

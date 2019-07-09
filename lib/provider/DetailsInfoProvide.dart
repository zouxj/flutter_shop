import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_shop/page/category/model/goods_details_entity.dart';
import 'package:flutter_shop/service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  GoodsDetailsEntity mGoodsDetailsEntity;

  getGoodsInfo(String id) {
    var formData = {
      'goodId': id,
    };
    getGoodsDetailById(formData).then((value) {
      mGoodsDetailsEntity =
          GoodsDetailsEntity.fromJson(json.decode(value.toString()));
      notifyListeners();
    });
  }

  bool isLeft = true;
  bool isRight = false;

  //左右状态点击
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
       isLeft = true;
       isRight = false;
    } else {
       isLeft = false;
       isRight = true;
    }
    notifyListeners();
  }
}

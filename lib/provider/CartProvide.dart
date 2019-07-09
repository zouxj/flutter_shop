import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_shop/page/cart/model/cart_info_mode_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModeEntity> cartList = [];

  //新代码----------start
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //商品总数量

  //添加购物车商品
  save(goodsId, goodsName, count, price, images, priceOriginal) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    var isHave = false;
    int ival = 0;
    allGoodsCount=0;
    allPrice=0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      if(item['isCheck']){
        allPrice+= (cartList[ival].price* cartList[ival].count);
        allGoodsCount+= cartList[ival].count;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'priceOriginal': priceOriginal,
        'images': images,
        'isCheck': true //是否已经选择
      };
      tempList.add(newGoods);
      cartList.add(new CartInfoModeEntity.fromJson(newGoods));
    }
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString); //进行持久化
    notifyListeners();
  }

  //移除商品
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    notifyListeners();
  }

  //获取商品列表
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        }
        cartList.add(new CartInfoModeEntity.fromJson(item));
      });
    }
    notifyListeners();
  }

  //添加商品
  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

//添加商品
  deleteOneGoods(goodsID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int deleteIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsID) {
        deleteIndex = tempIndex;
      }
      tempIndex++;
    });

    tempList.removeAt(deleteIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //更改选中状态
  changeCheckState(CartInfoModeEntity val) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //得到持久化的字符串
    List<Map> tempList = (json.decode(cartString.toString()) as List)
        .cast(); //声明临时List，用于循环，找到修改项的索引
    int tempIndex = 0; //循环使用索引
    int changeIndex = 0; //需要修改的索引
    tempList.forEach((item) {
      if (item['goodsId'] == val.goodsId) {
        //找到索引进行复制
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = val.toJson(); //把对象变成Map值
    cartString = json.encode(tempList).toString(); //变成字符串
    prefs.setString('cartInfo', cartString); //进行持久化
    await getCartInfo(); //重新读取列表
  }
}

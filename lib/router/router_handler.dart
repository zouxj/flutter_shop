import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/page/category/DetailsShopPage.dart';

Handler shopDetailsPageHandler = new Handler(
    // ignore: non_constant_identifier_names
  handlerFunc: (BuildContext build, Map<String, List<String>> params) {
  String goodsID = params['id'].first;
  return ShopDetailsPage(goodsID);
});


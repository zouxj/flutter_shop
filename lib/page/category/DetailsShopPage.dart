import 'package:flutter/material.dart';
import 'package:flutter_shop/page/category/DetailsBottom.dart';
import 'package:flutter_shop/page/category/DetailsWeb.dart';
import 'package:flutter_shop/provider/DetailsInfoProvide.dart';
import 'package:provide/provide.dart';

import 'DetailsExplain.dart';
import 'DetailsTabBar.dart';
import 'DetailsTopArea.dart';

class ShopDetailsPage extends StatelessWidget {
  final String goodID;

  const ShopDetailsPage(this.goodID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text('商品详情'),
      ),
      body: FutureBuilder(
          future: getGoodsDateils(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Stack(
                children: <Widget>[
                  ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabBar(),
                      DetailsWeb()
                    ],
                  ),
                  Positioned(bottom: 0, left: 0, child: DetailsBottom())
                ],
              );
            } else {
              return Text('暂无数据');
            }
          }),
    );
  }

  Future getGoodsDateils(BuildContext context) async {
    await Provide.value<DetailsInfoProvide>(context).getGoodsInfo(goodID);
    return '完成加载';
  }
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_shop/page/cart/CartPage.dart';
import 'package:flutter_shop/page/category/CategoryPage.dart';
import 'package:flutter_shop/page/home/HomePage.dart';
import 'package:flutter_shop/page/member/MemberPage.dart';
import 'package:flutter_shop/provider/ChangeIndexProvide.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:provide/provide.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.home),
      title: Text("首页"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.search),
      title: Text("分类"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.shopping_cart),
      title: Text("购物车"),
    ),
    BottomNavigationBarItem(
      icon: Icon(CupertinoIcons.profile_circled),
      title: Text("会员中心"),
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    ScreenInit(context);
    return Provide<ChangeIndexProvide>(builder: (context, child, scape) {
      currentIndex = scape.indexChange;
      return Scaffold(
        backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
        bottomNavigationBar: BottomNavigationBar(
          items: bottomTabs,
          currentIndex: currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            Provide.value<ChangeIndexProvide>(context).changeIndex(index);
          },
        ),
        body: IndexedStack(index: currentIndex, children: tabBodies),
      );
    });
  }
}

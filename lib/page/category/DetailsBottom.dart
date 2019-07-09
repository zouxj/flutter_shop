import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/CartProvide.dart';
import 'package:flutter_shop/provider/ChangeIndexProvide.dart';
import 'package:flutter_shop/provider/DetailsInfoProvide.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:provide/provide.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: adapterPixel(750),
      height: adapterPixel(110),
      alignment: Alignment.bottomCenter,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Provide.value<ChangeIndexProvide>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: adapterPixel(110),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
              ),
              Provide<CartProvide>(
                builder: (context, child, val) {
                  int goodsCount =val.allGoodsCount;
                  return Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                          color: Colors.pink,
                          shape: BoxShape.circle),
                      child: Text('${goodsCount}',
                          style: TextStyle(color: Colors.white, fontSize: adapterPixel(22))),
                    ),
                  );
                },
              )
            ],
          ),
          InkWell(
            onTap: () async {
              var goodsInfo = Provide.value<DetailsInfoProvide>(context)
                  .mGoodsDetailsEntity
                  .data
                  .goodInfo;
              var goodsId = goodsInfo.goodsId;
              var goodsName = goodsInfo.goodsName;
              var count = 1;
              var price = goodsInfo.presentPrice;
              var images = goodsInfo.image1;
              var oriPrice = goodsInfo.oriPrice;
              await Provide.value<CartProvide>(context)
                  .save(goodsId, goodsName, count, price, images, oriPrice);
            },
            child: Container(
              alignment: Alignment.center,
              width: adapterPixel(320),
              height: adapterPixel(100),
              color: Colors.green,
              child: Text(
                '加入购物车',
                style:
                    TextStyle(color: Colors.white, fontSize: adapterPixel(28)),
              ),
            ),
          ),
          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: adapterPixel(320),
              height: adapterPixel(100),
              color: Colors.red,
              child: Text(
                '马上购买',
                style:
                    TextStyle(color: Colors.white, fontSize: adapterPixel(28)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

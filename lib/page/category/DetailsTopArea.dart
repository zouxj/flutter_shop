import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_shop/provider/DetailsInfoProvide.dart';
import 'package:flutter_shop/utils/LogUtil.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:provide/provide.dart';

import 'model/goods_details_entity.dart';

class DetailsTopArea extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Provide<DetailsInfoProvide>(builder: (context,child,val){
      if(null!=val&&val.mGoodsDetailsEntity!=null){
        GoodsDetailsDataGoodinfo goods=val.mGoodsDetailsEntity.data.goodInfo;
        return Container(color: Colors.white, child: Column(children: <Widget>[
          _goodsImage(goods.image1),
          _goodsName(goods.goodsName),
          _goodsNum(goods.goodsSerialNumber),
          _goodssPrice(goods.presentPrice, goods.oriPrice)
        ],));
      }else{
        return Text('暂无数据');
      }

    });
  }

  //顶部图片
  Widget _goodsImage(url) {
    return Image.network(url,width: adapterPixel(740));
  }
  //商品名字
  Widget _goodsName(name){
    return Container(width: adapterPixel(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(name,maxLines: 1,style: TextStyle(fontSize: adapterPixel(30))),
    );
  }
  //商品编号
  Widget _goodsNum(num){
    return Container(
      width: adapterPixel(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text('编号:${num}',maxLines: 1,style: TextStyle(color: Colors.black26)),
    );
  }
  //价格方法
  Widget _goodssPrice(presentPrice,oriPrice){
    return Container(
      width: adapterPixel(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(children: <Widget>[
        Text('￥${presentPrice}',style: TextStyle(color: Colors.pinkAccent,fontSize: adapterPixel(40)),)
        ,Text('市场价${oriPrice}',style: TextStyle(color: Colors.black26,decoration: TextDecoration.lineThrough),)
      ],),
    );
  }

}

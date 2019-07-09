import 'package:flutter/material.dart';
import 'package:flutter_shop/page/cart/CartCount.dart';
import 'package:flutter_shop/page/cart/model/cart_info_mode_entity.dart';
import 'package:flutter_shop/provider/CartProvide.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:provide/provide.dart';

class CartItem extends StatelessWidget {
  final CartInfoModeEntity cartInfoModeEntity;

  const CartItem(this.cartInfoModeEntity);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: adapterPixel(220),
      width: adapterPixel(750),
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 10.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Colors.black12))),
            child: Row(
              children: <Widget>[
                _cartCheckBt(context),
                _cartImage(),
                _cartGoodsName(),
                _cartPrice(context)
              ],
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text('共${Provide.value<CartProvide>(context).allGoodsCount}件商品', style: TextStyle(fontSize: adapterPixel(20)),
              ),
              Text( '小计￥:${Provide.value<CartProvide>(context).allPrice}', style: TextStyle(fontSize: adapterPixel(20),color: Colors.pink))],
          ),
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBt(context) {
    return Container(
      child: Checkbox(
        value: cartInfoModeEntity.isCheck,
        onChanged: (bool val) {
          cartInfoModeEntity.isCheck = val;
          Provide.value<CartProvide>(context)
              .changeCheckState(cartInfoModeEntity);
        },
        activeColor: Colors.pink,
      ),
    );
  }

  //商品图片
  Widget _cartImage() {
    return Container(
      width: adapterPixel(150),
      padding: EdgeInsets.all(3.0),
      decoration:
          BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Image.network(cartInfoModeEntity.images),
    );
  }

  //商品名称
  Widget _cartGoodsName() {
    return Container(
      width: adapterPixel(300),
      child: Column(
        children: <Widget>[
          Text(cartInfoModeEntity.goodsName,
              style: TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis),
          CartCount(cartInfoModeEntity)
        ],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(context) {
    return Container(
      width: adapterPixel(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${cartInfoModeEntity.price}'),
          Text(
            '￥${cartInfoModeEntity.priceOriginal}',
            style: TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 8,
                color: Colors.grey),
          ),
          Container(
              child: InkWell(
            onTap: () {
              //删除商品
              Provide.value<CartProvide>(context)
                  .deleteOneGoods(cartInfoModeEntity.goodsId);
            },
            child: Icon(
              Icons.delete_outline,
              color: Colors.black26,
              size: 30,
            ),
          )),
        ],
      ),
    );
  }
}

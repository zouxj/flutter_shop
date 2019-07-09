import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/CartProvide.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:provide/provide.dart';

class CartBottom extends StatelessWidget {
  var allPrice;
  var allCount;

  @override
  Widget build(BuildContext context) {
    return Provide<CartProvide>(
      builder: (context, child, scope) {
        allPrice = scope.allPrice;
        allCount = scope.allGoodsCount;
        return Container(
          margin: EdgeInsets.all(5.0),
          color: Colors.white,
          width: adapterPixel(750),
          height: adapterPixel(120),
          child: Row(
            children: <Widget>[_selectAllBtn(context)],
          ),
        );
      },
    );
  }

  //全选按钮
  Widget _selectAllBtn(context) {
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: true,
            activeColor: Colors.pink,
            onChanged: (bool val) {},
          ),
          Text("全选按"),
          _allPriceArea(context),
          goButton()
        ],
      ),
    );
  }

  //合计按钮
  Widget _allPriceArea(context) {
    return Container(
        width: adapterPixel(260),
        alignment: Alignment.centerRight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RichText(
              text: TextSpan(children: <TextSpan>[
                TextSpan(
                    text: '合计：',
                    style: TextStyle(
                        color: Colors.black, fontSize: adapterPixel(30))),
                TextSpan(
                    text: '￥${allPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                        color: Colors.red, fontSize: adapterPixel(30)))
              ]),
            ),
            Text('满10元免配送费,预购免配送费',
                style: TextStyle(fontSize: adapterPixel(15))),
          ],
        ));
  }

  Widget goButton() {
    return Container(
      margin: EdgeInsets.only(left: adapterPixel(100)),
      alignment: Alignment.centerRight,
      width: adapterPixel(160),
      height: adapterPixel(80),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(3.0)),
          child: Text(
            '结算(${allCount})',
            style: TextStyle(color: Colors.white, fontSize: adapterPixel(20)),
          ),
        ),
      ),
    );
  }
}

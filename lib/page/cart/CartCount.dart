import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/CartProvide.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:path/path.dart';
import 'package:provide/provide.dart';

class CartCount extends StatelessWidget {
  var item;

  CartCount(this.item) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: adapterPixel(165),
      height: adapterPixel(45),
      margin: EdgeInsets.only(top: 10.0),
      decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.black12)),
      child: Row(
        children: <Widget>[_reduceBtn(context), _countArea(), _addBtn(context)],
      ),
    );
  }

  //减少按钮
  Widget _reduceBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item,'reduce');
      },
      child: Container(
        width: adapterPixel(45),
        height: adapterPixel(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count > 1 ? Colors.white : Colors.black12,
            border: Border(right: BorderSide(width: 1, color: Colors.black12))),
        child: item.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  //添加按钮
  Widget _addBtn(context) {
    return InkWell(
      onTap: () {
        Provide.value<CartProvide>(context).addOrReduceAction(item, "add");
      },
      child: Container(
        width: adapterPixel(45),
        height: adapterPixel(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: item.count > 1 ? Colors.white : Colors.black12,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Text('+'),
      ),
    );
  }

  //中间数量显示区域
  Widget _countArea() {
    return Container(
      width: adapterPixel(70),
      height: adapterPixel(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}

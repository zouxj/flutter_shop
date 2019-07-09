import 'package:flutter/material.dart';
import 'package:flutter_shop/provider/DetailsInfoProvide.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:provide/provide.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(builder: (context,child,val){
      if(val!=null){
        var isLeft=val.isLeft;
        var isRight =val.isRight;
        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(children: <Widget>[
            _leftBarTab(context, isLeft),
            _rightBarTab(context, isRight)
          ],),
        );
      }
    },
    );
  }

  Widget _leftBarTab(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: adapterPixel(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: isLeft ? Colors.pink : Colors.black12))),
        child: Text(
          '详情',
          style: TextStyle(color: isLeft ? Colors.pink : Colors.black12),
        ),
      ),
    );
  }

  Widget _rightBarTab(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provide.value<DetailsInfoProvide>(context).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: adapterPixel(375),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(bottom: BorderSide(
                    width: 1, color: isRight ? Colors.pink : Colors.black12))),
        child: Text('评论',
          style: TextStyle(color: isRight ? Colors.pink : Colors.black12),
        ),
      ),
    );
  }
}

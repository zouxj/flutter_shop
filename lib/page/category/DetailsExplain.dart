
import 'package:flutter/material.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';

class DetailsExplain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top:adapterPixel(10)),
      width: adapterPixel(750),
      padding: EdgeInsets.all(10.0),
      child: Text('说明：> 急速送达 > 正品保证',style: TextStyle(color: Colors.red,fontSize: adapterPixel(30))),
    );
  }
}

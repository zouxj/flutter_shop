
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_shop/provider/DetailsInfoProvide.dart';
import 'package:provide/provide.dart';
import 'package:flutter_shop/utils/ScreenUtil.dart';

class DetailsWeb extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return Provide<DetailsInfoProvide>(builder: (context,child,val){
      if(val.isLeft&&val.mGoodsDetailsEntity!=null){
        return Container(
          child: Html(
            data: val.mGoodsDetailsEntity.data.goodInfo.goodsDetail
          ),
        );
      }else{
        return Container(
          width: adapterPixel(750),
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text("暂无数据..."),
        );
      }
   });
  }


}

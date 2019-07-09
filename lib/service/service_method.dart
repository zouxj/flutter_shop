import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_shop/config/service_url.dart';
import 'package:flutter_shop/utils/LogUtil.dart';

//获取首页主题数据
Future getHomePageContent() async {
  var formData = {'lon': '115.02932', 'lat': '35.76189'};
 return request(servicePath['homePageContent'], formData);
}
//请求总入口
Future request(url, formData) async {
  try {
    Response response;
    Dio dio = Dio();
    dio.options.contentType =
        ContentType.parse("application/x-www-form-urlencoded");
    if (null != formData)
      response = await dio.post(url, data: formData);
    else
      response = await dio.post(servicePath['homePageContent']);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常，请检测代码和服务器情况.........');
    }
  } catch (e) {
    return LogUtil.e('ERROR:======>${e}');
  }
}
//获取首页火爆数据
Future gethomePageBelowConten(formData) async {
  return request(servicePath['homePageBelowConten'], formData);
}

//获取首页火爆分列数据
Future getCategory() async {
  return request(servicePath['getCategory'], {});
}
//商品列表
Future getMallGoods(formData) async {
  return request(servicePath['getMallGoods'], formData);
}
//商品详情
Future getGoodsDetailById(formData) async {
  return request(servicePath['getGoodDetailById'], formData);
}
import 'package:flutter/material.dart';
import 'package:flutter_shop/utils/LogUtil.dart';

double width = 750;
double height = 1333;
MediaQueryData _mediaQueryData;
double _screenWidth;

void ScreenInit(BuildContext context) {
  MediaQueryData mediaQuery = MediaQuery.of(context);
  _mediaQueryData = mediaQuery;
  _screenWidth = mediaQuery.size.width;
}

///实际的dp与设计稿px的比例
get scaleWidth => _screenWidth / width;

adapterPixel(double px) => px * scaleWidth;

setSp(double fontSize) => fontSize * scaleWidth;

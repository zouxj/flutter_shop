import 'package:flutter_shop/page/cart/model/cart_info_mode_entity.dart';
import 'package:flutter_shop/page/category/model/category_goods_list_model_entity.dart';
import 'package:flutter_shop/page/category/model/category_page_model_entity.dart';
import 'package:flutter_shop/page/category/model/goods_details_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "CartInfoModeEntity") {
      return CartInfoModeEntity.fromJson(json) as T;
    } else if (T.toString() == "CategoryGoodsListModelEntity") {
      return CategoryGoodsListModelEntity.fromJson(json) as T;
    } else if (T.toString() == "CategoryEntity") {
      return CategoryEntity.fromJson(json) as T;
    } else if (T.toString() == "GoodsDetailsEntity") {
      return GoodsDetailsEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}
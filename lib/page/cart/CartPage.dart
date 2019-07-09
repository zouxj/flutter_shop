import 'package:flutter/material.dart';
import 'package:flutter_shop/page/cart/CartBottom.dart';
import 'package:flutter_shop/page/cart/CartItem.dart';
import 'package:flutter_shop/provider/CartProvide.dart';
import 'package:flutter_shop/utils/Counter.dart';
import 'package:provide/provide.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('购物车')),
        body: FutureBuilder(
            future: _getCartInfo(context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    Provide<CartProvide>(
                      builder: (context, child, val) {
                        List cartList = val.cartList;
                        return ListView.builder(
                            itemCount: cartList.length,
                            itemBuilder: (context, index) {
                              return CartItem(cartList[index]);
                            });
                      },
                    ),
                    Positioned(
                      left: 0,
                      bottom: 0,
                      child: CartBottom(),
                    )
                  ],
                );
              } else {
                return Text('正在加载...');
              }
            }));
  }

  Future<String> _getCartInfo(BuildContext context) async {
    await Provide.value<CartProvide>(context).getCartInfo();
    return 'end';
  }
}

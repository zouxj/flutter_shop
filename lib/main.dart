import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_shop/Application.dart';
import 'package:flutter_shop/provider/CartProvide.dart';
import 'package:flutter_shop/provider/ChangeIndexProvide.dart';
import 'package:flutter_shop/provider/DetailsInfoProvide.dart';
import 'package:flutter_shop/router/Routes.dart';
import 'package:flutter_shop/utils/Counter.dart';
import 'provider/ChildCategoryProvider.dart';
import 'page/home/IndexPage.dart';
import 'package:provide/provide.dart';

void main() {

  var provides=Providers();
  Application.router=Router();
  Routes.configureRoutes(Application.router);
  provides.provide(Provider<Counter>.value(Counter()));
  provides.provide(Provider<ChildCategory>.value(ChildCategory()));
  provides.provide(Provider<DetailsInfoProvide>.value(DetailsInfoProvide()));
  provides.provide(Provider<CartProvide>.value(CartProvide()));
  provides.provide(Provider<ChangeIndexProvide>.value(ChangeIndexProvide()));

  runApp( ProviderNode(child: MyApp(),providers: provides));

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: "百姓生活+",

        onGenerateRoute: Application.router.generator,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primaryColor: Colors.pink),
        home: IndexPage(),
      ),
    );
  }
}

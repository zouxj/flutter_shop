import 'package:flutter/material.dart';
import 'package:flutter_shop/service/service_method.dart';
import 'package:flutter_shop/utils/LogUtil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:flutter_shop/utils/ScreenUtil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

List<Map> goodsList = [];

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  String homePageContent = "正在获取数据...";
  GlobalKey<RefreshFooterState> _footerKey =
      new GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    getHomePageContent().then((value) {
      setState(() {
        homePageContent = value.toString();
      });
    });
    super.initState();
  }

  int page = 0;

  void _getHotGoods() {
    var forPage = {'page', page};
    gethomePageBelowConten(forPage).then((onValue) {
      var data = json.decode(onValue.toString());
      List<Map> newGoodsList = (data['data'] as List).cast();
      print(onValue);
      setState(() {
        goodsList.addAll(newGoodsList);
        page++;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("百姓生活+"),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiperDataList = (data['data']['slides'] as List).cast();
            List<Map> navgatorList = (data['data']['category'] as List).cast();
            String advertesPicture =
                data['data']['advertesPicture']['PICTURE_ADDRESS']; //广告图片
            if (navgatorList.length > 10) {
              navgatorList.removeRange(10, navgatorList.length);
            }
            String leaderImage = data['data']['shopInfo']['leaderImage']; //店长图片
            String leaderPhone = data['data']['shopInfo']['leaderPhone']; //店长电话
            List<Map> recommendList =
                (data['data']['recommend'] as List).cast(); // 商品推荐

            String floor1Title =
                data['data']['floor1Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            String floor2Title =
                data['data']['floor2Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            String floor3Title =
                data['data']['floor3Pic']['PICTURE_ADDRESS']; //楼层1的标题图片
            List<Map> floor1 =
                (data['data']['floor1'] as List).cast(); //楼层1商品和图片
            List<Map> floor2 =
                (data['data']['floor2'] as List).cast(); //楼层1商品和图片
            List<Map> floor3 =
                (data['data']['floor3'] as List).cast(); //楼层1商品和图片

            return EasyRefresh(
              refreshFooter: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  moreInfoColor: Colors.pink,
                  showMore: true,
                  noMoreText: '',
                  moreInfo: '加载中',
                  loadReadyText: '上拉加载....'),
              child: ListView(
                //cacheExtent: 500.0,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SwiperDiy(swiperDataList: swiperDataList),
                      TopNavigator(navgatorList: navgatorList),
                      AdBanner(imageUrl: advertesPicture),
                      LeaderPhone(
                          leaderPhone: leaderPhone, leaderImg: leaderImage),
                      Recommend(recommendList: recommendList),
                      FloorTitle(imgUrl: floor1Title),
                      FloorContent(floorGoodsList: floor1),
                      FloorTitle(imgUrl: floor2Title),
                      FloorContent(floorGoodsList: floor2),
                      FloorTitle(imgUrl: floor3Title),
                      FloorContent(floorGoodsList: floor3),
                      GoodsHot()
                    ],
                  )
                ],
              ),
              loadMore: () async {
                _getHotGoods();
              },
            );
          } else {
            return Center(
              child: Text('加载中'),
            );
          }
        },
      ),
    );
  }
}

class SwiperDiy extends StatelessWidget {
  final List swiperDataList;

  SwiperDiy({Key key, this.swiperDataList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: adapterPixel(333),
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            return Image.network("${swiperDataList[index]['image']}",
                fit: BoxFit.fill);
          },
          itemCount: swiperDataList.length,
          pagination: SwiperPagination(),
          autoplay: true,
        ));
  }
}

//顶部导航
class TopNavigator extends StatelessWidget {
  final List navgatorList;

  const TopNavigator({Key key, this.navgatorList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(

        height: adapterPixel(305),
        padding: EdgeInsets.all(3.0),
        child: GridView.count(
          crossAxisCount: 5,
          physics: NeverScrollableScrollPhysics(),
          padding: EdgeInsets.all(4.0),
          children: navgatorList.map((item) {
            return __gridViewItemUI(context, item);
          }).toList(),
        ));
  }

  Widget __gridViewItemUI(BuildContext context, item) {
    return InkWell(
      onTap: () {
        LogUtil.v("点击导航栏");
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: adapterPixel(95)),
          Text(item['mallCategoryName'])
        ],
      ),
    );
  }
}

//广告栏
class AdBanner extends StatelessWidget {
  final String imageUrl;

  const AdBanner({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: 100,
      child: Image.network(imageUrl),
    );
  }
}

//电话模块
class LeaderPhone extends StatelessWidget {
  final String leaderPhone; //电话
  final String leaderImg; //图片
  const LeaderPhone({Key key, this.leaderPhone, this.leaderImg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return InkWell(
      onTap: () {
        _launchURL();
      },
      child: Image.network(leaderImg),
    );
  }

//拨打电话
  _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

//商品推荐
class Recommend extends StatelessWidget {

  final List recommendList;
  const Recommend({Key key, this.recommendList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      height: adapterPixel(400),
      margin: EdgeInsets.only(top: 10.0),
      child: Column(
        children: <Widget>[_titleWidget(), _recommedList()],
      ),
    );
  }

//横向列表
  Widget _recommedList() {
    return Container(
      height: adapterPixel(340),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: recommendList.length,
          itemBuilder: (context, index) {
            return _item(index);
          }),
    );
  }

  //标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
    );
  }

  //商品单独项方法
  Widget _item(index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: adapterPixel(330),
        width: adapterPixel(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 0.5, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(recommendList[index]['image']),
            Text('￥${recommendList[index]['mallPrice']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }
}

//楼层商品标题
class FloorTitle extends StatelessWidget {
  final String imgUrl;

  const FloorTitle({Key key, this.imgUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Image.network(imgUrl),
    );
  }
}

//楼层商品列表
class FloorContent extends StatelessWidget {
  final List floorGoodsList;

  const FloorContent({Key key, this.floorGoodsList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Column(
        children: <Widget>[_firstRow(), _otherGoods()],
      ),
    );
  }

  Widget _googsItem(Map googds) {
    return Container(
      width: adapterPixel(375),
      child: InkWell(
        onTap: () {},
        child: Image.network(googds['image']),
      ),
    );
  }

  Widget _firstRow() {
    return Row(
      children: <Widget>[
        _googsItem(floorGoodsList[0]),
        Column(
          children: <Widget>[
            _googsItem(floorGoodsList[1]),
            _googsItem(floorGoodsList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods() {
    return Row(
      children: <Widget>[
        _googsItem(floorGoodsList[3]),
        _googsItem(floorGoodsList[4]),
      ],
    );
  }
}

class GoodsHot extends StatefulWidget {
  @override
  _GoodsHotState createState() => _GoodsHotState();
}

class _GoodsHotState extends State<GoodsHot> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[_HotGoodsTitle(), _wrapList()],
    );
  }

  //火爆专区的标题
  Widget _HotGoodsTitle() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 0.5, color: Colors.black12))),
      child: Text('火爆专区'),
    );
  }

  //火爆专区的子项
  Widget _wrapList() {
    if (goodsList.length > 0) {
      List<Widget> listWidget = goodsList.map((val) {
        return InkWell(
          onTap: () {},
          child: Container(
            width: adapterPixel(372),
            color: Colors.white,
            padding: EdgeInsets.all(5.0),
            margin: EdgeInsets.only(bottom: 3.0),
            child: Column(
              children: <Widget>[
                Image.network(
                  val['image'],
                  width: adapterPixel(375),
                ),
                Text(
                  val['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style:
                      TextStyle(color: Colors.pink, fontSize: adapterPixel(26)),
                ),
                Row(
                  children: <Widget>[
                    Text('￥${val['mallPrice']}'),
                    Text(
                      '￥${val['price']}',
                      style: TextStyle(
                          color: Colors.black26,
                          decoration: TextDecoration.lineThrough),
                    )
                  ],
                )
              ],
            ),
          ),
        );
      }).toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }
}

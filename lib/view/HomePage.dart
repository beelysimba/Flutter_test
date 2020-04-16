import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../request/requestManager.dart';
import '../request/global_config.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> sectionlist = [];
  var homedata;
  var sentence;
  List<Map<String, dynamic>> entrance;
  List<Map<String, dynamic>> list;
  ScrollController _controler = new ScrollController();
  EasyRefreshController refresh = new EasyRefreshController();
  final GlobalKey listKey = GlobalKey();
  bool isload = false;

  Future getHomeData() async {
    try {
      Response response;
      response =
          await DioManager.getInstance().get(GlobalConfig.APP_HOME, null);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('request failed');
      }
    } catch (e) {
      print('Error--$e');
    }
    // try {
    //   Response section;
    //   section = await DioManager.getInstance().get(GlobalConfig.HOT_SECTION, {
    //     'count': 20,
    //     'cursor': sectionlist.length > 0 ? sectionlist.length : 0
    //   });
    //   if (section.statusCode == 200) {
    //     return section.data;
    //   } else {
    //     throw Exception('request failed');
    //   }
    // } catch (e) {
    //   print('Error--$e');
    // }
  }

  EasyRefresh easyRefresh(var homedata) {
    var data = json.decode(homedata);
    list = (data[0]['list'] as List).cast();
    entrance = (data[1]['list'] as List).cast();
    List datalist = data;
    for (var item in datalist) {
      String category = item['category'];
      if (category == 'quotes') {
        sentence = item['list'][0];
      }
    }

    return EasyRefresh(
        controller: refresh,
        bottomBouncing: false,
        child: ListView(
          key: listKey,
          controller: _controler,
          children: <Widget>[
            list != null ? HomeBanner(list: list) : Divider(),
            entrance != null ? Entrance(list: entrance) : Divider(),
            sentence != null ? DailySentence(sentence) : Divider(),
            sectionlist != null ? SectionVideo(list: sectionlist) : Divider(),
          ],
        ),
        onLoad: () async {
          await DioManager.getInstance().get(GlobalConfig.HOT_SECTION, {
            'count': 20,
            'cursor': sectionlist.length > 0 ? sectionlist.length : 0
          }).then((result) {
            var data = json.decode(result.data.toString());
            List<Map<String, dynamic>> list = (data['list'] as List).cast();
            isload = false;
            setState(() {
              sectionlist.addAll(list);
            });
          });
        });
  }

  @override
  void initState() {
    getHomeData().then((result) {
      setState(() {
        homedata = result.toString();
      });
    });
    // _controler.addListener(() {
    //   // double height = listKey.currentContext.size.height;
    //   double height = MediaQuery.of(context).size.height;
    //   if (_controler.offset > (height-30) && !isload) {
    //     isload = true;
    //     // final double off = _controler.offset + 10;
    //             print('request it $height');

    //       refresh.callLoad();
    //       // _controler.animateTo(off,
    //       //     duration: Duration(seconds: 2), curve: Curves.bounceIn);

    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: (homedata != null)
          ? easyRefresh(homedata)
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class HomePage1 extends StatelessWidget {
  List<Map<String, dynamic>> list = [];

  ScrollController controler = new ScrollController();
  // controler

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: SingleChildScrollView(
            controller: controler,
            child: Column(
              children: <Widget>[
                FutureBuilder(
                    future: DioManager.getInstance()
                        .get(GlobalConfig.APP_HOME, null),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done &&
                          snapshot.hasData) {
                        Response response = snapshot.data;
                        var data = json.decode(response.data.toString());
                        List<Map> list = (data[0]['list'] as List).cast();
                        List<Map<String, dynamic>> entrance =
                            (data[1]['list'] as List).cast();
                        List datalist = data;
                        var sentence;
                        for (var item in datalist) {
                          String category = item['category'];
                          print('---$category');
                          if (category == 'quotes') {
                            sentence = item['list'][0];
                          }
                        }
                        return Column(
                          children: <Widget>[
                            Container(
                              margin:
                                  EdgeInsets.only(left: 15, right: 15, top: 15),
                              height: 162,
                              child: Swiper(
                                itemBuilder: (BuildContext context, int index) {
                                  var banner = list[index];
                                  return ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Image.network(
                                      banner['thumbnail']['720x405'],
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                                itemCount: 3,
                                pagination: SwiperPagination(),
                                autoplay: true,
                              ),
                            ),
                            Entrance(list: entrance),
                            sentence != null
                                ? DailySentence(sentence)
                                : Divider(),
                          ],
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          semanticsLabel: 'loading、、、',
                        ),
                      );
                    }),
                FutureBuilder(
                  future: DioManager.getInstance().get(GlobalConfig.HOT_SECTION,
                      {'count': 20, 'cursor': list.length}),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      Response response = snapshot.data;
                      var data = json.decode(response.data.toString());
                      List list = data['list'];
                      return SectionVideo(list: list);
                    }
                    return Divider();
                  },
                ),
              ],
            )));
  }
}

class HomeBanner extends StatelessWidget {
  List<Map<String, dynamic>> list = [];
  HomeBanner({List<Map<String, dynamic>> list})
      : list = list ?? <Map<String, dynamic>>[];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
        height: 162,
        child: Swiper(
          itemBuilder: (BuildContext context, int index) {
            var banner = list[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.network(
                banner['thumbnail']['720x405'],
                fit: BoxFit.cover,
              ),
            );
          },
          itemCount: list.length,
          pagination: SwiperPagination(),
          autoplay: true,
        ),
      ),
    );
  }
}

class Entrance extends StatelessWidget {
  List<Map<String, dynamic>> list = [];
  Entrance({List<Map<String, dynamic>> list})
      : list = list ?? <Map<String, dynamic>>[];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    final Iterable<GestureDetector> tiles = list.map(
      (Map<String, dynamic> pair) {
        double itemWidth = max(width / 5.0, width / list.length);
        return GestureDetector(
          child: Container(
            width: itemWidth,
            margin: EdgeInsets.only(top: 15),
            child: Column(
              children: <Widget>[
                Image.network(
                  pair['thumbnail']['65x67'],
                  width: 40,
                  fit: BoxFit.fitWidth,
                ),
                Text(pair['title'], style: TextStyle(fontSize: 13)),
              ],
            ),
          ),
          onTap: () => print('${pair['title']}}'),
        );
      },
    );
    final List<Widget> divided = tiles.toList();
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(
        left: 15,
        right: 15,
      ),
      height: 90,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: divided,
      ),
    );
  }
}

class DailySentence extends StatelessWidget {
  Map<String, dynamic> section;
  DailySentence(this.section);
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width - 30;
    return Column(
      children: <Widget>[
        Container(
          height: 0.5,
          color: Colors.black12,
        ),
        Container(
          height: width / 16 * 9 + 60,
          margin: EdgeInsets.only(left: 15.0, right: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 14),
              Text(
                '每日一句',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 10),
              Image.network(section['thumbnail']['file']),
              SizedBox(height: 10),
            ],
          ),
        ),
      ],
    );
  }
}

class SectionVideo extends StatelessWidget {
  List list = [];
  SectionVideo({List list}) : list = list ?? [];

  @override
  Widget build(BuildContext context) {
    double width = (MediaQuery.of(context).size.width - 40) / 2.0;
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 10,
            color: Colors.black12,
          ),
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 15, top: 14),
            child: Text('精选视频', style: TextStyle(fontSize: 18)),
          ),
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: list.length,
              padding: EdgeInsets.all(8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.5,
              ),
              itemBuilder: (context, i) {
                var model = list[i];
                var thumb = list[i]['thumbnail'];
                return GestureDetector(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Image.network(
                          thumb['260x160'],
                          fit: BoxFit.fitWidth,
                        ),
                        Text(
                          model['name'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  onTap: () => print('click item ${model['name']}'),
                );
              })
        ]);
  }
}

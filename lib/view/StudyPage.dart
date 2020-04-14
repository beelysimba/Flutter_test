import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../request/requestManager.dart';
import '../request/global_config.dart';
import '../model/course_model.dart';

class StudyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextStyle tabTextStyle = TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.bold,
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: TabBar(
              indicatorSize: TabBarIndicatorSize.label,
              labelPadding: EdgeInsets.only(top: 10),
              labelStyle: tabTextStyle,
              tabs: <Widget>[
                Tab(
                    child: Text(
                  "Course",
                )),
                Tab(
                    child: Text(
                  "Programme",
                  style: tabTextStyle,
                )),
              ]),
        ),

        body: TabBarView(children: <Widget>[
          StudyPageCourse(),
          StudyPageProgramme(),
        ]),
      ),
    );
  }
}

//course
class StudyPageCourse extends StatefulWidget {
  StudyPageCourse({Key key}) : super(key: key);
  @override
  _StudyPageCourseState createState() => _StudyPageCourseState();
}

class _StudyPageCourseState extends State<StudyPageCourse> {
  List<CourseProject> courselist = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buildCourseList(List<Course> list) {
      final Iterable<GestureDetector> tiles = list.map(
        (Course course) {
          return GestureDetector(
           child: Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(10),
                  child: Image.network(course.thumbnail.first.file,width: 100, height: 126),
                ),
                Container(
                  padding: EdgeInsets.only(bottom:50),
                  child: Text(course.name,style: TextStyle(fontSize: 18.0,),),
                ),
              ],
            ),
            onTap: () => print('click row ${course.name}'),
           );
        });
      
      final List<Widget> divided = ListTile.divideTiles(context: context, tiles: tiles, color: Colors.blueGrey).toList();
      return Wrap(
        children: divided,
      );
    }

    return Container(
      child: FutureBuilder(
        future: DioManager.getInstance().get(GlobalConfig.ALL_COURSE, null),
        initialData: courselist,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          //请求完成
          if (snapshot.connectionState == ConnectionState.done) {
            Response response = snapshot.data;

            // String dataStr = json.encode(response.data).toString();
            var data = json.decode(response.data.toString());
            List<Map> list = (data['list'] as List).cast();
            for (var item in list) {
              CourseProject model = CourseProject.fromJson(item);
              courselist.add(model);
            }

            //发生错误
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            //请求成功，通过项目信息构建用于显示项目名称的ListView
            return ListView.separated(
              itemBuilder: (context,i) {
                if (i==0) {
                  return Divider();
                }
                List<Course> list = courselist[i-1].courses;
                return _buildCourseList(list);
              }, 
              separatorBuilder: (context,i) {
                if (i>=courselist.length) {
                  return Divider();
                }
                return Container(
                 margin: EdgeInsets.only(top:10,left: 15,bottom: 10), 
                 child: Text(courselist[i].title, style: TextStyle(fontSize: 22.0,)),
                );
              },  
              itemCount: courselist.length+1
              );
          }
          //请求未完成时弹出loading
          return Center(
            child: CircularProgressIndicator(
              semanticsLabel: 'loading、、、',
            ),
          );
        },
      ),
    );
  }
}

//programme
class StudyPageProgramme extends StatefulWidget {
  @override
  _StudyPageProgrammeState createState() => _StudyPageProgrammeState();
}

class _StudyPageProgrammeState extends State<StudyPageProgramme> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
   //collectionView with list
    List<Widget> _makeupMovie(List<Map<String, dynamic>> list) {
      final Iterable<GestureDetector> tiles = list.map(
        (Map pair) {
          var thumbs = pair['thumbnail'][0];
          double ratio = MediaQuery.of(context).devicePixelRatio;
          double width = (MediaQuery.of(context).size.width-30/ratio)/3.0;
          return GestureDetector(
            child: Container(
               padding: EdgeInsets.only(top:10,left: 10,bottom: 0),
                width: width,
                height: width/2*3+20,
                child: Column(
                  children:<Widget>[
                  Image.network(thumbs['file'],fit: BoxFit.fitWidth,),
                  Text(pair['title'],maxLines: 1, ),
                ],
                ),
              ),
            onTap: () => print('click item ${pair['title']}'),
          );
        },
      );
      return tiles.toList();
    }

   Widget _makeupLevel(Map<String,dynamic> data) {
     Map<String, dynamic> quarters = data['quarters'][0];
     return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 15, top: 10),
            child: Text(data['level_title'], style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold, 
              color: Colors.black54,
            ),),
          ),
          Wrap(
          alignment: WrapAlignment.center, //沿主轴方向居中           
          children: _makeupMovie(quarters['movies'].cast<Map<String, dynamic>>()),
          ),
        ],
      );
   }

    return FutureBuilder(
      future: DioManager.getInstance().get(GlobalConfig.ALL_STUDYROUTE, null),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          Response response = snapshot.data;
          var data = json.decode(response.data.toString());
          List<Map> list = (data['list'] as List).cast();

          //发生错误
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          //请求成功，通过项目信息构建用于显示项目名称的ListView
          return  ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                return _makeupLevel(list[i]);
              });
        }
        //请求未完成时弹出loading
        return Center(
          child: CircularProgressIndicator(
            semanticsLabel: 'loading、、、',
          ),
        );
      },
    );
  }
}

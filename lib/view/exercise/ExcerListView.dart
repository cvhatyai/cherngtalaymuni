import 'dart:convert';

import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/system/Info.dart';
import 'package:cvapp/view/AppBarView.dart';
import 'package:cvapp/view/exercise/ExcerDetailView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

var data;

class ExerListView extends StatefulWidget {
  ExerListView({Key key, this.isHaveArrow = ""}) : super(key: key);
  final String isHaveArrow;

  @override
  _ExerListViewState createState() => _ExerListViewState();
}

class _ExerListViewState extends State<ExerListView> {
  var userFullname;
  var uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserDetail();
  }

  getUserDetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userFullname = prefs.getString('userFullname').toString();
      uid = prefs.getString('uid').toString();
    });
    getNewsList();
  }
  
  getNewsList() async {
    Map _map = {};
    _map.addAll({
      "rows": "100",
    });

    EasyLoading.show(status: 'loading...');
    print("_map : " + _map.toString());
    var body = json.encode(_map);
    return postNewsList(http.Client(), body, _map);
  }

  Future<List<AllList>> postNewsList(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().ExerList),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
    parseNewsList(response.body);
  }


  List<AllList> parseNewsList(String responseBody) {
    data = [];
    data.addAll(json.decode(responseBody));

    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    parsed.map<AllList>((json) => AllList.fromJson(json)).toList();
    setState(() {});
    EasyLoading.dismiss();
  }

    BoxDecoration boxWhite() {
    return BoxDecoration(
      /*borderRadius: BorderRadius.all(
        Radius.circular(9.0),
      ),*/
      border: Border.all(
        color: Colors.white,
        width: 1.0,
      ),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 3,
          blurRadius: 7,
          offset: Offset(0, 3), // changes position of shadow
        ),
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    final double itemHeight = (size.height - kToolbarHeight - 24) / 3.2;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: AppBarView(
    title: "??????????????????????????????????????????????????????",
    isHaveArrow: widget.isHaveArrow,
      ),
      body: Container(
    // color: Color(0xFFFFFFFF),
    margin: EdgeInsets.only(top:16),
    padding: EdgeInsets.only(left: 8, right: 8),
    child: (data != null && data.length != 0)
        ? GridView.count(
            childAspectRatio: (itemWidth / itemHeight),
            crossAxisCount: 2,
            children: List.generate(data.length, (index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExcerDetailView(
                          topicID: data[index]["id"].toString()),
                    ),
                  );
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  margin: EdgeInsets.symmetric(horizontal: 4),
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Image.network(
                        data[index]["display_image"],
                        fit: BoxFit.fill,
                      ),
                      Positioned(
                        bottom: 20,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: Offset(
                                  0,
                                  1,
                                ), // changes position of shadow
                              ),
                            ],
                          ),
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width * 0.42,
                          height: 85,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    data[index]["subject"],
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 11),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        data[index]["create_date"],
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Color(0xFF5A1E8E),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/images/view.png',
                                          height: 12,
                                        ),
                                        if (data[index]["hits2"] != "")
                                          Container(
                                            margin:
                                                EdgeInsets.only(left: 4),
                                            child: Text(
                                              data[index]["hits2"],
                                              style:
                                                  TextStyle(fontSize: 12),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          )
        : Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("?????????????????????????????????")),
          ),
      ),
    );
  }
}

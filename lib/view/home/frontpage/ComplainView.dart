import 'dart:convert';

import 'package:cvapp/view/home/frontpage/ComplainFollowView.dart';
import 'package:cvapp/view/webpageview/WebPageView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/model/user.dart';
import 'package:cvapp/system/Info.dart';
import 'package:cvapp/view/complain/ComplainCateListView.dart';
import 'package:cvapp/view/complain/ComplainFormView.dart';
import 'package:cvapp/view/complain/FollowComplainListView.dart';
import 'package:cvapp/view/login/LoginView.dart';
import 'package:cvapp/view/news/NewsListView.dart';
import 'package:http/http.dart' as http;

var data;

class ComplainView extends StatefulWidget {
  @override
  _ComplainViewState createState() => _ComplainViewState();
}

class _ComplainViewState extends State<ComplainView> {
  var user = User();
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
    getComplainList();
  }

  getUsers() async {
    await user.init();
    setState(() {
      isLogin = user.isLogin;
    });
  }

  getComplainList() async {
    Map _map = {};
    _map.addAll({
      "rows": "8",
    });

    EasyLoading.show(status: 'loading...');
    print("_map : " + _map.toString());
    var body = json.encode(_map);
    return postComplainList(http.Client(), body, _map);
  }

  Future<List<AllList>> postComplainList(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().cateInformList),
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    double reshight = 370;

    print('size.width ' + size.width.toString());
    if (size.width < 325) {
      reshight = 270;
    } else if (size.width >= 325 && size.width <= 374) {
      reshight = 290;
    } else if (size.width >= 375 && size.width < 414) {
      reshight = 345;
    } else if (size.width >= 414 && size.width < 575) {
      reshight = 370;
    }

    BoxDecoration boxWhite() {
      return BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(9.0),
        ),
        border: Border.all(
          color: Colors.white,
          width: 1.0,
        ),
        color: Color(0xFFF5F6FA),
      );
    }

    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 24, top: 8),
                child: Text(
                  "ร้องเรียน",
                  style: TextStyle(
                      color: Colors.black, fontSize: 18, fontFamily: 'Kanit'),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  "/ร้องทุกข์",
                  style: TextStyle(
                      color: Color(0xFF5A1E8E),
                      fontSize: 18,
                      fontFamily: 'Kanit'),
                ),
              ),
            ],
          ),
          Container(
            height: reshight,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top:65),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(25),
                          topLeft: Radius.circular(25),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                        gradient: new LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFF4F4F4),
                            Color(0xFFF3F3F3),
                            Color(0xFFDAD8D8),
                          ],
                        ),
                      ),
                      // height: 285,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(4),
                      margin: EdgeInsets.only(top: 8),
                      child: Center(
                        child: (data != null && data.length != 0)
                            ? GridView.count(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                // childAspectRatio: (itemWidth / itemHeight),
                                childAspectRatio: 0.8,
                                crossAxisCount: 4,
                                children: List.generate(data.length, (index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (!isLogin) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => LoginView(
                                              isHaveArrow: "1",
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ComplainFormView(
                                              topicID:
                                                  data[index]["id"].toString(),
                                              subjectTitle: data[index]
                                                  ["subject"],
                                              displayImage: data[index]
                                                  ["display_image"],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    child: Center(
                                      child: Container(
                                        // decoration: boxWhite(),
                                        margin: EdgeInsets.only(
                                          left: 4,
                                          right: 4,
                                          top: 8,
                                        ),
                                        //decoration: boxWhite(),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 8,
                                              child: Container(
                                                padding: EdgeInsets.all(4),
                                                child: Image.network(
                                                  data[index]["display_image"],
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4,
                                                alignment: Alignment.center,
                                                // padding: EdgeInsets.all(16),
                                                child: Text(
                                                  data[index]["subject"],
                                                  maxLines: 1,
                                                  textAlign: TextAlign.center,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                    fontSize: 13,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              )
                            : Container(
                                height: MediaQuery.of(context).size.height,
                                width: MediaQuery.of(context).size.width,
                                child: Center(child: Text("ไม่มีข้อมูล")),
                              ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ComplainCateListView(
                                isHaveArrow: "1",
                              ),
                            ),
                          );
                        },
                        child: Image.asset(
                          'assets/images/main/more.png',
                          height: 24,
                        ),
                      ),
                    ),

                    Container(
                      // margin: EdgeInsets.only(bottom: 16),
                      alignment: Alignment.centerLeft,
                      child: GestureDetector(
                        onTap: () {
                          if (!isLogin) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginView(
                                  isHaveArrow: "1",
                                ),
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WebPageView(
                                  isHaveArrow: "1",
                                  title: "ติดตามเรื่องร้องเรียน",
                                  cmd: "followcomplain",
                                ),
                              ),
                            );
                          }
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom:8),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(4),
                              child: Row(
                                children: [
                                  Text(
                                    "ติดตามเรื่องร้องเรียน",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontFamily: 'Kanit',
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color(0xFFFF7700),
                                    size: 12,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   child:  ComplainFollowView(),
                    // )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

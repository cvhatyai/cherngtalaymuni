import 'dart:convert';

import 'package:cvapp/view/video/VideoListView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/system/Info.dart';
import 'package:cvapp/view/calendar/CalendarDetailView.dart';
import 'package:cvapp/view/calendar/CalendarListView.dart';
import 'package:cvapp/view/gallery/GalleryDetailView.dart';
import 'package:cvapp/view/gallery/GalleryListView.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

var data;
var data2;
var data3;

class GalleryView extends StatefulWidget {
  @override
  _GalleryViewState createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getNewsList();
    getVdoList();
    getActivtyList();
  }

  //vdo
  getVdoList() async {
    Map _map = {};
    _map.addAll({
      "rows": "6",
    });
    EasyLoading.show(status: 'loading...');
    print("_map : " + _map.toString());
    var body = json.encode(_map);
    return postVdoList(http.Client(), body, _map);
  }

  Future<List<AllList>> postVdoList(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().videoList),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
    parseVdoList(response.body);
  }

  List<AllList> parseVdoList(String responseBody) {
    data3 = [];
    data3.addAll(json.decode(responseBody));

    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    parsed.map<AllList>((json) => AllList.fromJson(json)).toList();
    setState(() {});
    EasyLoading.dismiss();
  }

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  updateVideoHit(id) {
    Map _map = {};
    _map.addAll({
      "id": id,
    });
    var body = json.encode(_map);
    return postVideoHit(http.Client(), body, _map);
  }

  Future<List<AllList>> postVideoHit(
      http.Client client, jsonMap, Map map) async {
    await client.post(Uri.parse(Info().videoDetail),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
  }

  //activity
  getActivtyList() async {
    Map _map = {};
    _map.addAll({
      "rows": "2",
    });

    EasyLoading.show(status: 'loading...');
    print("_map : " + _map.toString());
    var body = json.encode(_map);
    return postActivityList(http.Client(), body, _map);
  }

  Future<List<AllList>> postActivityList(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().eventsList),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
    parseActivityList(response.body);
  }

  List<AllList> parseActivityList(String responseBody) {
    data2 = [];
    data2.addAll(json.decode(responseBody));

    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    parsed.map<AllList>((json) => AllList.fromJson(json)).toList();
    setState(() {});
    EasyLoading.dismiss();
  }

  //gallery
  getNewsList() async {
    Map _map = {};
    _map.addAll({
      "rows": "6",
    });

    EasyLoading.show(status: 'loading...');
    print("_map : " + _map.toString());
    var body = json.encode(_map);
    return postNewsList(http.Client(), body, _map);
  }

  Future<List<AllList>> postNewsList(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().galleryList),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
        // headers: {"HttpHeaders.contentTypeHeader": "application/json"},
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

  //tab
  Color tabTextColorNormal = Color(0xFF707070);
  Color tabTextColorActive = Color(0xFF9137A2);
  Color indicatorTabColorNormal = Color(0xFFFFFFFF);
  Color indicatorTabColorActive = Color(0xFFFCC402);
  // bool isFirstTabActivated = true;
  String isFirstTabActivated = "1";

  changeTab(String id) {
    setState(() {
      isFirstTabActivated = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 4.0, right: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(13),
          bottomLeft: Radius.circular(13),
        ),
        // color: Colors.white,
        color: Colors.white,
      ),
      child: Container(
        child: Column(
          children: [
            Container(
              // color: Colors.white,
              padding: EdgeInsets.only(left: 8, top: 8),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      changeTab("1");
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "ภาพกิจกรรม",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (isFirstTabActivated == "1")
                                    ? tabTextColorActive
                                    : tabTextColorNormal,
                                fontSize: 18,
                                fontFamily: 'Kanit'),
                          ),
                        ),
                        Container(
                          color: (isFirstTabActivated == "1")
                              ? indicatorTabColorActive
                              : indicatorTabColorNormal,
                          height: 2,
                          width: 100,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      changeTab("2");
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "กิจกรรมที่กำลังจะมาถึง",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (isFirstTabActivated == "2")
                                    ? tabTextColorActive
                                    : tabTextColorNormal,
                                fontSize: 18,
                                fontFamily: 'Kanit'),
                          ),
                        ),
                        Container(
                          color: (isFirstTabActivated == "2")
                              ? indicatorTabColorActive
                              : indicatorTabColorNormal,
                          height: 2,
                          width: 180,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () {
                      changeTab("3");
                    },
                    child: Column(
                      children: [
                        Container(
                          child: Text(
                            "วีดีโอ",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: (isFirstTabActivated == "3")
                                    ? tabTextColorActive
                                    : tabTextColorNormal,
                                fontSize: 18,
                                fontFamily: 'Kanit'),
                          ),
                        ),
                        Container(
                          color: (isFirstTabActivated == "3")
                              ? indicatorTabColorActive
                              : indicatorTabColorNormal,
                          height: 2,
                          width: 60,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isFirstTabActivated == "1")
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 260,
                    margin: EdgeInsets.only(top: 8),
                    child: (data != null && data.length != 0)
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var i = 0; i < data.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GalleryDetailView(
                                            topicID: data[i]["id"].toString()),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 155,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Image.network(
                                              data[i]["display_image"],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: 80,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data[i]["subject"],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                                Text(
                                                  data[i]["create_date"],
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF2699FB),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text("ไม่มีข้อมูล")),
                          ),
                  ),
                  if (data != null && data.length != 0)
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GalleryListView(
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
                    )
                ],
              ),
            if (isFirstTabActivated == "2")
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 240,
                    margin: EdgeInsets.only(top: 8),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Container(
                                alignment: Alignment.center,
                                child: Text("วันที่"),
                              ),
                            ),
                            Container(
                              width: 20,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 1,
                                    height: 30,
                                    color: Colors.black12,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                padding: EdgeInsets.only(left: 16),
                                child: Text("กิจกรรม"),
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Container(
                            color: Color(0xFFFFFFFF),
                            child: (data2 != null && data2.length != 0)
                                ? ListView.builder(
                                    itemCount: data2.length,
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        data2[index]["sdate"],
                                                        style: TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xFFFF6600),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text("-" +
                                                          data2[index]
                                                              ["edate"]),
                                                    ],
                                                  ),
                                                  Container(
                                                    alignment:
                                                        Alignment.centerLeft,
                                                    child: Text(
                                                      data2[index]["smonth"],
                                                      style: TextStyle(
                                                          fontSize: 9),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Container(
                                            width: 20,
                                            child: Stack(
                                              alignment: Alignment.center,
                                              children: [
                                                Container(
                                                  alignment: Alignment.center,
                                                  width: 1,
                                                  height: 80,
                                                  color: Colors.black12,
                                                ),
                                                Positioned(
                                                  top: 30,
                                                  child: Container(
                                                    width: 16,
                                                    height: 16,
                                                    decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      border: Border.all(
                                                          color:
                                                              Color(0xFF9137A2),
                                                          width: 4),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 4,
                                            child: GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        CalendarDetailView(
                                                            topicID: data2[
                                                                    index]["id"]
                                                                .toString()),
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                height: 70,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(9.0),
                                                  ),
                                                  border: Border.all(
                                                      color: Colors.black12),
                                                  color: (index % 2 == 0)
                                                      ? Color(0xFFF5FFF5)
                                                      : Color(0xFFF8F5E7),
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 8),
                                                padding: EdgeInsets.all(6),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data2[index]
                                                                ["subject"],
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 2,
                                                            style: TextStyle(
                                                              height: 1,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Color(
                                                                  0xFF801BAF),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin:
                                                                EdgeInsets.only(
                                                                    top: 4),
                                                            child: Text(
                                                              data2[index]
                                                                  ["location"],
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              style: TextStyle(
                                                                fontSize: 10,
                                                                color: Color(
                                                                    0xFF505050),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.arrow_forward_ios,
                                                      size: 16,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    })
                                : Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    child: Center(child: Text("ไม่มีข้อมูล")),
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (data2 != null && data2.length != 0)
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CalendarListView(
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
                    )
                ],
              ),
            if (isFirstTabActivated == "3")
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    height: 260,
                    margin: EdgeInsets.only(top: 8),
                    child: (data3 != null && data3.length != 0)
                        ? ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var i = 0; i < data3.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    _launchInBrowser(data3[i]["link"]);
                                    updateVideoHit(data3[i]["id"]);
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.5,
                                    margin: EdgeInsets.symmetric(horizontal: 4),
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 155,
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12)),
                                            child: Image.network(
                                              data3[i]["display_image"],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                          ),
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          height: 80,
                                          child: Container(
                                            padding: EdgeInsets.all(8),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    data3[i]["subject"],
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style:
                                                        TextStyle(fontSize: 14),
                                                  ),
                                                ),
                                                Text(
                                                  data3[i]["create_date"],
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Color(0xFF2699FB),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ],
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Text("ไม่มีข้อมูล")),
                          ),
                  ),
                  if (data3 != null && data3.length != 0)
                    Container(
                      padding: EdgeInsets.all(8),
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VideoListView(
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
                    )
                ],
              ),
          ],
        ),
      ),
    );
  }
}

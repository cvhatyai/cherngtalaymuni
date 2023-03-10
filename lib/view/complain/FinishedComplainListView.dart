import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/model/user.dart';
import 'package:cvapp/system/Info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../AppBarView.dart';
import 'ComplainDetailView.dart';

var data;

class FinishedComplainListView extends StatefulWidget {
  FinishedComplainListView({Key key, this.isHaveArrow = ""}) : super(key: key);
  final String isHaveArrow;

  @override
  _FinishedComplainListViewState createState() =>
      _FinishedComplainListViewState();
}

class _FinishedComplainListViewState extends State<FinishedComplainListView> {
  var user = User();
  bool isLogin = false;
  var uid = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  getUsers() async {
    await user.init();
    setState(() {
      isLogin = user.isLogin;
      uid = user.uid;
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
    final response = await client.post(Uri.parse(Info().informFinishList),
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
    return Scaffold(
      appBar: AppBarView(
        title: "???????????????????????????????????????????????????????????????????????????",
        isHaveArrow: widget.isHaveArrow,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/bg_sub.png"),
              fit: BoxFit.cover,
              alignment: Alignment.topCenter),
          // color: Color(0xFFFFFFFF),
        ),
        child: Container(
          margin: EdgeInsets.only(top: 28),
          padding: EdgeInsets.only(left: 8, right: 8),
          child: (data != null && data.length != 0)
              ? ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ComplainDetailView(
                                topicID: data[index]["id"].toString(),
                                title: "???????????????????????????????????????????????????????????????????????????",
                                isShow: "1"),
                          ),
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(9.0),
                          ),
                          border: Border.all(
                            color: Color(0xFF801BAF),
                            width: 1.0,
                          ),
                          color: Colors.white,
                        ),
                        margin: EdgeInsets.only(top: 4),
                        child: ConstrainedBox(
                          constraints: new BoxConstraints(
                            minHeight:
                                MediaQuery.of(context).size.height * 0.08,
                          ),
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Icon(
                                      Icons.circle,
                                      color: Color(0xFF801BAF),
                                      size: 12,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 10,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(4),
                                        child: Text(
                                          "?????????????????? " +
                                              data[index]["subject"].toString(),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          data[index]["finish_date"].toString(),
                                          style: TextStyle(
                                              fontSize: 12, color: Colors.grey),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            child: Text(
                                              "???????????????",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          ),
                                          if (data[index]["status"] ==
                                              "???????????????????????????")
                                            Container(
                                              margin: EdgeInsets.only(left: 16),
                                              child: Text(
                                                data[index]["status"]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                          if (data[index]["status"] ==
                                              "??????????????????????????????????????????")
                                            Container(
                                              margin: EdgeInsets.only(left: 16),
                                              child: Text(
                                                data[index]["status"],
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.orange,
                                                ),
                                              ),
                                            ),
                                          if (data[index]["status"] ==
                                              "??????????????????????????????????????????????????????")
                                            Container(
                                              margin: EdgeInsets.only(left: 16),
                                              child: Text(
                                                data[index]["status"]
                                                    .toString(),
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Text("?????????????????????????????????")),
                ),
        ),
      ),
    );
  }
}

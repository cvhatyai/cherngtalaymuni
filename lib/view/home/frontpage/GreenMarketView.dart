import 'dart:convert';

import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/model/user.dart';
import 'package:cvapp/system/Info.dart';
import 'package:cvapp/view/greenmarket/GreenMarketAddView.dart';
import 'package:cvapp/view/greenmarket/GreenMarketDetailView.dart';
import 'package:cvapp/view/greenmarket/GreenMarketListView.dart';
import 'package:cvapp/view/login/LoginView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

var data;

class GreenMarketView extends StatefulWidget {
  //const GreenMarketView({Key? key}) : super(key: key);

  @override
  _GreenMarketViewState createState() => _GreenMarketViewState();
}

class _GreenMarketViewState extends State<GreenMarketView> {
  @override
  var user = User();
  bool isLogin = false;

  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
  }

  getUsers() async {
    await user.init();
    setState(() {
      isLogin = user.isLogin;
    });
    getList();
  }

  getList() async {
    Map _map = {};
    _map.addAll({
      "rows": "6",
    });
    var body = json.encode(_map);
    return postList(http.Client(), body, _map);
  }

  Future<List<AllList>> postList(http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().marketList),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
    parseNewsList(response.body);
  }

  List<AllList> parseNewsList(String responseBody) {
    data = [];
    data.addAll(json.decode(responseBody));
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    parsed.map<AllList>((json) => AllList.fromJson(json)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: new BoxDecoration(
      //   image: new DecorationImage(
      //     image: new ExactAssetImage('assets/images/main/market_bg.png'),
      //     fit: BoxFit.cover,
      //   ),
      // ),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              child: Image.asset('assets/images/takra.png'),
                              height: 40,
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'ตลาดชาวบ้าน',
                                style: TextStyle(
                                    color: Color(0xFF5A1E8E),
                                    fontSize: 16,
                                    fontFamily: 'Kanit'),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 8),
                              child: Text(
                                'ทต.เชิงทะเล',
                                style: TextStyle(
                                    fontSize: 12, fontFamily: 'Kanit'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
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
                            builder: (context) => GreenMarketAddView(
                              isHaveArrow: "1",
                            ),
                          ),
                        );
                      }
                    },
                    child: Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFFFFF),
                          borderRadius: BorderRadius.circular(16),
                          border:
                              Border.all(color: Color(0xFF5A1E8E), width: 1),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text(
                                'สมัครขายสินค้า',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                                size: 12.0,
                              ),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: 5),
                height: MediaQuery.of(context).size.height * 0.45,
                child: Stack(
                  children: [
                    //bg
                    // Image.asset(
                    //   'assets/images/main/market_bg.png',
                    // ),

                    //list
                    (data != null && data.length != 0)
                        ? Container(
                            margin: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height * 0.08),
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                for (int i = 0; i < data.length; i++)
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              GreenMarketDetailView(
                                            topicID: data[i]["id"],
                                            title: "ตลาดชาวบ้าน",
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 16),
                                      width: MediaQuery.of(context).size.width *
                                          0.45,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.13,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(6),
                                              ),
                                              border: Border.all(
                                                color: Colors.white,
                                                width: 1.0,
                                              ),
                                              image: DecorationImage(
                                                image: (data[i]
                                                            ["display_image"] !=
                                                        "")
                                                    ? NetworkImage(data[i]
                                                            ["display_image"]
                                                        .trim())
                                                    : AssetImage(
                                                        'assets/images/main/test.png'),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 16),
                                            child: Text(
                                              data[i]["productName"],
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.04,
                                            child: Text(
                                              data[i]["productDetail"],
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 4),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/main/shop.png',
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 6),
                                                    child: Text(
                                                      data[i]["shopName"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFF686868),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 4),
                                            child: Row(
                                              children: [
                                                Image.asset(
                                                  'assets/images/main/pin.png',
                                                  width: 10,
                                                ),
                                                Expanded(
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 6),
                                                    child: Text(
                                                      data[i]["shopAddress"],
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color:
                                                            Color(0xFF686868),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (data[i]["hits"] != "")
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Row(
                                                children: [
                                                  Expanded(child: Container()),
                                                  Image.asset(
                                                    'assets/images/main/hit.png',
                                                    width: 12,
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(
                                                        left: 4),
                                                    child: Text(
                                                      data[i]["hits"],
                                                      style: TextStyle(
                                                        fontSize: 11,
                                                        color:
                                                            Color(0xFF1D1D1D),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : Center(
                            child: Text("ไม่มีข้อมูล"),
                          ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            // alignment: Alignment.topRight,
            margin: EdgeInsets.only(bottom: 16),
            // padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: Container(),
                ),
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => GreenMarketListView(
                            isHaveArrow: "1",
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: Color(0xFF5A1E8E),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: Color(0xFF5A1E8E), width: 4),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              'ดูทั้งหมด',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.yellow,
                              size: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

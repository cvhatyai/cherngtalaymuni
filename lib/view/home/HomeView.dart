import 'dart:convert';

import 'package:cvapp/view/download/DownloadListView.dart';
import 'package:cvapp/view/eservice/EserviceView.dart';
import 'package:cvapp/view/home/frontpage/Contact2.dart';
import 'package:cvapp/view/phone/PhoneCateListView.dart';
import 'package:cvapp/view/poll/PollView.dart';
import 'package:cvapp/view/travel/TravelListView.dart';
import 'package:cvapp/view/webpageview/WebPageView.dart';
import 'package:http/http.dart' as http;
import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/view/chat/ChatView.dart';
import 'package:cvapp/view/home/frontpage/GreenMarketView.dart';
import 'package:cvapp/view/menu/MenuView.dart';
import 'package:cvapp/view/noti/NotiListView.dart';
import 'package:cvapp/view/weather/WeatherListView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cvapp/model/user.dart';
import 'package:cvapp/system/Info.dart';
import 'package:cvapp/view/home/frontpage/ServiceHomeView.dart';
import 'package:cvapp/view/home/frontpage/MarqueeView.dart';
import 'package:cvapp/view/home/frontpage/BannerView.dart';
import 'package:cvapp/view/home/frontpage/SuggustView.dart';
import 'package:cvapp/view/home/frontpage/NewsView.dart';
import 'package:cvapp/view/home/frontpage/ComplainView.dart';
import 'package:cvapp/view/home/frontpage/ComplainFollowView.dart';
import 'package:cvapp/view/home/frontpage/GalleryView.dart';
import 'package:cvapp/view/home/frontpage/TravelView.dart';
import 'package:cvapp/view/login/LoginView.dart';
import 'package:cvapp/view/setting/SettingView.dart';
import 'package:toast/toast.dart';

import '../FrontPageView.dart';
import 'frontpage/BannerLinkView.dart';
import 'frontpage/FooterView.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  //weather
  var iconWeather = "";
  var tempWeather = "";
  var textWeather = "";

  var user = User();
  bool isLogin = false;
  var userAvatar = Info().baseUrl + "images/nopic-personal-app.png";

  void initState() {
    super.initState();
    getUsers();
    setWeather();
  }

  getUsers() async {
    await user.init();
    setState(() {
      isLogin = user.isLogin;
      if (isLogin) {
        userFullname = user.fullname;
        userAvatar = user.avatar;
        print("userAvataruserAvatar" + userAvatar);
      }
    });
  }

  setWeather() async {
    Map _map = {};
    _map.addAll({});
    var body = json.encode(_map);
    return postSiteDetail(http.Client(), body, _map);
  }

  Future<List<AllList>> postSiteDetail(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().weatherApi),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
    var rs = json.decode(response.body);
    setState(() {
      iconWeather = rs["icon"].toString();
      tempWeather = rs["temp"].toString();
      textWeather = rs["description"].toString();
    });
  }

  var userFullname = "เข้าสู่ระบบ";
  var userClass = "เข้าสู่ระบบ";
  Future<void> logout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          //title: Text('AlertDialog Title'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('ยืนยันการออกจากระบบ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('ยืนยัน'),
              onPressed: () {
                user.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => FrontPageView()),
                  ModalRoute.withName("/"),
                );
                Toast.show("ออกจากระบบแล้ว", context,
                    duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double reshighticon = 40;
    if (size.width <= 375) {
      reshighticon = 40;
    }
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/bg_test.png"),
                // fit: BoxFit.cover,
                alignment: Alignment.topCenter),
          ),
          child: Column(
            children: [
              Container(
                height: 80,
                child: Row(
                  children: [
                    Container(width: 20),
                    Container(
                      width: 80,
                      child: Image.asset(
                        'assets/images/main/logo_top.png',
                        height: reshighticon,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: Image.asset(
                            'assets/images/bg_toprec.png',
                          ),
                        ),
                      ),
                    ),
                    Container(width: 20),
                    Container(
                      width: 80,
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
                                builder: (context) => NotiListView(
                                  isHaveArrow: "1",
                                ),
                              ),
                            );
                          }
                        },
                        child: Center(
                          child: Container(
                            width: 45,
                            height: 45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(22.5),
                              ),
                            ),
                            child: Icon(
                              Icons.notifications_sharp,
                              color: Color(0xFF801BAF),
                              size: 26,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 270,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/bg-news.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.only(top: isLogin ? 34 : 48),
                      child: Row(
                        children: [
                          Container(
                            child: CircleAvatar(
                              radius: 24.0,
                              backgroundImage: NetworkImage(userAvatar),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (isLogin)
                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      "สวัสดี",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontFamily: 'kanit',
                                      ),
                                    ),
                                  ),
                                GestureDetector(
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
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Text(
                                      userFullname,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontFamily: 'kanit',
                                      ),
                                    ),
                                  ),
                                ),
                                if (isLogin)
                                  Container(
                                    padding: EdgeInsets.only(left: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              child: GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          SettingView(
                                                        isHaveArrow: "1",
                                                      ),
                                                    ),
                                                  ).then((value) {
                                                    getUsers();
                                                  });
                                                },
                                                child: Text(
                                                  "ข้อมูลผู้ใช้",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontFamily: 'kanit',
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 2),
                                              child: Icon(
                                                Icons.arrow_forward_ios,
                                                color: Colors.white,
                                                size: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Container(
                                        //       child: GestureDetector(
                                        //         onTap: () {
                                        //           logout();
                                        //         },
                                        //         child: Text(
                                        //           "ออกจากระบบ",
                                        //           style: TextStyle(
                                        //             color: Colors.white,
                                        //             fontSize: 16,
                                        //             fontFamily: 'kanit',
                                        //           ),
                                        //         ),
                                        //       ),
                                        //     ),
                                        //     Container(
                                        //       margin: EdgeInsets.only(top: 2),
                                        //       child: Icon(
                                        //         Icons.arrow_forward_ios,
                                        //         color: Colors.white,
                                        //         size: 12,
                                        //       ),
                                        //     ),
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    //marquee
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: MarqueeView(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => EserviceView(
                                  isHaveArrow: "1",
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 42,
                            child: Image.asset(
                              'assets/images/bg_es.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // บริการแนะนำ
              ServiceHomeView(),
              //แนะนำสำหรับคุณ
              Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                decoration: new BoxDecoration(
                  color: Color(0xFFe3dbf0),
                  image: new DecorationImage(
                    image: new ExactAssetImage('assets/images/main/bg_sug.png'),
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 30.0, left: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PhoneCateListView(
                                      isHaveArrow: "1",
                                      title: "หมายเลขโทรฉุกเฉิน",
                                    ),
                                  ),
                                ).then((value) {});
                              },
                              child: Container(
                                height: 60,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 60,
                                        child: Image.asset(
                                          'assets/images/ic-sug1.png',
                                          height: reshighticon,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("หมายเลขโทรฉุกเฉิน",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DownloadListView(
                                      isHaveArrow: "1",
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 60,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 60,
                                        child: Image.asset(
                                          'assets/images/ic-sug2.png',
                                          height: reshighticon,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("เอกสาร/แบบฟอร์ม",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PollView(
                                      isHaveArrow: "1",
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                height: 60,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 60,
                                        child: Image.asset(
                                          'assets/images/ic-sug3.png',
                                          height: reshighticon,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("ประเมินความพึงพอใจ",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TravelListView(
                                      isHaveArrow: "1",
                                      title: "ที่เที่ยว",
                                      tid: "1",
                                    ),
                                  ),
                                ).then((value) {
                                  setState(() {});
                                });
                              },
                              child: Container(
                                height: 60,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Center(
                                      child: Container(
                                        width: 60,
                                        child: Image.asset(
                                          'assets/images/ic-sug5.png',
                                          height: reshighticon,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text("ที่เที่ยว",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              //บรรเทาความเดือดร้อนล่าสุด
              ComplainFollowView(),
              // banner
              Container(
                color: Color(0xFFEEF4FB),
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image:
                            new ExactAssetImage('assets/images/top-news.png'),
                        fit: BoxFit.cover,
                        alignment: Alignment.topCenter,
                      ),
                    ),
                    child: Column(
                      children: [
                        BannerView(),
                        NewsView(),
                      ],
                    ),
                  ),
                ),
              ),
              //กิจกรรมห้ามพลาด
              Container(
                color: Color(0xFFEEF4FB),
                child: GalleryView(),
              ),
              //เสน่ห์เมืองเชิงทะเล
              Container(
                color: Color(0xFFEEF4FB),
                child: TravelView(),
              ),
              //footer
              FooterView(),
              // แจ้งเรื่องร้องเรียน/ร้องทุกข์
              // ComplainView(),
              // SuggustView(),
              // Container(
              //   child: Column(
              //     children: [
              //       Stack(
              //         children: [
              //           Container(
              //             height: 130,
              //             width: MediaQuery.of(context).size.width,
              //             child: GestureDetector(
              //               onTap: () {
              //                 Navigator.push(
              //                   context,
              //                   MaterialPageRoute(
              //                     builder: (context) => WeatherListView(
              //                       isHaveArrow: "1",
              //                     ),
              //                   ),
              //                 );
              //               },
              //               child: Container(
              //                 padding: EdgeInsets.all(5),
              //                 margin: EdgeInsets.only(
              //                     top: 35, bottom: 35, right: 100, left: 100),
              //                 width: MediaQuery.of(context).size.width / 3.1,
              //                 decoration: BoxDecoration(
              //                     borderRadius: BorderRadius.all(
              //                       Radius.circular(20.0),
              //                     ),
              //                     color: Colors.black.withOpacity(0.6)),
              //                 child: Column(
              //                   mainAxisAlignment: MainAxisAlignment.center,
              //                   children: [
              //                     Container(
              //                       alignment: Alignment.centerLeft,
              //                       child: Text(
              //                         "อากาศเชิงทะเลวันนี้",
              //                         style: TextStyle(
              //                           fontSize: 12,
              //                           color: Colors.white,
              //                         ),
              //                         maxLines: 1,
              //                         overflow: TextOverflow.ellipsis,
              //                       ),
              //                     ),
              //                     Container(
              //                       child: Row(
              //                         children: [
              //                           if (iconWeather != "")
              //                             Expanded(
              //                               child: Image.network(
              //                                 iconWeather,
              //                                 height: 26,
              //                               ),
              //                             ),
              //                           Expanded(
              //                             child: Text(
              //                               "$tempWeather °",
              //                               style: TextStyle(
              //                                 fontSize: 14,
              //                                 color: Colors.white,
              //                               ),
              //                               maxLines: 1,
              //                               overflow: TextOverflow.ellipsis,
              //                             ),
              //                           ),
              //                           Expanded(
              //                             child: Container(
              //                               width: MediaQuery.of(context)
              //                                       .size
              //                                       .width /
              //                                   3.5,
              //                               child: SingleChildScrollView(
              //                                 child: Container(
              //                                   child: Text(
              //                                     textWeather,
              //                                     style: TextStyle(
              //                                       fontSize: 10,
              //                                       color: Colors.white,
              //                                     ),
              //                                     maxLines: 2,
              //                                     overflow:
              //                                         TextOverflow.ellipsis,
              //                                   ),
              //                                 ),
              //                               ),
              //                             ),
              //                           )
              //                         ],
              //                       ),
              //                     ),
              //                   ],
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //
              //     ],
              //   ),
              // ),
              //แจ้งเรื่องร้องเรียน/ร้องทุกข์
              // ComplainView(),
              // Contact2(),
              // BannerLinkView(),
              // Container(
              //   // height: MediaQuery.of(context).size.height * 1.5,
              //   decoration: new BoxDecoration(
              //     image: new DecorationImage(
              //       image: new ExactAssetImage('assets/images/bg-news.png'),
              //       fit: BoxFit.fill,
              //     ),
              //   ),
              //   child: Column(
              //     children: [
              //       //marquee
              //       // MarqueeView(),
              //       //ทต.เชิงทะเลอัพเดท
              //       BannerView(),
              //     ],
              //   ),
              // ),
              // GreenMarketView(),
            ],
          ),
        ),
      ),
    );
  }
}

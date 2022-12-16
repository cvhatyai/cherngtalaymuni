import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/model/user.dart';
import 'package:cvapp/system/Info.dart';
import 'package:cvapp/view/complain/ComplainCateListView.dart';
import 'package:cvapp/view/complain/FollowComplainListView.dart';
import 'package:cvapp/view/login/LoginView.dart';
import 'package:cvapp/view/poll/PollView.dart';
import 'package:cvapp/view/webpageview/WebPageView.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../AppBarView.dart';

class EserviceView extends StatefulWidget {
  EserviceView({Key key, this.isHaveArrow = ""}) : super(key: key);
  final String isHaveArrow;

  @override
  _EserviceViewState createState() => _EserviceViewState();
}

class _EserviceViewState extends State<EserviceView> {
  var user = User();
  bool isLogin = false;

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
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        title: "E-Service",
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
          color: Color(0xFFFFFFFF),
        ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 36),
            child: Column(
              children: [
                //ชำระบริการ
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "ขออนุญาต",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'kanit',
                      color: Color(
                        0xFF9137A2,
                      ),
                    ),
                  ),
                ),
                //icon
                Container(
                  margin: EdgeInsets.only(top: 16, left: 16),
                  child: Row(
                    children: [
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
                              if (user.userclass == "member") {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => WebPageView(
                                //       isHaveArrow: "1",
                                //       title: "ขออนุญาตสถานประกอบการ",
                                //       cmd: "",
                                //     ),
                                //   ),
                                // );
                              } else {
                                Toast.show(
                                    "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ic-store.png',
                                    height: 60,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text(
                                      "ขออนุญาตสถานประกอบการ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
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
                              if (user.userclass == "member") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebPageView(
                                      isHaveArrow: "1",
                                      title: "ขออนุญาตอนุมัติงานก่อสร้าง",
                                      cmd: "publicworks",
                                    ),
                                  ),
                                );
                              } else {
                                Toast.show(
                                    "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ic-build.png',
                                    height: 60,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text(
                                      "ขออนุญาตอนุมัติงานก่อสร้าง",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                //line
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Divider(),
                ),
                //สวัสดิการ
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "แจ้งซ่อม/แจ้งรับบริการ",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'kanit',
                      color: Color(
                        0xFF9137A2,
                      ),
                    ),
                  ),
                ),
                //icon
                Container(
                  margin: EdgeInsets.only(top: 16, left: 16),
                  child: Row(
                    children: [
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
                              if (user.userclass == "member") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebPageView(
                                      isHaveArrow: "1",
                                      title:
                                          "แจ้งซ่อมแซม ไฟฟ้าสาธารณะ ถนน ฝาคูระบายน้ำ ระบบกระจายเสียงไร้สาย",
                                      cmd: "electricity",
                                    ),
                                  ),
                                );
                              } else {
                                Toast.show(
                                    "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ic-elec.png',
                                    height: 60,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text(
                                      "ไฟฟ้าสาธารณะ ถนน ฝาคูระบายน้ำ ระบบกระจายเสียง ไร้สาย",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
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
                              if (user.userclass == "member") {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebPageView(
                                      isHaveArrow: "1",
                                      title: "แจ้งดูดสิ่งปฏิกูล",
                                      cmd: "sewage_registration",
                                    ),
                                  ),
                                );
                              } else {
                                Toast.show(
                                    "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
                                    context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ic-swag.png',
                                    height: 60,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 12),
                                    child: Text(
                                      "แจ้งดูดสิ่งปฏิกูล\n\n\n",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(child: Container()),
                    ],
                  ),
                ),
                //line
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Divider(),
                ),
                //บริการอื่นๆ
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "บริการอื่นๆ",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'kanit',
                      color: Color(
                        0xFF9137A2,
                      ),
                    ),
                  ),
                ),
                //icon
                Container(
                  margin: EdgeInsets.only(top: 16, left: 16,right: 8),
                  child: Row(
                    children: [
                      Expanded(
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
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ic-help.png',
                                    height: 60,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 8),
                                    child: Text(
                                      "แจ้งเรื่องร้องเรียน\n",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
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
                                  builder: (context) => FollowComplainListView(
                                    isHaveArrow: "1",
                                  ),
                                ),
                              );
                            }
                          },
                          child: Container(
                             decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ic-follow.png',
                                    height: 60,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text(
                                      "ติดตามเรื่อง\nร้องเรียน/ร้องทุกข์",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
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
                             decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              ),
                            ),
                            width: MediaQuery.of(context).size.width * 0.28,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Image.asset(
                                    'assets/images/ic-poll.png',
                                    height: 60,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Text(
                                      "ประเมินความ\nพึงพอใจ",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //line
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                  child: Divider(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

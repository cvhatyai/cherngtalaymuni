import 'dart:convert';

import 'package:cvapp/view/complain/ComplainCateListView.dart';
import 'package:cvapp/view/nearview/NearMeView.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:cvapp/model/user.dart';
import 'package:cvapp/system/FirebaseNotification.dart';
import 'package:cvapp/view/login/LoginView.dart';
import 'package:cvapp/view/news/NewsDetailView.dart';

import 'package:cvapp/view/news/NewsListView.dart';
import 'package:cvapp/view/noti/NotiListView.dart';
import 'package:cvapp/view/search/SearchView.dart';
import 'package:cvapp/view/webpageview/WebPageView.dart';

import 'chat/ChatView.dart';
import 'complain/ComplainAdminDetailView.dart';
import 'complain/ComplainDetailView.dart';
import 'gallery/GalleryDetailView.dart';
import 'home/HomeView.dart';
import 'menu/MenuView.dart';

class FrontPageView extends StatefulWidget {
  FrontPageView({
    Key key,
    this.payload = "",
    this.tab = "",
  }) : super(key: key);
  String payload;
  String tab;
  @override
  _FrontPageViewState createState() => _FrontPageViewState();
}

class _FrontPageViewState extends State<FrontPageView> {
  int _selectedIndex = 0;
  List<Widget> _widgetOptions = [
    HomeView(),
    NewsListView(),
    ChatView(),
    // NotiListView(),
    NearMeView(),
    MenuView()
  ];

  var user = User();
  bool isLogin = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUsers();
    if(widget.tab != null && widget.tab != ""){
      _onItemTapped(int.parse(widget.tab));
    }
  }

  getUsers() async {
    await user.init();
    setState(() {
      isLogin = user.isLogin;
    });

    if (isLogin) {
      _widgetOptions = [
        HomeView(),
        NewsListView(),
        // ComplainCateListView(),
        ChatView(),
        NotiListView(),
        // NearMeView(),
        MenuView()
      ];
    } else {
      _widgetOptions = [
        HomeView(),
        NewsListView(),
        // ComplainCateListView(),
        ChatView(),
        // NearMeView(),
        LoginView(),
        MenuView()
      ];
    }

    if (widget.payload != null) {
      if (widget.payload != "null") {
        if (widget.payload != "") {
          checkIsHasFromNotiBanner();
        }
      }
    }
  }

  //กดจาก noti ใหม่
  checkIsHasFromNotiBanner() {
    print("checkIsHasFromNotiBanner");
    print("aa : " + widget.payload.toString());
    final rs = json.decode(widget.payload.toString());
    widget.payload = "";
    print("id : " + rs["id"]);
    print("fn_name : " + rs["fn_name"]);
    print("menu : " + rs["menu"]);

    gotoDetail(rs["fn_name"], rs["id"]);
  }

  gotoDetail(fnName, topicID) {
    print("fnName : " + fnName);
    print("topicID : " + topicID);
    if (fnName == "newsDetail") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NewsDetailView(topicID: topicID.toString()),
        ),
      );
    } else if (fnName == "galleryDetail") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => GalleryDetailView(topicID: topicID.toString()),
        ),
      );
    } else {
      if (isLogin) {
        if (fnName == "informDetail") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ComplainDetailView(topicID: topicID.toString()),
            ),
          );
        } else if (fnName == "informAdminDetail") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  ComplainAdminDetailView(topicID: topicID.toString()),
            ),
          );
        } else if (fnName == "taxAdmin") {
          if (user.userclass != "member") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebPageView(
                  isHaveArrow: "1",
                  title: "รายการภาษี",
                  cmd: "tax_admin",
                  edit: topicID,
                ),
              ),
            );
          }
        } else if (fnName == "disabledAdmin") {
          if (user.userclass != "member") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebPageView(
                  isHaveArrow: "1",
                  title: "รายการเบี้ยยังชีพผู้พิการ",
                  cmd: "disabled_admin",
                  edit: topicID,
                ),
              ),
            );
          }
        } else if (fnName == "disabledDetail") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebPageView(
                isHaveArrow: "1",
                title: "รายการเบี้ยยังชีพผู้พิการ",
                cmd: "disabled",
                edit: topicID,
              ),
            ),
          );
        } else if (fnName == "elderAdmin") {
          if (user.userclass != "member") {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => WebPageView(
                  isHaveArrow: "1",
                  title: "รายการเบี้ยยังชีพผู้สูงอายุ",
                  cmd: "elder_admin",
                  edit: topicID,
                ),
              ),
            );
          }
        } else if (fnName == "elderDetail") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebPageView(
                isHaveArrow: "1",
                title: "รายการเบี้ยยังชีพผู้สูงอายุ",
                cmd: "elder",
                edit: topicID,
              ),
            ),
          );
        } else if (fnName == "garbageDetail") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebPageView(
                isHaveArrow: "1",
                title: "ชำระค่าขยะ",
                cmd: "garbage",
                edit: topicID,
              ),
            ),
          );
        } else if (fnName == "taxDetail") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebPageView(
                isHaveArrow: "1",
                title: "ชำระภาษี",
                cmd: "tax",
                edit: topicID,
              ),
            ),
          );
        } else if (fnName == "taxHistory") {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WebPageView(
                isHaveArrow: "1",
                title: "ชำระภาษี",
                cmd: "taxHistory",
                edit: "",
              ),
            ),
          );
        }
      }
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: Container(
          color: Colors.white,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          color: Color(0xFFdfdfdf),
          child: SafeArea(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_bottommeu.png'),
                  fit: BoxFit.cover,
                ),
                color: Colors.white.withOpacity(0),
              ),
              child: Theme(
                data: Theme.of(context)
                    .copyWith(canvasColor: Colors.white.withOpacity(0)),
                child: BottomNavigationBar(
                  backgroundColor: Colors.transparent,
                  type: BottomNavigationBarType.fixed,
                  currentIndex: _selectedIndex,
                  selectedFontSize: 0,
                  elevation: 0,
                  onTap: _onItemTapped,
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                        icon: Container(
                          width: double.infinity,
                          decoration: _selectedIndex == 0
                              ? BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/dino.png'),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.topCenter),
                                  color: Colors.white.withOpacity(0),
                                )
                              : null,
                          child: Container(
                            padding: EdgeInsets.only(top: 10),
                            child: Column(
                              children: [
                                Image.asset(
                                  'assets/images/home.png',
                                  height: 45,
                                ),
                              ],
                            ),
                          ),
                        ),
                        label: '',
                        backgroundColor: Colors.red),
                    BottomNavigationBarItem(
                      icon: Container(
                        width: double.infinity,
                        decoration: _selectedIndex == 1
                            ? BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/dino.png'),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter),
                                color: Colors.white.withOpacity(0),
                              )
                            : null,
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/complain_bottom.png',
                                height: 45,
                              ),
                            ],
                          ),
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        height: 60,
                        width: 60,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image: new ExactAssetImage(
                                'assets/images/main/bottombar_sug.png'),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                        // padding: EdgeInsets.only(top: 50),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(padding: EdgeInsets.all(8)),
                          ],
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        width: double.infinity,
                        decoration: _selectedIndex == 3
                            ? BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/dino.png'),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter),
                                color: Colors.white.withOpacity(0),
                              )
                            : null,
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/noti2.png',
                                height: 45,
                              ),
                            ],
                          ),
                        ),
                      ),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: Container(
                        width: double.infinity,
                        decoration: _selectedIndex == 4
                            ? BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/images/dino.png'),
                                    fit: BoxFit.cover,
                                    alignment: Alignment.topCenter),
                                color: Colors.white.withOpacity(0),
                              )
                            : null,
                        child: Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Image.asset(
                                'assets/images/list.png',
                                height: 45,
                              ),
                            ],
                          ),
                        ),
                      ),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

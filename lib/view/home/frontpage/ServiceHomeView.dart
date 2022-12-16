import 'package:cvapp/view/download/DownloadListView.dart';
import 'package:cvapp/view/exercise/ExcerListView.dart';
import 'package:cvapp/view/phone/PhoneCateListView.dart';
import 'package:flutter/material.dart';
import 'package:cvapp/model/user.dart';
import 'package:cvapp/view/complain/ComplainCateListView.dart';
import 'package:cvapp/view/complain/FollowComplainListView.dart';
import 'package:cvapp/view/eservice/EserviceView.dart';
import 'package:cvapp/view/login/LoginView.dart';
import 'package:cvapp/view/poll/PollView.dart';
import 'package:cvapp/view/serviceGuide/ServiceGuideListView.dart';
import 'package:cvapp/view/webpageview/WebPageView.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../FrontPageView.dart';

class ServiceHomeView extends StatefulWidget {
  @override
  _ServiceHomeViewState createState() => _ServiceHomeViewState();
}

class _ServiceHomeViewState extends State<ServiceHomeView> {
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
    return Container(
      height: 280,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new ExactAssetImage('assets/images/bg-e.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          children: [
            Row(
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
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 80,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image:
                                new ExactAssetImage('assets/images/es-1.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ขออนุญาต",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9137A2),
                                ),
                              ),
                              Text("สถานประกอบการ"),
                            ],
                          ),
                        ),
                      ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 80,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image:
                                new ExactAssetImage('assets/images/es-2.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ขออนุญาต",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9137A2),
                                ),
                              ),
                              Text("อนุมัติงานก่อสร้าง"),
                            ],
                          ),
                        ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 80,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image:
                                new ExactAssetImage('assets/images/es-1.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "แจ้งดูดสิ่งปฏิกูล",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9137A2),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 80,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image:
                                new ExactAssetImage('assets/images/es-4.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 8.0, top: 4.0, right: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "แจ้งซ่อมแซม",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9137A2),
                                ),
                              ),
                              Text(
                                "ไฟฟ้าสาธารณะ ถนน ฝาคูระบายน้ำ ระบบกระจายเสียง \nไร้สาย",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
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
                              builder: (context) => ComplainCateListView(
                                isHaveArrow: "1",
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
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 80,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image:
                                new ExactAssetImage('assets/images/es-5.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ร้องเรียนร้องทุกข์",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9137A2),
                                ),
                              ),
                              Text("ติดตามเรื่อง"),
                            ],
                          ),
                        ),
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
                          builder: (context) => FrontPageView(
                            tab: "2",
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        height: 80,
                        decoration: new BoxDecoration(
                          image: new DecorationImage(
                            image:
                                new ExactAssetImage('assets/images/es-6.png'),
                            fit: BoxFit.cover,
                            alignment: Alignment.topCenter,
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0, top: 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ค้นหา",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF9137A2),
                                ),
                              ),
                              Text(
                                "น้องใจดีช่วยตอบ",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// child: Stack(
//         children: [
//           Column(
//             children: [
//               Container(
//                 margin: EdgeInsets.only(top: 8),
//                 // height: MediaQuery.of(context).size.height * 0.16,
//                 height: 350,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         // if (!isLogin) {
//                         //   Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) => LoginView(
//                         //         isHaveArrow: "1",
//                         //       ),
//                         //     ),
//                         //   );
//                         // } else {
//                         //   if (user.userclass == "member") {
//                         //     Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //         builder: (context) => WebPageView(
//                         //           isHaveArrow: "1",
//                         //           title: "ชำระภาษี",
//                         //           cmd: "tax",
//                         //         ),
//                         //       ),
//                         //     );
//                         //   } else {
//                         //     Toast.show(
//                         //         "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
//                         //         context,
//                         //         duration: Toast.LENGTH_LONG,
//                         //         gravity: Toast.BOTTOM);
//                         //   }
//                         // }

//                         if (!isLogin) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginView(
//                                 isHaveArrow: "1",
//                               ),
//                             ),
//                           );
//                         } else {
//                           if (user.userclass == "member") {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => WebPageView(
//                                   isHaveArrow: "1",
//                                   title: "ชำระค่าน้ำประปาและค่าขยะ",
//                                   cmd: "garbage",
//                                 ),
//                               ),
//                             );
//                           } else {
//                             Toast.show(
//                                 "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
//                                 context,
//                                 duration: Toast.LENGTH_LONG,
//                                 gravity: Toast.BOTTOM);
//                           }
//                         }
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.28,
//                         child: Column(
//                           children: [
//                             Container(
//                               width: 85,
//                               height: 125,
//                               padding: EdgeInsets.only(
//                                   top: 10, bottom: 10, left: 8, right: 8),
//                               decoration: new BoxDecoration(
//                                 image: new DecorationImage(
//                                   image: new ExactAssetImage(
//                                       'assets/images/main/bg_sug.png'),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Container(
//                                     child: Image.asset(
//                                       'assets/images/main/sug2.png',
//                                       height: 40,
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(top: 4),
//                                     child: Text(
//                                       "ชำระค่าน้ำประปา\nและค่าขยะ",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Color(0xFFFFFFFF),
//                                           fontSize: 12),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => ComplainCateListView(
//                         //       isHaveArrow: "1",
//                         //     ),
//                         //   ),
//                         // );
//                         if (!isLogin) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginView(
//                                 isHaveArrow: "1",
//                               ),
//                             ),
//                           );
//                         } else {
//                           if (user.userclass == "member") {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => WebPageView(
//                                   isHaveArrow: "1",
//                                   title: "เบี้ยยังชีพผู้สูงอายุ",
//                                   cmd: "elder",
//                                 ),
//                               ),
//                             );
//                           } else {
//                             Toast.show(
//                                 "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
//                                 context,
//                                 duration: Toast.LENGTH_LONG,
//                                 gravity: Toast.BOTTOM);
//                           }
//                         }
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.28,
//                         child: Column(
//                           children: [
//                             Container(
//                               width: 85,
//                               height: 125,
//                               padding: EdgeInsets.only(
//                                   top: 0, bottom: 10, left: 8, right: 8),
//                               decoration: new BoxDecoration(
//                                 image: new DecorationImage(
//                                   image: new ExactAssetImage(
//                                       'assets/images/main/bg_sug.png'),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Container(
//                                     child: Image.asset(
//                                       'assets/images/main/sug7.png',
//                                       height: 45,
//                                     ),
//                                   ),
//                                   Container(
//                                     // margin: EdgeInsets.only(top: 4),
//                                     child: Text(
//                                       "เบี้ยยังชีพ\nผู้สูงอายุ",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Color(0xFFFFFFFF),
//                                           fontSize: 12),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // Navigator.push(
//                         //   context,
//                         //   MaterialPageRoute(
//                         //     builder: (context) => ExerListView(
//                         //       isHaveArrow: "1",
//                         //     ),
//                         //   ),
//                         // );
//                         if (!isLogin) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginView(
//                                 isHaveArrow: "1",
//                               ),
//                             ),
//                           );
//                         } else {
//                           if (user.userclass == "member") {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => WebPageView(
//                                   isHaveArrow: "1",
//                                   title: "เบี้ยยังชีพผู้พิการ",
//                                   cmd: "disabled",
//                                 ),
//                               ),
//                             );
//                           } else {
//                             Toast.show(
//                                 "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
//                                 context,
//                                 duration: Toast.LENGTH_LONG,
//                                 gravity: Toast.BOTTOM);
//                           }
//                         }
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.28,
//                         child: Column(
//                           children: [
//                             Container(
//                               width: 85,
//                               height: 125,
//                               padding: EdgeInsets.only(
//                                   top: 0, bottom: 10, left: 8, right: 8),
//                               decoration: new BoxDecoration(
//                                 image: new DecorationImage(
//                                   image: new ExactAssetImage(
//                                       'assets/images/main/bg_sug.png'),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Container(
//                                     child: Image.asset(
//                                       'assets/images/main/sug4.png',
//                                       height: 45,
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(top: 4),
//                                     // padding: EdgeInsets.only(bottom: 60),
//                                     child: Text(
//                                       "เบี้ยยังชีพ\nผู้พิการ",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Color(0xFFFFFFFF),
//                                           fontSize: 12),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         // if (!isLogin) {
//                         //   Navigator.push(
//                         //     context,
//                         //     MaterialPageRoute(
//                         //       builder: (context) => LoginView(
//                         //         isHaveArrow: "1",
//                         //       ),
//                         //     ),
//                         //   );
//                         // } else {
//                         //   if (user.userclass == "member") {
//                         //     Navigator.push(
//                         //       context,
//                         //       MaterialPageRoute(
//                         //         builder: (context) => WebPageView(
//                         //           isHaveArrow: "1",
//                         //           title: "ชำระค่าขยะ",
//                         //           cmd: "garbage",
//                         //         ),
//                         //       ),
//                         //     );
//                         //   } else {
//                         //     Toast.show(
//                         //         "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
//                         //         context,
//                         //         duration: Toast.LENGTH_LONG,
//                         //         gravity: Toast.BOTTOM);
//                         //   }
//                         // }
//                         if (!isLogin) {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => LoginView(
//                                 isHaveArrow: "1",
//                               ),
//                             ),
//                           );
//                         } else {
//                           if (user.userclass == "member") {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => WebPageView(
//                                   isHaveArrow: "1",
//                                   title: "เบี้ยยังชีพผู้ป่วยเอดส์",
//                                   cmd: "hiv",
//                                 ),
//                               ),
//                             );
//                           } else {
//                             Toast.show(
//                                 "User ดังกล่าวไม่สามารถใช้งานส่วนนี้ได้ หากต้องใช้งานกรุณาออกจากระบบ Admin ก่อน",
//                                 context,
//                                 duration: Toast.LENGTH_LONG,
//                                 gravity: Toast.BOTTOM);
//                           }
//                         }
//                       },
//                       child: Container(
//                         width: MediaQuery.of(context).size.width * 0.28,
//                         child: Column(
//                           children: [
//                             Container(
//                               width: 85,
//                               height: 125,
//                               padding: EdgeInsets.only(
//                                   top: 0, bottom: 10, left: 8, right: 8),
//                               decoration: new BoxDecoration(
//                                 image: new DecorationImage(
//                                   image: new ExactAssetImage(
//                                       'assets/images/main/bg_sug.png'),
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               child: Column(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceEvenly,
//                                 children: [
//                                   Container(
//                                     child: Image.asset(
//                                       'assets/images/main/sug12.png',
//                                       height: 40,
//                                     ),
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(top: 4),
//                                     child: Text(
//                                       "เบี้ยยังชีพ\nผู้ป่วยเอดส์ ",
//                                       textAlign: TextAlign.center,
//                                       style: TextStyle(
//                                           color: Color(0xFFFFFFFF),
//                                           fontSize: 12),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     Navigator.push(
//                     //       context,
//                     //       MaterialPageRoute(
//                     //         builder: (context) => PhoneCateListView(
//                     //           isHaveArrow: "1",
//                     //         ),
//                     //       ),
//                     //     );
//                     //   },
//                     //   child: Container(
//                     //     width: MediaQuery.of(context).size.width * 0.28,
//                     //     child: Column(
//                     //       children: [
//                     //         Container(
//                     //           width: 60,
//                     //           height: 80,
//                     //           padding: EdgeInsets.only(
//                     //               top: 30, bottom: 12, left: 8, right: 12),
//                     //           decoration: new BoxDecoration(
//                     //             image: new DecorationImage(
//                     //               image: new ExactAssetImage(
//                     //                   'assets/images/main/bg_sug.png'),
//                     //               fit: BoxFit.cover,
//                     //             ),
//                     //           ),
//                     //           child: Image.asset(
//                     //             'assets/images/main/sug11.png',
//                     //             height: 42,
//                     //           ),
//                     //         ),
//                     //         Container(
//                     //           margin: EdgeInsets.only(top: 4),
//                     //           child: Text(
//                     //             "หมายเลข\nโทรศัพท์ฉุกเฉิน",
//                     //             textAlign: TextAlign.center,
//                     //             style: TextStyle(
//                     //                 color: Color(0xFFFFFFFF), fontSize: 10),
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     if (!isLogin) {
//                     //       Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) => LoginView(
//                     //             isHaveArrow: "1",
//                     //           ),
//                     //         ),
//                     //       );
//                     //     } else {
//                     //       Navigator.push(
//                     //         context,
//                     //         MaterialPageRoute(
//                     //           builder: (context) => FollowComplainListView(
//                     //             isHaveArrow: "1",
//                     //           ),
//                     //         ),
//                     //       );
//                     //     }
//                     //   },
//                     //   child: Container(
//                     //     width: MediaQuery.of(context).size.width * 0.28,
//                     //     child: Column(
//                     //       children: [
//                     //         Image.asset(
//                     //           'assets/images/main/sug6.png',
//                     //           height: 42,
//                     //         ),
//                     //         Container(
//                     //           margin: EdgeInsets.only(top: 4),
//                     //           child: Text(
//                     //             "ติดตามเรื่อง\nร้องเรียน/ร้องทุกข์",
//                     //             textAlign: TextAlign.center,
//                     //             style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 10),
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                     // GestureDetector(
//                     //   onTap: () {
//                     //     _launchInBrowser(
//                     //         "http://csgcheck.dcy.go.th/public/eq/popSubsidy.do");
//                     //   },
//                     //   child: Container(
//                     //     width: MediaQuery.of(context).size.width * 0.28,
//                     //     child: Column(
//                     //       children: [
//                     //         Image.asset(
//                     //           'assets/images/main/sug8.png',
//                     //           height: 42,
//                     //         ),
//                     //         Container(
//                     //           margin: EdgeInsets.only(top: 4),
//                     //           child: Text(
//                     //             "อุดหนุน เด็กแรกเกิด",
//                     //             textAlign: TextAlign.center,
//                     //             style: TextStyle(color: Color(0xFFFFFFFF),fontSize: 10),
//                     //           ),
//                     //         ),
//                     //       ],
//                     //     ),
//                     //   ),
//                     // ),
//                   ],
//                 ),
//               ),
//               // Container(
//               //   padding: EdgeInsets.only(right: 8),
//               //   alignment: Alignment.centerRight,
//               //   child: GestureDetector(
//               //     onTap: () {
//               //       /* Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => ServiceGuideListView(
//               //             isHaveArrow: "1",
//               //           ),
//               //         ),
//               //       );*/

//               //       //เปลี่ยนใหม่
//               //       Navigator.push(
//               //         context,
//               //         MaterialPageRoute(
//               //           builder: (context) => EserviceView(
//               //             isHaveArrow: "1",
//               //           ),
//               //         ),
//               //       );
//               //     },
//               //     child: Image.asset(
//               //       'assets/images/main/more.png',
//               //       height: 24,
//               //     ),
//               //   ),
//               // )
//             ],
//           ),
//         ],
//       ),
    
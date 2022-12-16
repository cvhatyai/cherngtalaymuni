import 'package:cvapp/model/user.dart';
import 'package:cvapp/view/contactus/ContactusView.dart';
import 'package:cvapp/view/contactus/FollowContactusListView.dart';
import 'package:cvapp/view/login/LoginView.dart';
import 'package:flutter/material.dart';

class Contact2 extends StatefulWidget {
  @override
  _Contact2State createState() => _Contact2State();
}

class _Contact2State extends State<Contact2> {
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

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 550) / 2;
    final double itemWidth = size.width / 2;

    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFFE5CB),
      ),
      // margin: EdgeInsets.only(right: 8, left: 8, top: 0, bottom: 0),
      height: 180,
      // color: Color(0xFFf5f6fa),
      child: Row(
        children: <Widget>[
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
                      builder: (context) => ContactusView(
                        isHaveArrow: "1",
                      ),
                    ),
                  );
                }
              },
              child: Container(
                child: Image.asset('assets/images/banner-p1.png'),
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
                      builder: (context) => FollowContactusListView(
                        isHaveArrow: "1",
                      ),
                    ),
                  );
                }
              },
              child: Container(
                child: Image.asset('assets/images/banner-p2.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

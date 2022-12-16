import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cvapp/system/Info.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../AppBarView.dart';

var data;

class GeneralView extends StatefulWidget {
  GeneralView({Key key, this.isHaveArrow = ""}) : super(key: key);
  final String isHaveArrow;

  @override
  _GeneralViewState createState() => _GeneralViewState();
}

class _GeneralViewState extends State<GeneralView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    print(Info().baseUrl + 'app_api_v1/history_ios_preview');
    //getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        title: "ข้อมูลทั่วไปของเทศบาล",
        isHaveArrow: widget.isHaveArrow,
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        padding: EdgeInsets.only(left: 8, right: 8),
        child: WebView(
          initialUrl: Info().baseUrl + 'app_api_v1/history_ios_preview',
        ),
      ),
    );
  }
}

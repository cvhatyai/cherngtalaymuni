import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:http/http.dart' as http;
import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/system/Info.dart';

class MarqueeView extends StatefulWidget {
  @override
  _MarqueeViewState createState() => _MarqueeViewState();
}

class _MarqueeViewState extends State<MarqueeView> {
  String msg = "ยินดีต้อนรับ";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getMessageList();
  }

  getMessageList() async {
    Map _map = {};
    _map.addAll({});
    var body = json.encode(_map);
    return postMessageList(http.Client(), body, _map);
  }

  Future<List<AllList>> postMessageList(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().messageList),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
    var rs = json.decode(response.body);
    setState(() {
      msg = rs["msg"].toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: MediaQuery.of(context).size.width,
      child: Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new ExactAssetImage('assets/images/main/bg_marquee.png'),
            fit: BoxFit.cover,
            // alignment: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left:60.0,right: 20.0),
          child: Marquee(
            text: msg,
            blankSpace: 280,
            style: TextStyle(color: Colors.black,height: 0.5,),
          ),
        ),
      ),
    );
  }
}

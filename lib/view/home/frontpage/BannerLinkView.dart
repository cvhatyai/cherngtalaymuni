import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cvapp/model/listImageBanner.dart';
import 'package:cvapp/system/errorText.dart';
import 'package:cvapp/system/url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/system/Info.dart';
import 'package:url_launcher/url_launcher.dart';

var data;
var itemList;

class BannerLinkView extends StatefulWidget {
  @override
  _BannerLinkViewState createState() => _BannerLinkViewState();
}

class _BannerLinkViewState extends State<BannerLinkView> {
  //pm 2.5
  var pm25 = "";
  var time = "";
  var localtion = "";
  var link = "";

  void initState() {
    super.initState();
    setPm25();
  }

  setPm25() async {
    Map _map = {};
    _map.addAll({});
    var body = json.encode(_map);
    return postPmDetail(http.Client(), body, _map);
  }

  // ignore: missing_return
  Future<List<AllList>> postPmDetail(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().pm25),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
    var rs = json.decode(response.body);
    setState(() {
      pm25 = rs["pm25"].toString();
      time = rs["time"].toString();
      localtion = rs["localtion"].toString();
      link = rs["link"].toString();
    });
  }

  Widget pmView() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(
              "https://www.cherngtalaymuni.go.th/onestopservice/images/banner/pm.jpg"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                child: Text(
                  "PM 2.5",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0),
                ),
              ),
              Expanded(
                child: Container(
                  child: Center(
                    child: Text(
                      pm25.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 50.0),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: 20,
                child: Text(
                  "μg/m3",
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
                ),
              ),
              Expanded(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "สถานี : ${localtion.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.white),
                      ),
                      Text(
                        "อัพเดท : ${time.toString()}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                            color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                height: 1,
                color: Colors.black,
              ),
              Container(
                child: GestureDetector(
                  onTap: () {
                    Url().launchInBrowser(
                        "https://api.waqi.info/feed/@1844/?token=57c5f7bdeaab5ff83f13e3ba7554d7dc82976d1a");
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      children: [
                        Text(
                          "อ้างอิง : ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 12.0),
                        ),
                        Text(
                          "Link",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget pawnView() {
    return GestureDetector(
      onTap: () {
        Url().launchInBrowser("https://web.facebook.com/363354510369283");
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://www.cherngtalaymuni.go.th/onestopservice/images/banner/pawn.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  Widget goldView() {
    return GestureDetector(
      onTap: () {
        Url().launchInBrowser("https://www.goldtraders.or.th/");
      },
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                "https://www.cherngtalaymuni.go.th/onestopservice/images/banner/gold.png"),
            fit: BoxFit.fitHeight,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFffe5cb),
      child: CarouselSlider(
        options: CarouselOptions(
          height: 269.0,
          enlargeCenterPage: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlay: true,
          aspectRatio: 2.5,
          viewportFraction: 0.55,
        ),
        items: [pmView(), pawnView(), goldView()].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return i;
            },
          );
        }).toList(),
      ),
    );
  }
}

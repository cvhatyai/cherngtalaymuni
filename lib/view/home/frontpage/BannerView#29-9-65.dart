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
List<String> imgList = [];

class BannerView extends StatefulWidget {
  @override
  _BannerViewState createState() => _BannerViewState();
}

class _BannerViewState extends State<BannerView> {
  int _currentPage = 0;
  final _currentDot = 0;

  // start---------------- Get Data From DATABASES
  Future<List<ListBannerImg>> fetchBannerImg(http.Client client) async {
    final response = await client.get(Uri.parse(Info().bannerList));
    return parseBannerImg(response.body);
  }

  List<ListBannerImg> parseBannerImg(String responseBody) {
    imgList.clear();
    data = [];
    data.addAll(json.decode(responseBody));

    if (data != null && data.length != 0) {
      for (var i = 0; i < data.length; i++) {
        imgList.add(data[i]['display_image'].toString());
      }
    }

    print("imgList :" + imgList.length.toString());

    var list = jsonDecode(responseBody);

    return list
        .map<ListBannerImg>((json) => ListBannerImg.fromJson(json))
        .toList();
  }

  // end---------------- Get Data From DATABASES

  Widget theIndicator(_currentPage, index) {
    if (_currentPage == index) {
      return Container(
        width: 24.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(20.0),
          ),
          color: Color(0xFF5A1E8E),
        ),
      );
    } else {
      return Container(
        width: 8.0,
        height: 8.0,
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFFB4B4B4),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      margin: const EdgeInsets.only(left: 4.0, right: 4.0),
      width: MediaQuery.of(context).size.width,
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new ExactAssetImage('assets/images/top-news.png'),
          fit: BoxFit.cover,
          alignment: Alignment.topCenter,
        ),
        color: Color(0xFFEEF4FB),
      ),
      child: Column(
        children: [
          Column(
            children: [
              Container(height: 60),
              Container(
                child: FutureBuilder<List<ListBannerImg>>(
                  future: fetchBannerImg(http.Client()),
                  // ignore: missing_return
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                        return noConnect();
                      case ConnectionState.waiting:
                        return Center(
                          child: CupertinoActivityIndicator(),
                        );
                      case ConnectionState.active:
                        break;
                      case ConnectionState.done:
                        if (snapshot.data.length > 0) {
                          return DisplayBanner(banner: snapshot.data);
                        } else {
                          List<dynamic> _listImages = [
                            'assets/images/nopic_banner.png'
                          ]
                              .map(
                                (item) => Container(
                                  child: Container(
                                    // margin: EdgeInsets.all(5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      child: Stack(
                                        children: <Widget>[
                                          InkWell(
                                            onTap: () {
                                              print('Banner Emtry');
                                            },
                                            child: Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.8,
                                                child: Image(
                                                  image: AssetImage(
                                                      "assets/images/nopic_banner.png"),
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          // Image.network(item, fit: BoxFit.cover, width: 1000.0),
                                          Positioned(
                                            bottom: 0.0,
                                            left: 0.0,
                                            right: 0.0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color.fromARGB(
                                                        100, 0, 0, 0),
                                                    Color.fromARGB(100, 0, 0, 0)
                                                  ],
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                ),
                                              ),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.0,
                                                  horizontal: 10.0),
                                              child: Text(
                                                'ทต.เชิงทะเล',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.normal),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList();
                          return Container(
                            child: Column(
                              children: [
                                CarouselSlider(
                                  items: _listImages,
                                  options: CarouselOptions(
                                      autoPlay: false,
                                      aspectRatio: 2.5,
                                      enlargeCenterPage: true,
                                      onPageChanged: (index, reason) {
                                        setState(() {
                                          _currentPage = index;
                                        });
                                      }),
                                ),
                              ],
                            ),
                          );
                        }
                        break;
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(padding: EdgeInsets.all(5)),
        ],
      ),
    );
  }
}

class DisplayBanner extends StatelessWidget {
  final List<ListBannerImg> banner;
  DisplayBanner({Key key, this.banner}) : super(key: key);

  _import(BuildContext context) {
    if (banner.length > 0) {
      List<ListBannerImg> _list = banner;
      List<dynamic> _listImages = _list
          .map(
            (item) => Container(
              child: Container(
                // margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          item.url != ''
                              ? Url().launchInBrowser(item.url)
                              : print('${item.subject}');
                        },
                        child: item.display_image != ''
                            ? Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Image.network(
                                  item.display_image,
                                  fit: BoxFit.cover,
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                child: Image(
                                  image: AssetImage("assets/images/nopic.png"),
                                  fit: BoxFit.cover,
                                )),
                      ),
                      // Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(100, 0, 0, 0),
                                Color.fromARGB(100, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Text(
                            '${item.subject}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList();
      return _listImages;
    } else {
      List<dynamic> _listImages = ['assets/images/nopic.png']
          .map(
            (item) => Container(
              child: Container(
                // margin: EdgeInsets.all(5.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          print('Banner Emtry');
                        },
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Image(
                              image: AssetImage("assets/images/nopic.png"),
                              fit: BoxFit.cover,
                            )),
                      ),
                      // Image.network(item, fit: BoxFit.cover, width: 1000.0),
                      Positioned(
                        bottom: 0.0,
                        left: 0.0,
                        right: 0.0,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color.fromARGB(100, 0, 0, 0),
                                Color.fromARGB(100, 0, 0, 0)
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Text(
                            'ข้อมูลทดสอบ',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList();
      return _listImages;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider(
            items: _import(context),
            options: CarouselOptions(
              enlargeCenterPage: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              autoPlay: true,
              aspectRatio: 2.5,
              viewportFraction: 1,
            ),
          ),
        ],
      ),
    );
  }
}

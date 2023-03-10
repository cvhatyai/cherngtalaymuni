import 'dart:async';
import 'dart:convert';

import 'package:cvapp/model/AllList.dart';
import 'package:cvapp/system/Info.dart';
import 'package:cvapp/view/travel/TravelDetailView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../AppBarView.dart';

var data;

class NearMeView extends StatefulWidget {
  NearMeView({Key key, this.isHaveArrow = ""}) : super(key: key);
  final String isHaveArrow;

  @override
  _NearMeViewState createState() => _NearMeViewState();
}

class _NearMeViewState extends State<NearMeView> {
  final Map<String, Marker> _markers = {};
  BitmapDescriptor pinTravel;
  BitmapDescriptor pinOtop;
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(14.528441198365755, 100.91146731187848),
    zoom: 11,
  );
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setCustomMapPin();
    getMapList();
  }

  void setCustomMapPin() async {
    pinTravel = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)),
        'assets/images/travel/pin_travel.png');
    pinOtop = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)),
        'assets/images/travel/pin_otop.png');
  }

  getMapList() async {
    Map _map = {};
    EasyLoading.show(status: 'loading...');
    print("_map : " + _map.toString());
    var body = json.encode(_map);
    return postMapList(http.Client(), body, _map);
  }

  Future<List<AllList>> postMapList(
      http.Client client, jsonMap, Map map) async {
    final response = await client.post(Uri.parse(Info().nearMe),
        headers: {"Content-Type": "application/json"}, body: jsonMap);
    parseMapList(response.body);
  }

  List<AllList> parseMapList(String responseBody) {
    // print("responseBodyList1" + responseBody);
    data = [];
    data.addAll(json.decode(responseBody));
    // print("responseBodyList2" + data.toString());
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    parsed.map<AllList>((json) => AllList.fromJson(json)).toList();
    setState(() {
      _markers.clear();
      for (var i = 0; i < data.length; i++) {
        final marker = Marker(
          icon: (data[i]["cmd"] == "travel") ? pinTravel : pinOtop,
          markerId: MarkerId(data[i]["id"] + '_' + data[i]["cmd"]),
          position: LatLng(
              double.parse(data[i]["lat"]), double.parse(data[i]["lng"])),
          infoWindow: InfoWindow(
              title: data[i]["subject"],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TravelDetailView(
                      topicID: data[i]["id"].toString(),
                      title: data[i]["title"],
                      tid: data[i]["tid"],
                    ),
                  ),
                );
              }
              //snippet: office.address,
              ),
        );
        _markers[data[i]["id"] + '_' + data[i]["cmd"]] = marker;
      }
    });
    EasyLoading.dismiss();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarView(
        title: "?????????????????????",
        isHaveArrow: widget.isHaveArrow,
      ),
      body: Container(
        color: Color(0xFFFFFFFF),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: _markers.values.toSet(),
        ),
      ),
    );
  }
}

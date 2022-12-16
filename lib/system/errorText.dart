import 'package:flutter/material.dart';

Widget noConnect() {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        height: 40.0,
      ),
      Text(
        '- 404 Error -',
        style: TextStyle(fontSize: 16, color: Colors.grey),
      ),
    ],
  );
}

Widget noData() {
  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      SizedBox(
        height: 40.0,
      ),
      Text(
        'ไม่มีข้อมูล',
        style: TextStyle(
            fontSize: 16,
            color: Colors.grey),
      ),
    ],
  );
}

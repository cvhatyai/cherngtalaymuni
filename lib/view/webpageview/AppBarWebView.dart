import 'package:flutter/material.dart';
import 'package:cvapp/view/phone/PhoneDetailView.dart';
import 'package:cvapp/view/phone/PhoneEditView.dart';

class AppBarWebView extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String isHaveArrow;
  final String urlweb;

  
  AppBarWebView({
    Key key,
    this.title = "",
    this.isHaveArrow = "",
    this.urlweb = "",
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  _AppBarWebViewState createState() => _AppBarWebViewState();
}

class _AppBarWebViewState extends State<AppBarWebView> {

  leading() {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        color: Color(0xFF843B0A),
      ),
      child: IconButton(
        icon: Center(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.white,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
            color: Color(0xFF5A1E8E),
          ),
          child: AppBar(
            leading: (widget.isHaveArrow == "") ? Container() : leading(),
            titleSpacing: 0,
            title: Text(
              widget.title,
              style: TextStyle(
                fontSize: 23,
                color: Color(0xFFFFFFFF),
                fontFamily: 'Kanit',
              ),
            ),
            elevation: 0,
            centerTitle: true,
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

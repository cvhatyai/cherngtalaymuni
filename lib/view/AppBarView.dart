import 'package:flutter/material.dart';
import 'package:cvapp/view/phone/PhoneDetailView.dart';
import 'package:cvapp/view/phone/PhoneEditView.dart';

class AppBarView extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  final String isHaveArrow;

  AppBarView({
    Key key,
    this.title = "",
    this.isHaveArrow = "",
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  _AppBarViewState createState() => _AppBarViewState();
}

class _AppBarViewState extends State<AppBarView> {
  leading() {
    return Container(
      // height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        // color: Color(0xFF843B0A),
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
            flexibleSpace: Image(
              image: AssetImage(
                'assets/images/app_bar.png',
              ),
              fit: BoxFit.cover,
              alignment: Alignment.center,
            ),
            backgroundColor: Colors.transparent,
          ),
        ),
      ),
    );
  }
}

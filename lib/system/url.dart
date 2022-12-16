// import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:url_launcher/url_launcher.dart';

class Url {
  Future<void> launchInBrowser(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
    // if (await canLaunch(url)) {
    //   await launch(
    //     url,
    //     forceSafariVC: false,
    //     forceWebView: false,
    //     headers: <String, String>{'header_key': 'header_value'},
    //   );
    // } else {
    //   throw 'Could not launch $url';
    // }
  }

  // iOS
  // pubspac > url_launcher: ^5.5.0
  // กำหนด Browser ใน ios/Runner/info.plist
  // <dict>
  // .....
  // <key>LSApplicationQueriesSchemes</key>
  // <array>
  // 		<string>youtube</string>
  // 		<string>safari</string>
  // 		<string>chrome</string>
  // </array>
  //   .....
  // </dict>

  // -------------
  // Future<void> download(String url) async {
  //   print(download);
  //   await FlutterDownloader.enqueue(
  //     url: url,
  //     savedDir: 'the path of directory where you want to save downloaded files',
  //     showNotification:
  //         true, // show download progress in status bar (for Android)
  //     openFileFromNotification:
  //         true, // click on notification to open downloaded file (for Android)
  //   );
  // }

  Url() : super();
}

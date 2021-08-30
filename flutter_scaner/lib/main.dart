import 'package:flutter/material.dart';
import 'package:flutter_scaner/scan_page.dart';
import 'package:flutter_scaner/register_page.dart';
import 'package:flutter_scaner/userPermission_Page.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String TestString = "test";
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //theme:
      //    ThemeData(textTheme: TextTheme(bodyText2: TextStyle(fontSize: 24))),
      debugShowCheckedModeBanner: false,
      initialRoute: "/Permission",
      routes: {
        "/Permission": (context) => PermissionPage(),
        "/Register": (context) => RegisterPage(),
        "/Scan": (context) => ScanPage(),
      },
      builder: (context, child) {
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        );
      },
    );
  }

  void _permission() async {
    if (await Permission.camera.status.isGranted) {
      Navigator.pushNamed(context, "/Register");
    }
  }
}

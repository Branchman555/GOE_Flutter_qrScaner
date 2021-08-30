import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:permission_handler/permission_handler.dart';
import 'package:wrapped_korean_text/wrapped_korean_text.dart';

class PermissionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => myTest(context));
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 80,
          ),
          Container(
            alignment: Alignment.center,
            child: Text("앱 사용전 아래 권한을 허용해주세요",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  void myTest(BuildContext context) {
    _permissionStatus(context);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            "앱 접근 권한 안내",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          content: _PermissionDetail(),
          actions: <Widget>[
            TextButton(
              child: new Text("OK"),
              onPressed: () {
                _permissionRequest();
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pushNamed(context, "/Register");
                print("Test My");
              },
            ),
          ],
        );
      },
    );
  }

  Widget _PermissionDetail() {
    return Container(
      height: 150,
      child: SingleChildScrollView(
        child: Container(
          height: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.blue,
                height: 3,
              ),
              SizedBox(
                height: 30,
              ),
              _IconWithDetail(Icons.camera, "카메라", "QR인식을 위해 사용합니다."),
              //_IconWithDetail(Icons.storage, "저장매체", "학교정보를 저장하기위해 사용합니다."),
            ],
          ),
        ),
      ),
    );
  }

  Widget _IconWithDetail(IconData icon, String title, String detail,
      [bool necessary = true]) {
    String necText = "필수";
    if (!necessary) {
      necText = "선택";
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.blueAccent,
        ),
        SizedBox(
          width: 10,
        ),
        Container(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "[$necText]",
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " $title",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              WrappedKoreanText(
                "$detail",
                style: TextStyle(
                  color: Colors.blueGrey,
                  fontSize: 12.0,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  void _permissionStatus(BuildContext context) async {
    if (await Permission.camera.status.isGranted) {
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.pushNamed(context, "/Register");
    }
  }

  void _permissionRequest() async {
    if (await Permission.camera.request().isGranted) {
      print("Camera granted");
    } else {
      print("Not granted");
      //SystemNavigator.pop();
    }
  }
}

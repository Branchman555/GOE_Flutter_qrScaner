import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_scaner/components/send_data.dart';

class RegisterPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _school_name = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: AlignmentDirectional.center,
        color: Colors.white,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 120,
              ),
              Image.asset(
                'assets/GOE_BI.png',
                width: 300,
              ),
              SizedBox(
                height: 20,
              ),
              Text("물품정보조회 시스템",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 50,
              ),
              Text("현재 학교를 등록해주세요",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 30,
              ),
              Container(
                width: 350,
                child: TextFormField(
                  validator: (value) => value!.isEmpty ? "학교를 입력해주세요" : null,
                  controller: _school_name,
                  decoration: InputDecoration(
                      hintText: "학교 명",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.pushNamed(context, "/Scan",
                          arguments: screen_data(_school_name.text.toString()));
                    } else {
                      showCupertinoDialog(
                          context: context,
                          builder: (context) => CupertinoAlertDialog(
                                title: Text("학교를 입력해주세요"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: Text("확인"),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  )
                                ],
                              ));
                    }
                  },
                  child: Text("학교 등록",
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold))),
            ],
          ),
        ),
      ),
    );
  }
}

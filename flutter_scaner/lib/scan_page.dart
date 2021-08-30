import 'dart:async';
import 'package:flutter/material.dart';
import 'package:qrscan/qrscan.dart' as scanner; //qrscan 패키지를 scanner 별칭으로 사용.
import 'package:flutter_scaner/components/custom_form.dart';
import 'package:flutter_scaner/components/send_data.dart';
import 'package:flutter_scaner/keyBox.dart';

const double test_width = 300;
const double test_height = 30;

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String _output = "";
  List<String> parsedData = [""];
  String schoolName = "";

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as screen_data;
    schoolName = args.name;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 150,
            ),
            Image.asset(
              'assets/GOE_BI.png',
              width: 300,
            ),
            SizedBox(
              height: 50,
            ),
            Text('우측 하단의 버튼을 눌러 코드를 스캔해주세요',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold)),
            SizedBox(
              height: 50,
            ),
            CForm(schoolName, parsedData),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _scan(),
        tooltip: 'scan',
        child: const Icon(Icons.camera_alt),
      ),
    );
  }

  Future _scan() async {
    //스캔 시작 - 이때 스캔 될때까지 blocking
    String? barcode = await scanner.scan();
    //FilePickerResult? result = await FilePicker.platform.pickFiles();

    // if (result != null) {
    //   String? ttst = result.files.single.path;
    //   print(ttst);
    //   String? barcode = await scanner.scanPath(ttst!);
    //   print(barcode);
    // } else {
    //   // User canceled the picker
    //   print("NO PATH");
    // }
    //String? barcode = await scanner
    //    .scanPath('/document/raw:/storage/emulated/0/Download/TEST4.jpg');
    //스캔 완료하면 _output 에 문자열 저장하면서 상태 변경 요청.
    //print(barcode);
    setState(() {
      _output = (barcode != null ? barcode : "");
      parsedData = _parseData(schoolName, _output);
      print(parsedData);
    });
  }

  List<String> _parseData(String mykey, String encryptedData) {
    final myEncrypter = encryptModule();
    myEncrypter.registerKey(mykey);
    myEncrypter.decryptText(encryptedData);

    List<String> resultData = [];
    final decryptedData = myEncrypter.decryptText(encryptedData);

    if (decryptedData == "-1") {
      resultData.add("-1");
    } else if (decryptedData == "") {
      resultData.add("");
    } else {
      resultData = myEncrypter.decryptText(encryptedData).split('%');
    }
    return resultData;
  }
}

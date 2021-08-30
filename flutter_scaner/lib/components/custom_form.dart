import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_scaner/keyBox.dart';

const double test_width = 300;
const double test_height = 30;

Widget CForm(String myKey, List<String> parsedData) {
  Widget returnWidget;

  if (parsedData[0] == "-1") {
    returnWidget = Container(
      child: Center(
        child: Text(
          "잘못된 QR 코드입니다",
          style: TextStyle(
            fontSize: 16.0,
            color: Colors.red,
          ),
        ),
      ),
    );
  } else if (parsedData[0] == "") {
    returnWidget = Container(
      child: Center(
        child: Text("QR코드를 스캔해주세요",
            style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  } else {
    returnWidget = Column(children: [
      Text("물품 정보를 스캔했습니다",
          style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold)),
      SizedBox(
        height: 15,
      ),
      Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.black, width: 2)),
        alignment: Alignment.center,
        width: 354,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //_buildLine(test_width, 1),
            Container(
              //padding: const EdgeInsets.all(3.0),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black54)),
              alignment: Alignment.center,
              width: 350,
              height: test_height,
              child: Text(myKey),
            ),
            //_buildLine(test_width, 1),
            _smallCell("분류번호", parsedData[0], 350),
            //_buildLine(test_width, 1),
            _smallCell("품명", parsedData[1], 350),
            //_buildLine(test_width, 1),
            _smallCell("규격", parsedData[2], 350, 40),
            //_buildLine(test_width, 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _smallCell("운용부서", parsedData[3], 175),
                //_buildLine(1, test_height),
                _smallCell("설치장소", parsedData[4], 175),
              ],
            ),
            //_buildLine(test_width, 1),
            _smallCell("비고", parsedData[5], 350),
            //_buildLine(test_width, 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _smallCell("취득일", parsedData[6], 175),
                //_buildLine(1, test_height),
                _smallCell("고유번호", parsedData[7], 175),
              ],
            ),
            //_buildLine(test_width, 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _smallCell("단가", parsedData[8], 175),
                //_buildLine(1, test_height),
                _smallCell("내용연수", parsedData[9], 175),
              ],
            ),
            //_buildLine(test_width, 1),
          ],
        ),
      ),
    ]);
  }
  print("TEST P2");
  print(parsedData);
  return returnWidget;
}

Widget _smallCell(String mtitle, String mdata, double size,
    [double height = test_height]) {
  final titleWidth = 60.0;
  print("TEST P3");
  print(mdata);
  return Container(
    //padding: const EdgeInsets.all(3.0),
    alignment: Alignment.center,
    decoration: BoxDecoration(border: Border.all(color: Colors.black54)),
    width: size,
    height: height,
    child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            width: titleWidth,
            //height: test_height,
            child: Text(
              mtitle,
              textAlign: TextAlign.center,
            ),
          ),
          _buildLine(2, height),
          Container(
              margin: const EdgeInsets.only(left: 5.0),
              alignment: Alignment.centerLeft,
              width: size - titleWidth - 15,
              //height: height,
              child: Text(
                mdata,
                textAlign: TextAlign.center,
              )),
        ]),
  );
}

Widget _buildLine(double width, double height) {
  return Container(
    width: width,
    height: height,
    color: Colors.black54,
  );
}

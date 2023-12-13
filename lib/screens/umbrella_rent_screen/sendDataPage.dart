import 'package:flutter/material.dart';
import 'package:umbrellafinish/screens/rentING_screen.dart';


class SendDataPage extends StatefulWidget {
  final int scanData;

  SendDataPage({required this.scanData});

  @override
  _SendDataPageState createState() => _SendDataPageState();
}

class _SendDataPageState extends State<SendDataPage> {
  late TextEditingController umbrellaIdController;
  late TextEditingController renterIdController;

  @override
  void initState() {
    super.initState();
    umbrellaIdController = TextEditingController(text: '${widget.scanData}');
    renterIdController = TextEditingController(text: '${widget.scanData}');
  }

  @override
  void dispose() {
    umbrellaIdController.dispose();
    renterIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Data Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: umbrellaIdController,
              decoration: InputDecoration(labelText: 'Umbrella ID'),
              keyboardType: TextInputType.number, // 숫자 입력을 위한 키보드 타입
            ),
            TextFormField(
              controller: renterIdController,
              decoration: InputDecoration(labelText: 'Renter ID'),
              keyboardType: TextInputType.number, // 숫자 입력을 위한 키보드 타입
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _sendDataToFirebase(
                  umbrellaIdController.text,
                  renterIdController.text,
                );
                Navigator.pop(context);
              },
              child: Text('전송하기'),
            ),
          ],
        ),
      ),
    );
  }

  void _sendDataToFirebase(String umbrellaId, String renterId) {
    print('Umbrella ID: $umbrellaId, Renter ID: $renterId');
    // Firebase로 데이터 전송 등의 작업 수행


    // 전송 완료 알림
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('전송 완료'),
          content: Text('전송이 완료 되었습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // '전송하기'를 누르면 1초 후 rentING_screen으로 이동
                Navigator.of(context).popUntil((route) => route.isFirst);
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => rentIngScreen()), // RentINGScreen 클래스로 이동
                  );
                });
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}



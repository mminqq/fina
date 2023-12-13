import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:umbrellafinish/screens/home_screen.dart';


class ReturnDataPage extends StatefulWidget {
  final int scanData;

  ReturnDataPage({required this.scanData});

  @override
  _ReturnDataPageState createState() => _ReturnDataPageState();
}

class _ReturnDataPageState extends State<ReturnDataPage> {
  late TextEditingController dataController;

  @override
  void initState() {
    super.initState();
    dataController = TextEditingController(text: '${widget.scanData}');
  }

  @override
  void dispose() {
    dataController.dispose();
    super.dispose();
  }

  Future<void> _sendDataToFirebase(int data) async {
    try {
      // Firebase로 데이터 전송
      await FirebaseFirestore.instance.collection('your_collection').add({
        'data': data,
      });
      // 데이터가 성공적으로 Firebase에 추가되었을 때
      await _deleteDataFromFirebase(data);
    } catch (e) {
      print('Firebase에 데이터를 추가하는 중에 오류가 발생했습니다: $e');
      // 오류 처리
    }
  }

  Future<void> _deleteDataFromFirebase(int data) async {
    try {
      // Firebase에서 데이터 삭제
      await FirebaseFirestore.instance
          .collection('your_collection')
          .where('data', isEqualTo: data)
          .get()
          .then((snapshot) {
        for (DocumentSnapshot doc in snapshot.docs) {
          doc.reference.delete();
        }
      });
      // 데이터가 Firebase에서 성공적으로 삭제되었을 때
      _showCompletionDialog();
    } catch (e) {
      print('Firebase에서 데이터를 삭제하는 중에 오류가 발생했습니다: $e');
      // 오류 처리
    }
  }

  Future<void> _showCompletionDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('완료되었습니다'),
          content: Text('데이터가 성공적으로 처리되었습니다.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Return Data Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              controller: dataController,
              decoration: InputDecoration(labelText: 'Data'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                int data = int.parse(dataController.text);
                _sendDataToFirebase(data);
              },
              child: Text('전송하기'),
            ),
          ],
        ),
      ),
    );
  }
}

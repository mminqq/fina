import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../services/firebase_service.dart';
import '../screens/returnDataPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class QRCodeReturnScanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _QRCodeReturnScannerState();
}

class _QRCodeReturnScannerState extends State<QRCodeReturnScanner> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late QRViewController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code 반납 Scanner'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.blue, // Change color for clarity
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) async {
      int qrData = scanData.code as int; // 혹은 int qrData = int.parse(scanData.code);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ReturnDataPage(
            scanData: qrData, // 수정된 부분
          ),
        ),
      );
    });
  }



  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

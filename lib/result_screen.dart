import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/qr_scanner.dart';

class ResultScreen extends StatelessWidget {
  final String code;
  final Function() closescreen;

  const ResultScreen(
      {super.key, required this.closescreen, required this.code});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black87,
            )),
        title: const Text(
          "QR Scanner",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            QrImage(
              data: code,
              size: 150,
              version: QrVersions.auto,
            ),
            Text(
              "Scanned Result",
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "code",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black87, fontSize: 16, letterSpacing: 1),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: code));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                height: 48,
                child: const Text(
                  "Copy",
                  style: TextStyle(
                      color: Colors.black87, fontSize: 16, letterSpacing: 1),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

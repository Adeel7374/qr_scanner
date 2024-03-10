import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/result_screen.dart';

const bgColor = Color(0xfffafafa);

class QRScanner extends StatefulWidget {
  const QRScanner({super.key});

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  bool isScanCompleted = false;
  bool isFlashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();

  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: bgColor,
        drawer: const Drawer(),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  if (isFlashOn) {
                    setState(() {
                      isFlashOn = !isFlashOn;
                    });
                    controller.toggleTorch();
                  }
                },
                icon: Icon(
                  Icons.flash_on,
                  color: isFlashOn ? Colors.blue : Colors.grey,
                )),
            IconButton(
                onPressed: () {
                  {
                    setState(() {
                      isFrontCamera = !isFrontCamera;
                    });
                    controller.switchCamera();
                  }
                },
                icon: Icon(
                  Icons.camera_front,
                  color: isFrontCamera ? Colors.blue : Colors.grey,
                ))
          ],
          iconTheme: IconThemeData(color: Colors.black87),
          centerTitle: true,
          title: const Text(
            "QR Code",
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                letterSpacing: 1),
          ),
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  children: const [
                    Text(
                      "Place the QR Code in this area",
                      style: TextStyle(
                          color: Colors.black87,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Scanning will be start automatically",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Stack(
                    children: [
                      MobileScanner(
                        controller: controller,
                        allowDuplicates: true,
                        onDetect: (barcode, args) {
                          if (!isScanCompleted) {
                            String code = barcode.rawValue ?? '---';
                            isScanCompleted = true;
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ResultScreen(
                                    closescreen: closeScreen,
                                    code: code,
                                  ),
                                ));
                          }
                        },
                      ),
                      // (Overlay(
                      //   clipBehavior: Clip.antiAlias,
                      // ))
                      // QRScannerOverlay(OverlayColour:bgColor),
                    ],
                  )),
              Expanded(
                  child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Developed By Adeel Devs",
                  style: TextStyle(
                      color: Colors.black87, fontSize: 14, letterSpacing: 1),
                ),
              ))
            ],
          ),
        ));
  }
}

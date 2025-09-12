import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'form_page.dart';  // <- IMPORTAR AQUI

class QrScannerPage extends StatelessWidget {
  const QrScannerPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear QR Code'),
        backgroundColor: const Color(0xFF2E2E2E),
      ),
      body: MobileScanner(
        allowDuplicates: false,
        onDetect: (barcode, args) {
          final String? code = barcode.rawValue;
          if (code != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => FormPage(qrCode: code),
              ),
            );
          }
        },
      ),
    );
  }
}

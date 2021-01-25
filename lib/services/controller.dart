// @dart=2.9

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:inventario/services/models.dart';

class Controller extends GetxController {
  var scanBarcode = '000000'.obs;
  var title = 'título'.obs;

  Future<void> scanBarcodeNormal() async {
    var barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    scanBarcode.value = barcodeScanRes;
    update();
  }

  void changeValue() {
    scanBarcode.value = "novo valor";
    print('change value');
  }

  void alterSheet(String barcode) {
    var file = 'C:/Users/Carlos Ferian/OneDrive/ADS/flutter/Dart/teste1.xlsx';
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    var sheet = excel['minha'];

    CellStyle cellStyle = CellStyle(
        bold: true,
        italic: true,
        fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
        backgroundColorHex: '#faf487');

    // alterando o arquivo:
    for (int row = 0; row < sheet.maxRows; row++) {
      sheet.row(row).forEach((cell) {
        if (cell.value == barcode) {
          cell.value = cell.value + 'encontrado';
          cell.style = cellStyle;
          print(cell.value);
        }
      });
    }
    // Saving the file

    String outputFile =
        "C:/Users/Carlos Ferian/OneDrive/ADS/flutter/Dart/teste1.xlsx";
    excel.encode().then((onValue) {
      File(join(outputFile))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
  }

  void bookTitle(barcode) async {
    var file = 'C:/Users/Carlos Ferian/OneDrive/ADS/flutter/Dart/teste1.xlsx';
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        if (row[0] == barcode) {
          title.value = await row[1];
          break;
        }
      }
    }
  }

  Text checkInformation() {
    return Text(
        'Dados da leitura:\nCódigo de Barras : \t${this.scanBarcode}\nTítulo : \t${this.title}',
        style: TextStyle(fontSize: 20));
  }
}

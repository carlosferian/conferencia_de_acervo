// @dart=2.9

import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:inventario/pages/resultado.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:android_path_provider/android_path_provider.dart';

class Controller extends GetxController {
  var scanBarcode = '000000'.obs;
  var title = 'título'.obs;
  var appDirectory = ''.obs;

  Future<void> initAndroidPath() async {
    String downloadsPath;
    String documentsPath;

    try {
      downloadsPath = await AndroidPathProvider.downloadsPath;
      documentsPath = await AndroidPathProvider.documentsPath;
    } on PlatformException {}
    this.appDirectory.value = documentsPath;
  }

  Future<void> scanBarcodeNormal() async {
    initAndroidPath();
    var barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancelar", true, ScanMode.BARCODE);
      //print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }
    this.scanBarcode.value = barcodeScanRes;
    bookDataAsset(barcodeScanRes);
    //alterSheetDocument(barcodeScanRes);
    
  }

  Future<void> infoManual(barcode) async {
    print('-----código de barras $barcode -----');
    initAndroidPath();
    this.scanBarcode.value = await barcode;
    bookDataAsset(barcode);
    //alterSheetDocument(barcode);
    Get.off(Result());
  }

  void bookDataAsset(barcode) async {
    RegExp barcodePattern = new RegExp('.?$barcode.?');
    var titleFromSheet = 'Não localizado';
    var file = this.appDirectory + '/teste1.xlsx';
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (int row = 0; row < excel.tables[table].maxRows; row++) {
        //if (excel.tables[table].rows[row][0] == barcode)
        if (barcodePattern
            .hasMatch(excel.tables[table].rows[row][0].toString())) {
          if (excel.tables[table].rows[row][0]
              .toString()
              .startsWith('localizado')) {
            titleFromSheet = 'Item já processado';
            print('já foi localizado');
            break;
          } else {
            titleFromSheet = excel.tables[table].rows[row][1];
            break;
          }
        }
      }
    }
    this.title.value = titleFromSheet;
  }

  void alterSheetDocument(barcode) async {
    var file = this.appDirectory + '/teste1.xlsx';
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    // alterando o arquivo:
    Sheet sheetObject = excel['minha'];

    for (var table in excel.tables.keys) {
      for (int row = 0; row < excel.tables[table].maxRows; row++) {
        if (excel.tables[table].rows[row][0] == barcode) {
          print(excel.tables[table].rows[row][0]);
          var cell = sheetObject.updateCell(
              CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: row),
              'localizado $barcode');
        }
      }
    }

    excel.encode().then((onValue) {
      File(join(this.appDirectory + '/teste1.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
  }
}

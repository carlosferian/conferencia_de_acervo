// @dart=2.9

import 'dart:async';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:path/path.dart';

void main() {
  /*Future<String> bookTitleAsset(barcode) async {
    var titleFromSheet = "";

    ByteData data = await rootBundle.load(r'lib\assets\teste1.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        if (row[0] == barcode) {
          titleFromSheet = row[1];
          break;
        } else {
          titleFromSheet = "Item não localizado";
        }
      }
    }
    //print(titleFromSheet);
    return titleFromSheet;
  }*/

  //print(bookTitleAsset(134));

  /*String bookTitle(barcode) {
    var titleFromSheet = '';
    var file = r'lib\assets\teste1.xlsx';
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table].rows) {
        if (row[0] == barcode) {
          titleFromSheet = row[1];
          break;
        } else {
          titleFromSheet = "Item não localizado";
        }
      }
    }
    //print(titleFromSheet);
    return titleFromSheet;
  }*/

  //print(bookTitle(78408194));

/*
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
  }*/

  void alterSheet(barcode) async {
    ByteData data = await rootBundle
        .load('C:/Users/Carlos Ferian/OneDrive/ADS/flutter/Dart/teste1.xlsx');
    var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
    var excel = Excel.decodeBytes(bytes);
    var sheet = excel['minha'];

    // alterando o arquivo:
    for (int row = 0; row < sheet.maxRows; row++) {
      sheet.row(row).forEach((cell) {
        print('procurando combinação');
        if (cell.value == barcode) {
          cell.value += ' encontrado';
          print(
              'linha $row, celula ${cell.value}, tipo ${cell.value.runtimeType}');
        }
      });
    }

    excel.encode().then((onValue) {
      File(join('C:/Users/Carlos Ferian/OneDrive/ADS/flutter/Dart/teste1.xlsx'))
        ..createSync(recursive: true)
        ..writeAsBytesSync(onValue);
    });
  }

  alterSheet(78408194);
}
   
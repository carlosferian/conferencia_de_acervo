// @dart=2.9

import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';

//recebe um código de barras lido pela câmera e altera a planilha

void alteraPlanilha(String cdBarras) {
  var file =
      'C:/Users/Carlos Ferian/OneDrive/ADS/flutter/Dart/teste1.xlsx';
  var bytes = File(file).readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

    CellStyle cellStyle = CellStyle(
      bold: true,
      italic: true,
      fontFamily: getFontFamily(FontFamily.Comic_Sans_MS),
      backgroundColorHex: '#faf487');

  var sheet = excel['minha'];



  //for (var table in excel.tables.keys) {
  //print(table);
  //print(excel.tables[table].maxCols);
  //print(excel.tables[table].maxRows);
  //print(excel.tables[table].rows);
  //for (var row in excel.tables[table].rows) {
  //if (row[0] == '00401154') {
  //print(row[1]);
  //break;
  //}
  //}
  //}

  // alterando o arquivo:
  for (int row = 0; row < sheet.maxRows; row++) {
    sheet.row(row).forEach((cell) {
      if (cell.value == cdBarras) {
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
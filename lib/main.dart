// @dart=2.9

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario/services/controller.dart';

void main() => runApp(GetMaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    return Scaffold(
        appBar: AppBar(title: const Text('Leitor de Código de Barras')),
        body: Container(
            alignment: Alignment.center,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                      onPressed: () => c.scanBarcodeNormal(),
                      child: Text("Iniciar leitura")),
                  Obx(() => Text('Dados da leitura:\nCódigo de Barras : \t${c.scanBarcode}\nTítulo : \t${c.title}',
                      style: TextStyle(fontSize: 20)
                      )
                      )
                ])));
  }
}

// @dart=2.9

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario/services/controller.dart';
import 'package:inventario/pages/manual.dart';
import 'package:inventario/pages/resultado.dart';

void main() => runApp(GetMaterialApp(home: MyApp()));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    c.initAndroidPath();
    return Scaffold(
        appBar: AppBar(title: const Text('Leitor de Código de Barras')),
        body: Container(
            alignment: Alignment.center,
            child: Flex(
                direction: Axis.vertical,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    width: 200.0,
                    height: 100.0,
                    child: RaisedButton(
                        onPressed: () {
                          c.scanBarcodeNormal();
                          Get.off(Result());
                        },
                        child: Text("Iniciar leitura")),
                  ),

                  /*Obx(() => Text(
                      'Dados da leitura:\nCódigo de Barras : \t${c.scanBarcode.value}\nTítulo : \t${c.title.value}',
                      style: TextStyle(fontSize: 20))),*/
                  /*RaisedButton(
                    onPressed: ()=> c.initAndroidPath(),
                    child: Text('Download path'),
                  ),*/
                  Container(
                    width: 200.0,
                    height: 100.0,
                    child: RaisedButton(
                      onPressed: () => Get.to(Manual()),
                      child: Text('Informar manualmente'),
                    ),), 
                  /*Container( 
                    width: 200.0,
                    height: 100.0,
                    child: RaisedButton(
                      onPressed: () => Get.to(Result()),
                      child: Text('Resultado'),
                    ),
                  ),*/
                ])));
  }
}

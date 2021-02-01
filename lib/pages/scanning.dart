// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario/services/controller.dart';

class Scanning extends StatelessWidget {
  final Controller c = Get.find();
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
                  Obx(() => Text(
                      'Dados da leitura:\nCódigo de Barras : \t${c.scanBarcode.value}\nTítulo : \t${c.title.value}',
                      style: TextStyle(fontSize: 20))),
                  /*RaisedButton(
                    onPressed: ()=> c.initAndroidPath(),
                    child: Text('Download path'),
                  ),*/
                  RaisedButton(
                    onPressed: () => c.alterSheetDocument('78408194'),
                    child: Text('Alterar planilha'),
                  ),
                ])));
  }
}

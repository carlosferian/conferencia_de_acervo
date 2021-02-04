// @dart=2.9
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:inventario/main.dart';
import 'package:inventario/services/controller.dart';

class Result extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.find();
    /*void unreaded() {
      if (c.scanBarcode.value == '1') {
        Get.to(MyApp());
      }
    }*/
    return Scaffold(
        appBar: AppBar(
          title: Text('Resultado'),
        ),
        body: Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListTile(
                    title: Text(
                      'Dados do item',
                      style: TextStyle(fontWeight: FontWeight.w500),
                    ),
                    leading: Icon(
                      Icons.data_usage,
                      color: Colors.blue[500],
                    ),
                  ),
                  Divider(),
                  ListTile(
                    title: Obx(() => Text('${c.scanBarcode.value}',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                    leading:
                        Icon(Icons.addchart_outlined, color: Colors.blue[500]),
                  ),
                  ListTile(
                    title: Obx(() => Text('${c.title.value}',
                        style: TextStyle(fontWeight: FontWeight.w500))),
                    leading: Icon(Icons.book, color: Colors.blue[500]),
                  ),
                  Divider(),
                  SizedBox(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RaisedButton(
                          onPressed: () => Get.offAll(MyApp()),
                          child: Text('Cancelar')),
                      RaisedButton(
                          onPressed: () {
                            c.scanBarcodeNormal();
                            c.alterSheetDocument(c.scanBarcode.value);
                          },
                          child: Text('Próximo')),
                    ],
                  )
                ],
              ),
            )));
  }
}

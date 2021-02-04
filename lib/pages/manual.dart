// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:inventario/services/controller.dart';
import 'package:inventario/pages/resultado.dart';

class Manual extends StatelessWidget {
  final Controller c = Get.find();
  @override
  Widget build(BuildContext context) {
    final Controller c = Get.put(Controller());
    final _formKey = GlobalKey<FormState>();
    final myController = TextEditingController();
     

    return Scaffold(
      appBar: AppBar(
        title: Text('Digite o código de barras'),
      ),
      body: Column(
          children: [
            Padding(
            padding: const EdgeInsets.all(30.0),
            child: TextField(
              keyboardType: TextInputType.number,
              inputFormatters: [],
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Código de barras',
              ),
              controller: myController,          
            ),
          ),
            Center(        
              child: RaisedButton(
              child: Text('Enviar'),
              onPressed: ()=> c.infoManual(myController.text)),
            ),
          ],
          )
    );
  }
}
 
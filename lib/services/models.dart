import 'package:get/get.dart';

class Book {

  int barcode = 0000;
  String title = 'título';

  Book({ barcode, title });

  Book.fromJson(Map<String, dynamic> json){
      this.barcode = json['id'];
      this.title = json['name'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
}
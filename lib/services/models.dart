import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class Book {
  var barcode = '';
  var title = '';

  Book(this.barcode, this.title);

  Book.fromJson(Map<String, dynamic> json) {
    this.barcode = json['id'];
    this.title = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    return data;
  }
 
}

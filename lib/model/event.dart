import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EventModel {
  EventModel(
      {required this.From,
      required this.To,
      required this.Price,
      required this.Date});
  //EventModel({this.dateFrom, this.dateTo, this.place, this.price});

  String From;
  String To;
  int Price;
  DateTime Date;

  String forPrint() {
    return From + ' ' + To + ' ' + Price.toString() + ' ' + Date.toString();
  } 
}
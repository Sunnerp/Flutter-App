import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Order {
  const Order({
    @required this.StoreID,
    @required this.Name,
    @required this.HouseNumber,
    @required this.PostCode,
    @required this.Quantity,

  });

  final int StoreID;
  final String Name;
  final String HouseNumber;
  final String PostCode;
  final int Quantity;

  String get assetName => 'assets/img/$StoreID-0.JPG';
}


import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Store {
  const Store({
    @required this.ID,
    @required this.Name,
    @required this.Location,
    @required this.Description,
  })
      : assert(ID != null),
        assert(Name != null),
        assert(Location != null),
        assert(Description != null);


  final int ID;
  final String Name;
  final String Location;
  final String Description;

  String get assetName => 'assets/img/$ID-0.JPG';
}


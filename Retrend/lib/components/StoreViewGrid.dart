

import 'package:flutter/material.dart';
import '../model/store.dart';
import '../components/StoreCard.dart';

class StoreViewGrid extends StatelessWidget{
  
  int columns;
  List<Store> stores;
  StoreViewGrid(List<Store> productsParam, {int columnsParam = 2}){
    columns = columnsParam;
    stores = productsParam;
  }
  
  List<Widget> getProductCards(){
    return stores.map((stores){
      return StoreView(viewStore: stores,);
    }).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return
      GridView.count(
        crossAxisCount: columns,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: getProductCards()
    );
  }
}
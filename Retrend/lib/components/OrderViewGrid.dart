

import 'package:flutter/material.dart';
import '../model/order.dart';
import '../components/OrderCard.dart';

class OrderViewGrid extends StatelessWidget{
  
  int columns;
  List<Order> stores;
  OrderViewGrid(List<Order> productsParam, {int columnsParam = 1}){
    columns = columnsParam;
    stores = productsParam;
  }
  
  List<Widget> getOrderCards(){
    return stores.map((stores){
      return OrderView(viewStore: stores,);
    }).toList();
  }
  
  @override
  Widget build(BuildContext context) {
    return
      GridView.count(
        crossAxisCount: columns,
        padding: EdgeInsets.all(16.0),
        childAspectRatio: 8.0 / 9.0,
        children: getOrderCards()
    );
  }
}
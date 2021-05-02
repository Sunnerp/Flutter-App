import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model/store.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:numberpicker/numberpicker.dart';
import './model/order_repository.dart';
import './model/order.dart';
class OrderPage extends StatefulWidget {
  final Store viewStore;

  OrderPage({@required this.viewStore});

  @override
  State createState() {
    return OrderPageState(
      viewStore: viewStore,
    );
  }
}

class OrderPageState extends State<OrderPage> {
  final Store viewStore;
  Future<bool> favourite;
  int currentValue = 1;
  TextEditingController nameController = TextEditingController();
  TextEditingController houseNumberController= TextEditingController();
  TextEditingController postCodeController= TextEditingController();
  OrderRepository orderRepository = OrderRepository();
  OrderPageState({@required this.viewStore});
  void OrderComplete(){
    Order newOrder = Order(
      StoreID: viewStore.ID,
      HouseNumber: houseNumberController.text,
      Name: nameController.text,
      Quantity: currentValue,
      PostCode: postCodeController.text
    );
    orderRepository.addOrder(newOrder);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Order Box"),
          actions: <Widget>[],
          elevation: 0,
        ),
      body: Container(
        child: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            children: <Widget>[
              SizedBox(height: 24.0),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: houseNumberController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'House Number',
                ),
              ),
              SizedBox(height: 12.0),
              TextField(
                controller: postCodeController,
                decoration: InputDecoration(
                  filled: true,
                  labelText: 'Post Code',
                ),
              ),
              SizedBox(height: 12.0),
              Text("Quantity", style: TextStyle(fontSize: 16),),
              NumberPicker.integer(

                  initialValue: currentValue,
                  minValue: 1,
                  maxValue: 100,
                  onChanged: (val){
                    currentValue = val;
                    setState(() {

                    });
                  },
                  )
            ],
          ),
        )
      ),
      bottomNavigationBar:             RaisedButton(
        child: Text('Purchase'),
        onPressed: () {
          OrderComplete();
        },
      ),
    );
  }
}

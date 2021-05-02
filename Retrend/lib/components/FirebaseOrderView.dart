import 'package:flutter/material.dart';
import 'OrderViewGrid.dart';
import '../model/order.dart';
import '../model/order_repository.dart';
class FirebaseOrderView extends StatefulWidget{
  FirebaseOrderView(){
  }
  @override
  State createState() {
    return FirebaseOrderViewState();
  }
}
class FirebaseOrderViewState extends State<FirebaseOrderView>{
  OrderRepository orderRepository;
  //When database has loaded this variable will store the firestore data
  Future<List<Order>> firebaseOders;
  bool favorites;
  FirebaseOrderViewState(){
    this.favorites = favorites;
    orderRepository = new OrderRepository();
  }

  @override
  void initState() {
    super.initState();
    firebaseOders = orderRepository.getFirebaseProducts();
  }
  Future<void> refresh() async{

    setState(() {
      firebaseOders = orderRepository.getFirebaseProducts();

    });
  }
  @override
  Widget build(BuildContext context) {
    return   FutureBuilder<List<Order>>(
      future: firebaseOders,
      builder: (BuildContext context, AsyncSnapshot<List<Order>> snapshot) {
        //If the data has loaded and isn't in the middle of a refresh display store list
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return RefreshIndicator(
              child: OrderViewGrid(snapshot.data),
              onRefresh: refresh

          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  height: 20,
                  width: 20,
                  margin: EdgeInsets.all(5),
                  child: CircularProgressIndicator(
                    strokeWidth: 2.0,
                    valueColor : AlwaysStoppedAnimation(Colors.red),
                  ),
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
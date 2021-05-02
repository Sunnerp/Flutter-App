import 'store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'order.dart';
class OrderRepository {
  Firestore db = Firestore.instance;

  void addOrder(Order order) async{
    await db.collection("Orders").document(order.hashCode.toString()).setData({
      "StoreID" : order.StoreID,
      "Name" : order.Name,
      "HouseNumber" : order.HouseNumber,
      "PostCode" : order.PostCode,
      "Quantity" : order.Quantity
    });
  }
  Order fromJson(DocumentSnapshot document){
    return Order(
      StoreID: document["StoreID"],
      Name: document["Name"],
      HouseNumber: document["HouseNumber"],
      PostCode: document["PostCode"],
      Quantity: document["Quantity"]
    );
  }

  Future<List<Order>> getFirebaseProducts() async{
    List<Order>  order = List<Order>();

    //Get all the documents in the Stores collection
    await db.collection("Orders").getDocuments().then((document){
      //Loop over all the documents returned
      document.documents.forEach((store){
        order.add(fromJson(store));
        //Add the product to the products list

      });
    });
    return order;
  }
}
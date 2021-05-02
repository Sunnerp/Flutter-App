import 'store.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
class StoreRepository {
  Firestore db = Firestore.instance;
  Store fromJSON(DocumentSnapshot documentSnapshot){
    return Store(ID: documentSnapshot["ID"],
                  Name: documentSnapshot["Name"],
                  Location: documentSnapshot["Location"],
                  Description: documentSnapshot["Description"]);
  }
  Future<List<Store>> getFirebaseProducts({bool favorites = false}) async{
    List<Store> /*products*/ stores = List<Store>();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //Get all the documents in the Stores collection
    await db.collection("Stores").getDocuments().then((document){
      //Loop over all the documents returned
      document.documents.forEach((store){

        if(favorites && prefs.containsKey(store["Name"]) && prefs.getBool(store["Name"])){
          stores.add(fromJSON(store));
        }else if(!favorites){
          stores.add(fromJSON(store));
        }
        //Add the product to the products list

      });
    });
    return stores;
  }

}
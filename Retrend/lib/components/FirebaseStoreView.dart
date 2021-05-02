import 'package:flutter/material.dart';
import '../model/store.dart';
import '../model/store_repository.dart';
import 'StoreViewGrid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseStoreView extends StatefulWidget{
  bool favorites;
  FirebaseStoreView({bool favorites = false}){
    this.favorites = favorites;
  }
  @override
  State createState() {
    return FirebaseStoreViewState(favorites);
  }
}
class FirebaseStoreViewState extends State<FirebaseStoreView>{
  StoreRepository storeRepository;
  //When database has loaded this variable will store the firestore data
  Future<List<Store>> firebaseStores;
  bool favorites;
  FirebaseStoreViewState(bool favorites){
    this.favorites = favorites;
    storeRepository = new StoreRepository();
  }

  @override
  void initState() {
    super.initState();
    firebaseStores = storeRepository.getFirebaseProducts(favorites: favorites);
  }
  Future<void> refresh() async{

    setState(() {
      firebaseStores = storeRepository.getFirebaseProducts(favorites: favorites);

    });
  }
  @override
  Widget build(BuildContext context) {
    return   FutureBuilder<List<Store>>(
      future: firebaseStores,
      builder: (BuildContext context, AsyncSnapshot<List<Store>> snapshot) {
        //If the data has loaded and isn't in the middle of a refresh display store list
        if (snapshot.hasData && snapshot.connectionState == ConnectionState.done) {
          return RefreshIndicator(
              child: StoreViewGrid(snapshot.data),
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
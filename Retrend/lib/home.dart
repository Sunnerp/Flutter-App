import 'package:Shrine/components/FirebaseStoreView.dart';
import 'package:Shrine/model/TabData.dart';
import 'package:flutter/material.dart';
import 'components/HomeViewComponent.dart';
import './components/FirebaseOrderView.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: Brightness.dark,

          primaryColor: Color.fromRGBO(58, 66, 86, 1.0),
        ),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
        ),
      color: Colors.yellow,
      supportedLocales: [const Locale('en', 'UK')],
      home: HomeViewComponent(
        [
          TabData(
              name: "Home",
              icon : Icon(Icons.home),
              view: FirebaseStoreView()
          ),
          TabData(
              name: "Favourites",
              icon : Icon(Icons.star),
              view: FirebaseStoreView(favorites: true,)
          ),
          TabData(
              name: "Orders",
              icon : Icon(Icons.shopping_cart),
              view: FirebaseOrderView()
          )
        ],
        title: 'Select a store'
      )
    );
  }
}

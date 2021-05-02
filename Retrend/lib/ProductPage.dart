import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './model/store.dart';
import 'package:Shrine/OrderPage.dart';
import 'package:url_launcher/url_launcher.dart';

class ProductPage extends StatefulWidget {
  final Store viewStore;

  ProductPage({@required this.viewStore});

  @override
  State createState() {
    return ProductPageState(
      viewStore: viewStore,
    );
  }
}

class ProductPageState extends State<ProductPage> {
  final Store viewStore;
  Future<bool> favourite;

  ProductPageState({@required this.viewStore});

  Future<bool> _toggleFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(viewStore.Name)) {
      await prefs.setBool(viewStore.Name, !prefs.getBool(viewStore.Name));
      return prefs.getBool(viewStore.Name);
    } else {
      await prefs.setBool(viewStore.Name, true);
      return true;
    }
  }

  Future<bool> getFavourite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey(viewStore.Name)) {
      return prefs.getBool(viewStore.Name);
    } else {
      await prefs.setBool(viewStore.Name, false);
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    favourite = getFavourite();
  }

  void toggle() async {
    setState(() {
      favourite = _toggleFavourite();
    });
  }

  @override
  Widget build(BuildContext context) {
    //Get the theme here
    final ThemeData theme = Theme.of(context);

    return Scaffold(
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        appBar: AppBar(
          title: Text("Store Page"),
          actions: <Widget>[
            FutureBuilder(
              future: favourite,
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                bool isFavourite = snapshot.hasData && snapshot.data;
                if (isFavourite) {
                  return IconButton(
                    icon: Icon(Icons.star),
                    color: Colors.orangeAccent,
                    onPressed: () {
                      toggle();
                    },
                  );
                } else {
                  return IconButton(
                    icon: Icon(Icons.star),
                    color: Colors.white,
                    onPressed: () {
                      toggle();
                    },
                  );
                }
              },
            )
          ],
        ),
        body: Container(
          child: new Wrap(
            children: <Widget>[
              Card(
                color: Color.fromRGBO(70, 75, 92, 1.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    ListTile(
                      leading: Image.asset(
                        viewStore
                            .assetName, //uses the product ID from the list to get the right image from the assests folder
                      ),
                      title: Text(viewStore.Name),
                      subtitle: Text(viewStore.Location),
                    ),
                    ListTile(
                      title: Text(
                        "Description",
                      ),
                      subtitle: Text(viewStore.Description),
                    ),


                    Center(
                      child: ButtonBar(
                        alignment: MainAxisAlignment.center,
                        children: <Widget>[
                          IconButton(
                            icon: new FaIcon(FontAwesomeIcons.facebook),
                            onPressed: () {
                              launch('https://www.facebook.com/rokitvintage');
                            },
                          ),
                          IconButton(
                            icon: new FaIcon(FontAwesomeIcons.twitter),
                            onPressed: () {
                              launch(
                                  'https://twitter.com/rokitvintage?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor');
                            },
                          ),
                          IconButton(
                            icon: new FaIcon(FontAwesomeIcons.instagram),
                            onPressed: () {
                              launch('https://www.instagram.com/rokitvintage/');
                            },
                          ),
                          FlatButton(
                              color: Colors.blue,
                              textColor: Colors.white,
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.black,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.blueAccent,
                              child: Text("Website"),
                              onPressed: () {
                                launch('https://www.rokit.co.uk/');
                              })
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(child: Text("Purchase Boxes", textWidthBasis: TextWidthBasis.parent, style: TextStyle(fontSize: 30), textAlign: TextAlign.center,)),
              SizedBox(height: 40,),
              Container(
                color: Color.fromRGBO(70, 75, 92, 0.6),
                height: 220,
                child: ListView(
                children: <Widget>[
                  ListTile(

                    leading: FaIcon(FontAwesomeIcons.box, color: Colors.orange),
                    title: Text(
                      "Bronze",
                    ),
                    subtitle: Text("£10"),
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(viewStore: viewStore,)));
                     }
                  ),
                  ListTile(

                    leading: FaIcon(FontAwesomeIcons.box, color: Colors.grey),
                    title: Text(
                      "Silver",
                    ),
                    subtitle: Text("£20"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(viewStore: viewStore,)));/* react to the tile being tapped */ }
                  ),
                  ListTile(

                      leading: FaIcon(FontAwesomeIcons.box, color: Colors.amberAccent),
                      title: Text(
                        "Gold",
                      ),
                      subtitle: Text("£30"),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => OrderPage(viewStore: viewStore,)));/* react to the tile being tapped */ }
                  ),
                ],
              ),
              ),
            ],

          ),
        ));
  }
}

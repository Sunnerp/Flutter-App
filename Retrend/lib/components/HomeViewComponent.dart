import 'package:flutter/material.dart';
import '../model/TabData.dart';

class HomeViewComponent extends StatelessWidget{

  String title;
  List<TabData> tabData;
  HomeViewComponent(List<TabData> tabData, {String title = "default" , }){
    this.title = title;
    this.tabData = tabData;

  }

  List<Widget> getTabs(){
    return tabData.map((data){
      return Tab(
        icon: data.icon,
        //title: Text('Home')
      );
    }).toList();
  }

  List<Widget> getViews(){
    return tabData.map((data){
      return data.view;
    }).toList();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabData.length,
      child: new Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: AppBar(
            title: Text("Retrend"),
            elevation: 0.0,
          ),
          body:
          TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: getViews()
          ),
          bottomNavigationBar: new TabBar(
            labelColor: Colors.green,
            unselectedLabelColor: Colors.orange,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorPadding: EdgeInsets.all(5.0),
            indicatorColor: Colors.white,
            tabs: getTabs(),
          )
      ),
    );
  }
}
import 'package:Shrine/ProductPage.dart';
import 'package:flutter/material.dart';
import '../model/order.dart';
import 'package:dartpedia/dartpedia.dart' as wiki;

class OrderView extends StatelessWidget {
  final Order viewStore;

  OrderView({@required this.viewStore});

  @override
  Widget build(BuildContext context) {
    //Get the theme here
    final ThemeData theme = Theme.of(context);

    return GestureDetector(
        child: new Card(

          color: Color.fromRGBO(70, 75, 92, 1.0),
          clipBehavior: Clip.antiAlias,
          // The empty space that surrounds the card.
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10,),
              AspectRatio(
                aspectRatio: 18 / 12,
                // The aspect ratio is expressed as a ratio of width to height.
                child: Image.asset(
                  viewStore
                      .assetName, //uses the product ID from the list to get the right image from the assests folder
                ),
              ),
              Expanded(
                //expands a child of a [Row], [Column], or [Flex], so that the child fills the available space
                child: Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  // (this.left, this.top, this.right, this.bottom); text padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        viewStore.Name,
                        style: theme.textTheme.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      Text(
                        viewStore.HouseNumber,
                        style: theme.textTheme.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      Text(
                        viewStore.PostCode.toUpperCase(),
                        style: theme.textTheme.title,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                      ),
                      SizedBox(height: 1.0), //Todo: this does nothing?
                      Center(
                      child: Text(
                        "Quantity: " + viewStore.Quantity.toString(),
                        style: theme.textTheme.title, //style of font
                      ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

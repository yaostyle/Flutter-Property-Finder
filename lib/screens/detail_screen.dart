import 'package:flutter/material.dart';
import 'package:flutter_property_finder/models/nestoria.dart';

class DetailScreen extends StatelessWidget {
  final Property property;

  const DetailScreen(this.property);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 256,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Image.network(property.imgUrl, fit: BoxFit.cover,),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

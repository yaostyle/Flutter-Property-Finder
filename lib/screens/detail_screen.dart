import 'package:flutter/material.dart';
import 'package:flutter_property_finder/models/nestoria.dart';
import 'package:flutter_property_finder/ui_widgets/text_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatelessWidget {
  final Property property;

  const DetailScreen(this.property);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
                  Image.network(
                    property.imgUrl,
                    fit: BoxFit.cover,
                  ),
                  const DecoratedBox(
                      decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.0, -1.0),
                      end: Alignment(0.0, -0.4),
                      colors: <Color>[Color(0x60000000), Color(0x0000000)],
                    ),
                  )),
                  Positioned(
                    bottom: 20,
                    left: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 16),
                      color: Color.fromRGBO(
                        255,
                        255,
                        255,
                        0.5,
                      ),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Icon(
                              FontAwesomeIcons.tag,
                              size: 20,
                              color: Theme.of(context).accentColor,
                            ),
                          ),
                          Text(
                            property.priceFormatted,
                            style: Theme.of(context).textTheme.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 4),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    property.title,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 24.0),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 16),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(color: Colors.grey, width: 0.4),
                        bottom: BorderSide(color: Colors.grey, width: 0.4),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextIcon(
                          icon: FontAwesomeIcons.bed,
                          text: "${property.bedroomNumber ?? "#"} Bedroom",
                        ),
                        TextIcon(
                          icon: FontAwesomeIcons.shower,
                          text: "${property.bathroomNumber ?? "#"} Bathroom",
                        ),
                        TextIcon(
                          icon: FontAwesomeIcons.car,
                          text: "${property.carSpaces ?? "#"} Car Space",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Summary", style: Theme.of(context).textTheme.title.copyWith(fontSize: 20)),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(property.summary),
                  ),
                  Text("Tags", style: Theme.of(context).textTheme.subtitle,),

                ],
              ),
            ),

          ])),
        ],
      ),
    );
  }
}

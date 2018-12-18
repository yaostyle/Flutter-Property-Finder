import 'package:flutter/material.dart';
import 'package:flutter_property_finder/models/property_scoped_model.dart';
import 'package:flutter_property_finder/ui_widgets/property_item.dart';
import 'package:flutter_property_finder/ui_widgets/search.dart';
import 'package:scoped_model/scoped_model.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScopedModelDescendant<PropertyScopedModel>(
        builder: (context, child, model) {
          return CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                title: SearchWidget(
                  performSearch: model.getProperties,
                ),
                floating: true,
                snap: true,
              ),
              model.isLoading
                  ? SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : model.getPropertyCount() < 1
                      ? SliverFillRemaining(
                          child: Center(
                            child: Text(model.statusText,
                                style: Theme.of(context).textTheme.headline),
                          ),
                        )
                      : SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
                                print(index);
                            if (index == model.getPropertyCount()) {
                              if (model.hasMorePages) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                                  child: Center(child: CircularProgressIndicator()),
                                );
                              }
                            } else if (index == 0) {
                              return Container(
                                padding: const EdgeInsets.all(16.0),
                                decoration: BoxDecoration(
                                    border: Border(
                                        bottom: BorderSide(
                                            color: Colors.grey[300]))),
                                child: Text(
                                  "${model.totalResults} results",
                                  style: Theme.of(context)
                                      .textTheme
                                      .body2
                                      .copyWith(color: Colors.grey),
                                ),
                              );
                            } else {
                              return Column(
                                children: <Widget>[
                                  PropertyItem(model.properties[index - 1]),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16.0),
                                    child: Divider(
                                      height: 1,
                                      color: Colors.grey,
                                    ),
                                  )
                                ],
                              );
                            }
                          }, childCount: model.getPropertyCount() + 1),
                        )
            ],
          );
        },
      ),
    );
  }
}

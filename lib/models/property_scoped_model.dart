import 'dart:convert';
import 'package:flutter_property_finder/models/nestoria.dart';
import 'package:flutter_property_finder/models/serializers.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

class PropertyScopedModel extends Model {
  List<Property> _properties = [];
  bool _isLoading = false;
  String _statusText = "Start Search";
  int _totalResults;



  List<Property> get properties => _properties;
  bool get isLoading => _isLoading;
  String get statusText => _statusText;
  int get totalResults => _totalResults;

  int getPropertyCount() => _properties.length;

  Future<dynamic> _getData(String place) async {
    String uri =
        "https://api.nestoria.co.uk/api?encoding=json&pretty=1&action=search_listings&country=uk&listing_type=buy&has_photo=1&place_name=$place";
    var res = await http.get(Uri.encodeFull(uri));
    var decodedJson = json.decode(res.body, reviver: (k, v){
      if (k == "bathroom_number"){
        if (v == "") return null;
        return v;
      }
      if (k == "bedroom_number"){
        if (v == "") return null;
        return v;
      }
      return v;
    });
    
    return decodedJson;
  }

  Future getProperties(String place) async {
    _isLoading = true;
    notifyListeners();

    var responseData = await _getData(place);

    Nestoria nestoria =
        serializers.deserializeWith(Nestoria.serializer, responseData);

    _properties =
        nestoria.response.listings.map((property) => property).toList();

    if (nestoria.response.listings.isEmpty) {
      _statusText = "Nothing found";
    }

    _totalResults = nestoria.response.totalResults;

    _isLoading = false;
    notifyListeners();
  }
}

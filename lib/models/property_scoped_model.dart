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
  int _totalPages;
  bool _hasMorePages = true;

  List<Property> get properties => _properties;

  bool get isLoading => _isLoading;

  String get statusText => _statusText;

  int get totalResults => _totalResults;

  int get totalPages => _totalPages;

  bool get hasMorePages => _hasMorePages;

  int getPropertyCount() => _properties.length;

  Future<dynamic> _getData(String place) async {
    var uri = new Uri.https("api.nestoria.co.uk", "/api", {
      "encoding": "json",
      "action": "search_listings",
      "has_photo": "1",
      "number_of_results": "10",
      "place_name": place.isNotEmpty ? place : "brighton"
    });
    var res = await http.get(uri);
    var decodedJson = json.decode(res.body, reviver: (k, v) {
      if (k == "bathroom_number") {
        if (v == "") return null;
        return v;
      }
      if (k == "bedroom_number") {
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
    _totalPages = nestoria.response.totalPages;

    if (nestoria.response.page == totalPages) {
      _hasMorePages = false;
    }

    _isLoading = false;
    notifyListeners();
  }
}

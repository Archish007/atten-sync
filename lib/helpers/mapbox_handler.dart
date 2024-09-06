//import 'dart:convert';
import 'package:attensync/requests/mapbox_directions.dart';
import 'package:attensync/requests/mapbox_rev_geocoding.dart';
import 'package:attensync/requests/mapbox_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';

// Mapbox Search Query

String getValidatedQueryFromQuery(String query) {
  // Remove whitespaces
  String validatedQuery = query.trim();
  return validatedQuery;
}

Future<List> getParsedResponseForQuery(String value) async {
  List parsedResponses = [];

  String query = getValidatedQueryFromQuery(value);
  // If empty query send blank response
  if (query == '') return parsedResponses;

  // Else search and then send response
  Map<String, dynamic> response =
      await getSearchResultsFromQueryUsingMapbox(query);

  List features = response['features'];
  for (var feature in features) {
    Map response = {
      'name': feature['text'],
      'address': feature['place_name'].split('${feature['text']}, ')[1],
      'place': feature['place_name'],
      'location': LatLng(feature['center'][1], feature['center'][0])
    };
    parsedResponses.add(response);
  }
  return parsedResponses;
}

// Mapbox Reverse Geocoding
Future<Map> getParsedReverseGeocoding(LatLng latlng) async {
  var response = await getReverseGeocodingGivenLatLngUsingMapbox(latlng);
  if (response.isNotEmpty) {
    Map feature = response['features'][0];
    Map revGeocode = {
      'name': feature['text'],
      'address': feature['place_name'].split('${feature['text']}, ')[1],
      'place': feature['place_name'],
      'location': latlng
    };
    return revGeocode;
  } else {
    return {}; // empty response
  }
}

// Mapbox Directions API
Future<Map> getDirectionsAPIResponse(
    LatLng sourceLatLng, LatLng destinationLatLng) async {
  final response =
      await getCyclingRouteUsingMapbox(sourceLatLng, destinationLatLng);
  debugPrint('routes response $response');
  //if(response['routes'])
  return response;
}

LatLng getCenterCoordinatesForPolyline(Map geometry) {
  List coordinates = geometry['coordinates'];
  int pos = (coordinates.length / 2).round();
  return LatLng(coordinates[pos][1], coordinates[pos][0]);
}

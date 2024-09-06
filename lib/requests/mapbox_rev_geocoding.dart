import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart';
import '../helpers/dio_exceptions.dart';

String baseUrl = 'https://api.mapbox.com/geocoding/v5/mapbox.places';
String accessToken = dotenv.env['MAPBOX_ACCESS_TOKEN']!;

Dio _dio = Dio();

Future getReverseGeocodingGivenLatLngUsingMapbox(LatLng latlng) async {
  String query = '${latlng.longitude},${latlng.latitude}';
  String url = '$baseUrl/$query.json?access_token=$accessToken';
  url = Uri.parse(url).toString();
  print(url);
  try {
    _dio.options.contentType = Headers.jsonContentType;
    final responseData = await _dio.get(url);
    return responseData.data;
  } catch (e) {
    final errorMessage = DioExceptions.fromDioError(e as DioError).toString();
    debugPrint(errorMessage);
    return {}; //return an empty map in case of error
  }
}

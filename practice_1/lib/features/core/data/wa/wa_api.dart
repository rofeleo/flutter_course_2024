import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:practice_1/features/core/data/wa/models/wa_weather.dart';

class WAApi {
  final String url;
  final String apiKey;

  WAApi(this.url, this.apiKey);

  Future<WAWeather> getWeather(String city) async {
    var response = await http.get(Uri.parse('$url/v1/current.json?key=$apiKey&q=$city&aqi=no'));
    var rJson = jsonDecode(response.body);
    return WAWeather(rJson['current']['temp_c'], rJson['current']['condition']['text']);
  }

  Future<WAWeather> getWeatherByCoords(double latitude, double longitude) async {
    var response = await http.get(Uri.parse('$url/v1/current.json?key=$apiKey&q=$latitude,$longitude&aqi=no'));
    var rJson = jsonDecode(response.body);

    return WAWeather(rJson['current']['temp_c'], rJson['current']['condition']['text']);
  }
}
import 'package:practice_1/features/core/data/wa/wa_api.dart';
import 'package:practice_1/features/core/data/wa/weather_repository_wa.dart';
import 'package:practice_1/features/core/presentation/app.dart';

const String version = '0.0.1';
const String url = 'http://api.weatherapi.com';
const String apiKey = '<API key>';

void main(List<String> arguments) {
  var app = App(WeatherRepositoryWA(WAApi(url, apiKey)));

  app.run();
}

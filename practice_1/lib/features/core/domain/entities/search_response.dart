class SearchResponse {
  final int temp;
  final WeatherType type;

  const SearchResponse(this.temp, this.type);

  @override
  String toString() {
    return 'SearchResponse{temp: $temp, type: $type}';
  }
}

enum WeatherType {clear, rain, cloudy, sunny, other}

String weatherTypeToString(WeatherType type) {
  switch (type) {
    case WeatherType.cloudy:
      return 'Clouds';
    case WeatherType.clear:
      return 'Clear';
    case WeatherType.rain:
      return 'Rain';
    case WeatherType.sunny:
      return 'Sunny';
    default:
      return 'Other';
  }
}
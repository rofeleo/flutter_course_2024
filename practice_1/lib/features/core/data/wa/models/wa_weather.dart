class WAWeather {
  final double temp;
  final String type;

  const WAWeather(this.temp, this.type);

  @override
  String toString() {
    return 'WAWeather{temp: $temp, type: $type}';
  }
}
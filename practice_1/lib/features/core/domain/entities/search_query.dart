sealed class SearchQuery {}

class SearchByCoordinates extends SearchQuery {
  final double longitude;
  final double width;

  SearchByCoordinates(this.longitude, this.width);
}

class SearchByCity extends SearchQuery {
  final String city;

  SearchByCity(this.city);
}
library modern_calendar;

abstract class Location {
  final String? name;
  final int? latitude;
  final int? longitude;

  Location({
    this.name,
    this.latitude,
    this.longitude,
  });
}

class DefaultLocation extends Location {
  DefaultLocation({
    super.name,
    super.latitude,
    super.longitude,
  });
}

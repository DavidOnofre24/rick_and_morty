
class LocationAbr {
  final String name;
  final String url;

  LocationAbr({
    required this.name,
    required this.url,
  });

  factory LocationAbr.fromJson(Map<String, dynamic> json) => LocationAbr(
        name: json["name"],
        url: json["url"],
      );
}

class WeatherModel {
  String description;
  int dateTime;
  String icon;
  double temperature;
  String country;
  String city;

  WeatherModel({
    required this.description,
    required this.dateTime,
    required this.icon,
    required this.temperature,
    required this.country,
    required this.city,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      description: map['weather'][0]['description'],
      dateTime: map['dt'],
      icon: map['weather'][0]['icon'],
      temperature: map['main']['temp'],
      country: map['sys']['country'],
      city: map['name'],
    );
  }
}

class ForecastModel {
  String dateTime;
  int date;
  String description;
  String temperature;
  String icon;

  ForecastModel({
    required this.description,
    required this.date,
    required this.dateTime,
    required this.temperature,
    required this.icon,
  });

  factory ForecastModel.fromMap(Map<String, dynamic> map) {
    return ForecastModel(
      date: map['dt'],
      description: map['weather'][0]['description'],
      dateTime: map['dt_txt'],
      temperature: map['main']['temp'].toString(),
      icon: map['weather'][0]['icon'],
    );
  }
}

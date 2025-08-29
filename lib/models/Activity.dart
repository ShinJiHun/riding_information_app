class Activity {
  final int id;
  final String date;
  final String device;
  final String title;
  final String content;
  final String? polyline;
  final String? mapUrl;

  Activity({
    required this.id,
    required this.date,
    required this.device,
    required this.title,
    required this.content,
    this.polyline,
    this.mapUrl,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'] as int,
      title: json['activityTitle'] ?? '',
      content: json['activityContent'] ?? '',
      date: json['activityDate'] ?? '',
      device: json['device'] ?? '',
      mapUrl: json['mapUrl'],
      polyline: json['polyline'], // ✅ 서버가 내려주면 여기서 세팅
    );
  }
}

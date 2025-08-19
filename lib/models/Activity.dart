class Activity {
  final String date;
  final String device;
  final String title;
  final String content;
  final String? polyline;      // <- 추가: Google Encoded Polyline
  final String? staticMapUrl;  // <- (선택) 서버에서 바로 URL을 주면 사용

  Activity({
    required this.date,
    required this.device,
    required this.title,
    required this.content,
    this.polyline,
    this.staticMapUrl,
  });

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      date: json['date'] ?? '',
      device: json['device'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      polyline: json['polyline'],
      staticMapUrl: json['staticMapUrl'],
    );
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class Activity {
  final int id;
  final String date;
  final String device;
  final String title;
  final String content;
  final String? polyline;   // 인코딩된 polyline 문자열
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
      polyline: json['polyline'],
    );
  }

  /// ✅ polyline 문자열 → LatLng 리스트
  List<LatLng> get decodedPolylinePoints {
    if (polyline == null) return [];
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      List<PointLatLng> points = polylinePoints.decodePolyline(polyline!);
      return points.map((e) => LatLng(e.latitude, e.longitude)).toList();
    } catch (e) {
      return [];
    }
  }

  /// ✅ 시작점/끝점 가져오기
  LatLng? get startLatLng =>
      decodedPolylinePoints.isNotEmpty ? decodedPolylinePoints.first : null;

  LatLng? get endLatLng =>
      decodedPolylinePoints.isNotEmpty ? decodedPolylinePoints.last : null;
}

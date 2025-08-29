import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../models/activity.dart';

class ActivityDetailPage extends StatefulWidget {
  final Activity activity;
  final String heroTag;

  const ActivityDetailPage({
    super.key,
    required this.activity,
    required this.heroTag,
  });

  @override
  State<ActivityDetailPage> createState() => _ActivityDetailPageState();
}

class _ActivityDetailPageState extends State<ActivityDetailPage> {
  final MapController _mapController = MapController();
  late final List<LatLng> _route;

  @override
  void initState() {
    super.initState();
    _route = _decodeEncodedPolyline(widget.activity.polyline);
    // 지도 영역을 라인에 맞춰 자동 확대
    if (_route.length >= 2) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final bounds = LatLngBounds.fromPoints(_route);
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: bounds,
            padding: const EdgeInsets.all(24),
          ),
        );
      });
    }
  }

  List<LatLng> _decodeEncodedPolyline(String? encoded) {
    if (encoded == null || encoded.isEmpty) return [];
    final points = PolylinePoints().decodePolyline(encoded);
    return points.map((p) => LatLng(p.latitude, p.longitude)).toList();
  }

  @override
  Widget build(BuildContext context) {
    final hasRoute = _route.isNotEmpty;
    final center = hasRoute ? _route.first : const LatLng(37.5665, 126.9780); // 서울 기본값

    return Scaffold(
      appBar: AppBar(title: Text(widget.activity.title)),
      body: FlutterMap(
        mapController: _mapController,
        options: MapOptions(
          initialCenter: center,
          initialZoom: 12,
        ),
        children: [
          // OSM 타일(무료, 키 불필요)
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'your.package.name', // 꼭 지정해 주세요
            // retinaMode: true, // 고해상도 필요하면
          ),

          // 경로 라인
          if (hasRoute)
            PolylineLayer(
              polylines: [
                Polyline(
                  points: _route,
                  strokeWidth: 4.0,
                  isDotted: false,
                ),
              ],
            ),

          // 시작/끝 마커 (옵션)
          if (hasRoute)
            MarkerLayer(
              markers: [
                Marker(
                  point: _route.first,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.flag, size: 28),
                ),
                Marker(
                  point: _route.last,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.place, size: 28),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

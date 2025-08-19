import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
  GoogleMapController? _mapController;
  Set<Polyline> _polylines = {};
  LatLngBounds? _bounds;

  @override
  void initState() {
    super.initState();
    _buildPolylineAndBounds();
  }

  void _buildPolylineAndBounds() {
    final encoded = widget.activity.polyline; // 서버에서 내려준 encoded polyline (옵션)
    if (encoded == null || encoded.isEmpty) return;

    final points = _decodePolyline(encoded);
    if (points.isEmpty) return;

    final poly = Polyline(
      polylineId: const PolylineId('route'),
      points: points,
      width: 5,
    );

    // bounds 계산
    double minLat = points.first.latitude, maxLat = points.first.latitude;
    double minLng = points.first.longitude, maxLng = points.first.longitude;
    for (final p in points) {
      minLat = math.min(minLat, p.latitude);
      maxLat = math.max(maxLat, p.latitude);
      minLng = math.min(minLng, p.longitude);
      maxLng = math.max(maxLng, p.longitude);
    }
    _bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    setState(() {
      _polylines = {poly};
    });
  }

  // Google Encoded Polyline 디코더 (Dart)
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> points = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0) ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }
    return points;
  }

  Future<void> _fitBounds() async {
    if (_mapController == null || _bounds == null) return;
    // 패딩은 적당히 조절
    await _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(_bounds!, 30),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 초기 카메라 위치(대충 한국 중심 등)
    const initialPos = CameraPosition(target: LatLng(37.5665, 126.9780), zoom: 8);

    return Scaffold(
      appBar: AppBar(title: Text(widget.activity.title)),
      body: Column(
        children: [
          // 히어로로 넘어온 정적 이미지(선택적으로 위에 배치)
          Hero(
            tag: widget.heroTag,
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Container(color: Colors.black12), // 필요시 썸네일/이미지 유지
            ),
          ),

          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialPos,
              polylines: _polylines,
              myLocationButtonEnabled: false,
              zoomControlsEnabled: true,
              onMapCreated: (c) async {
                _mapController = c;
                await Future.delayed(const Duration(milliseconds: 300));
                await _fitBounds();
              },
            ),
          ),
        ],
      ),
    );
  }
}

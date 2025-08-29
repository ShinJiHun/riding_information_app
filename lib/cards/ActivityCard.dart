import 'package:flutter/material.dart';
import '../models/activity.dart';
import 'package:riding_information_app/cards/ActivityDetailPage.dart';
import '../cards//polyline_preview.dart'; // ← 추가

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final String heroTag;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => ActivityDetailPage(
              activity: activity,
              heroTag: heroTag,
            ),
          ));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(activity.date, style: Theme.of(context).textTheme.bodySmall),
                  Text(activity.device, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: 8),

              Text(activity.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              Text(activity.content, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),

              Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: PolylinePreview(
                      encodedPolyline: activity.polyline,     // ← 모델에 폴리라인 문자열
                      strokeWidth: 3,
                      strokeColor: Colors.indigo.shade700,
                      backgroundColor: Colors.grey.shade100,
                      padding: const EdgeInsets.all(16),
                      drawStartEnd: true,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

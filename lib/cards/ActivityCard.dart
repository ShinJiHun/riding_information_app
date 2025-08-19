import 'package:flutter/material.dart';
import '../models/activity.dart';
import 'package:riding_information_app/cards/ActivityDetailPage.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final String staticMapBaseUrl; // 예: https://api.example.com/maps/static
  final String heroTag; // 고유값: id가 있으면 "activity_${id}"

  const ActivityCard({
    super.key,
    required this.activity,
    required this.staticMapBaseUrl,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    final mapUrl = '$staticMapBaseUrl/${Uri.encodeComponent(activity.title)}.png'
        '?w=${MediaQuery.of(context).size.width.toInt()}&h=220';
    // ↑ 임시: id가 있으면 id를 쓰세요. (ex. "$staticMapBaseUrl/${activity.id}.png?...")

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
              // 날짜 + 기기
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(activity.date, style: Theme.of(context).textTheme.bodySmall),
                  Text(activity.device, style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
              const SizedBox(height: 8),

              // 타이틀
              Text(activity.title,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),

              // 본문
              Text(activity.content, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 12),

              // 정적 지도 이미지
              Hero(
                tag: heroTag,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: AspectRatio(
                    aspectRatio: 16/9,
                    child: Image.network(
                      mapUrl,
                      fit: BoxFit.cover,
                      loadingBuilder: (c, child, p) => p == null ? child : const Center(child: CircularProgressIndicator()),
                      errorBuilder: (c, e, s) => Container(
                        color: Colors.grey.shade200,
                        alignment: Alignment.center,
                        child: const Text('지도를 불러올 수 없습니다'),
                      ),
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

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../cards/ActivityCard.dart';
import '../models/activity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const String _apiBase = 'http://localhost:8085';
  static const String _staticMapBase = 'http://localhost:8085/maps/static';

  List<Activity> activities = [];
  bool loading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchActivities();
  }

  Future<void> fetchActivities() async {
    try {
      final uri = Uri.parse("$_apiBase/api/activities");
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          activities = data.map((e) => Activity.fromJson(e)).toList();
          loading = false;
        });
      } else {
        throw Exception("Failed to load activities: ${response.statusCode}");
      }
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (error != null) {
      return Center(child: Text('에러: $error'));
    }
    if (activities.isEmpty) {
      return const Center(child: Text('표시할 활동이 없습니다.'));
    }

    return RefreshIndicator(
      onRefresh: fetchActivities,
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 12, top: 12),
        itemCount: activities.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (context, i) {
          final a = activities[i];
          final heroTag = 'activity_${i}_${a.title.hashCode}';
          return ActivityCard(
            activity: a,
            staticMapBaseUrl: _staticMapBase,
            heroTag: heroTag,
          );
        },
      ),
    );
  }
}

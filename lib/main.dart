import 'package:flutter/material.dart';
import 'mainpages/homescreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const RidingApp());
}

class RidingApp extends StatelessWidget {
  const RidingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '라이딩그램',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true, // 가운데 정렬
        title: const Text(
          '라이딩그램',
          style: TextStyle(
            fontFamily: 'NotoSansKR', // ✅ AppBar 전용 폰트 적용
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const HomeScreen(), // ✅ 홈 화면에 ActivityCard 리스트 표시
    );
  }
}

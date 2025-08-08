import 'package:flutter/material.dart';
import 'package:riding_information_app/mainpages/homescreen.dart';
import 'package:riding_information_app/mainpages/mylikescreen.dart';
import 'package:riding_information_app/mainpages/showgridscreen.dart';
import 'package:riding_information_app/mainpages/myscreen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  // ✅ items 리스트를 별도로 정의
  final List<BottomNavigationBarItem> bottomItems = const [
    BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
    BottomNavigationBarItem(label: '모아보기', icon: Icon(Icons.grid_view)),
    BottomNavigationBarItem(label: '내가 라이크 누른 컨텐츠', icon: Icon(Icons.favorite)),
    BottomNavigationBarItem(label: '내 페이지', icon: Icon(Icons.account_circle)),
  ];

  final List<Widget> pages = [
    HomeScreen(),
    ShowGridScreen(),
    MyLikeScreen(),
    MyScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '라이딩그램',
          style: TextStyle(
            fontFamily: 'NotoSansKR',
            fontSize: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 3,
        automaticallyImplyLeading: false,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.withOpacity(0.4),
            height: 1.0,
          ),
        ),
      ),

      // ✅ Scaffold의 속성으로 둬야 함
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.6),
        selectedFontSize: 16,   // 글자 크기 조절
        unselectedFontSize: 12,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: bottomItems,
      ),

      body: pages[_selectedIndex],
    );
  }
}

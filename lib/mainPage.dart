import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(label: '1번', icon: Icon(Icons.favorite)),
    BottomNavigationBarItem(label: '2번', icon: Icon(Icons.home)),
    BottomNavigationBarItem(label: '3번', icon: Icon(Icons.search)),
    BottomNavigationBarItem(label: '4번', icon: Icon(Icons.person)),
  ];

  List pages = [
    Container(child: Center(child: Text("1번입니다"))),
    Container(child: Center(child: Text("2번입니다"))),
    Container(child: Center(child: Text("3번입니다"))),
    Container(child: Center(child: Text("4번입니다"))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('메인페이지'),
        automaticallyImplyLeading: false, // 뒤로가기 버튼 제거
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.6),
        selectedFontSize: 14,
        unselectedFontSize: 10,
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: bottomItems,
      ),
      body: pages[_selectedIndex],
    );
  }
}

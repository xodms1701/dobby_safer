import 'package:doby_safer/config/db_helper.dart';
import 'package:doby_safer/pages/home/home_view.dart';
import 'package:doby_safer/pages/mypage/mypage_view.dart';
import 'package:doby_safer/pages/statistics/statistics_view.dart';
import 'package:flutter/material.dart';

void main() async {
  await Future.delayed(const Duration(seconds: 1));

  runApp(const MyApp());

  // 기본 값 세팅
  DBHelper dbHelper = DBHelper();
  await dbHelper.insertDefaultConfig();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '도비 지킴이',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WrapperWidget(),
    );
  }
}


class WrapperWidget extends StatefulWidget {
  const WrapperWidget({super.key});

  @override
  State<WrapperWidget> createState() => _WrapperWidgetState();
}

class _WrapperWidgetState extends State<WrapperWidget> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  static const List<Widget> _widgetOptions = <Widget>[
    HomeView(),
    StatisticsView(),
    MyPageView(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: '통계',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '마이페이지',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}
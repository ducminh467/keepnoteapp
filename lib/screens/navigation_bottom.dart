
import 'package:flutter/material.dart';
import 'package:flutterfirebase/screens/homepage.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


import 'home.dart';


class SalomonBottom extends StatefulWidget {
  const SalomonBottom({Key? key}) : super(key: key);
  static const String id = 'bottom';
  @override
  State<SalomonBottom> createState() => _SalomonBottomState();
}

class _SalomonBottomState extends State<SalomonBottom> {
  int _currentIndex = 0;
  final List _screen = [
    const Home(),
    const Homepage(),
  ];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        curve: Curves.fastLinearToSlowEaseIn,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          print(index);
        },
        items: [
          SalomonBottomBarItem(
            icon: Icon(Icons.edit),
            title: Text("Ghi chú thường"),
            selectedColor: Colors.red,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.check_box),
            title: Text("Hộp ghi chú"),
            selectedColor: Colors.red,
          ),
        ],
      ),
      body: _screen[_currentIndex],
    );
  }
}


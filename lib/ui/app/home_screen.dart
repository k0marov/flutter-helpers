import 'package:dartz/dartz.dart' show Tuple2;
import 'package:flutter/material.dart';

typedef MainScreens = List<Tuple2<Widget, BottomNavigationBarItem>>;

class HomeScreen extends StatefulWidget {
  final MainScreens screens;
  const HomeScreen({
    Key? key,
    required this.screens,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.screens[_currentIndex].value1,
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        items: widget.screens.map((screen) => screen.value2).toList(),
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (ind) => setState(() => _currentIndex = ind),
      ),
    );
  }
}

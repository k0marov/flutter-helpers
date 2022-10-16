import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  static const screens = []; // TODO: add screens here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_currentIndex],
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        onTap: (ind) => setState(() => _currentIndex = ind),
      ),
    );
  }
}

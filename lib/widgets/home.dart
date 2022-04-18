import 'package:flutter/material.dart';

import 'movie_list.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return HomeState();
  }
}

class HomeState extends State<Home> {
  List<Widget> _bottomNavPages = [];
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _bottomNavPages = [
      const MovieList(),
      const Center(child: Text("Contacts")),
      const Center(child: Text("NearMe")),
      const Center(child: Text("Person"))
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavPages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.contacts), label: "Contacts"),
          BottomNavigationBarItem(icon: Icon(Icons.near_me), label: "NearMe"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Person"),
        ],
        backgroundColor: Colors.grey,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.blueGrey,
        currentIndex: _selectedIndex,
        onTap: _onBottomNavigationBarItemTapped,
      ),
    );
  }

  void _onBottomNavigationBarItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

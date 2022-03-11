import 'package:flutter/material.dart';
import 'package:spacex_api/ui/components/map.dart';
import 'package:spacex_api/ui/components/past_launches.dart';
import 'package:spacex_api/ui/components/upcoming_launches.dart';
import 'package:spacex_api/ui/launch_detail.dart';

import '../core/model/launch.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController scrollController = ScrollController();

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    UpcomingLaunches("Next launch:"),
    PastLaucnhes(),
    MapSample(),
    Text('Info not implemented yet'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch_later),
            label: 'Past',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.rocket),
            label: 'Info',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
      ),
    ); // trailing comma makes auto-formatting nicer for build methods.
  }
}

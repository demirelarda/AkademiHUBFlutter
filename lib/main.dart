import 'package:flutter/material.dart';
import 'home_page.dart';
import 'post_page.dart';
import 'rank_page.dart';
import 'account_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bottom Navigation Bar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Bottom Navigation Bar Demo'),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/post': (BuildContext context) => PostPage(),
        '/rank': (BuildContext context) => RankPage(),
        '/account': (BuildContext context) => AccountPage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    PostPage(),
    RankPage(),
    AccountPage(),
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
        backgroundColor: Colors.white,
        elevation: 20, // gölge ekleme
        type: BottomNavigationBarType.fixed, // item'lar fixed olsun
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.blueGrey),
            activeIcon: Icon(Icons.home, color: Colors.blue),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add, color: Colors.blueGrey),
            activeIcon: Icon(Icons.post_add, color: Colors.blue),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sort, color: Colors.blueGrey),
            activeIcon: Icon(Icons.sort, color: Colors.blue),
            label: 'Rank',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color:Colors.blueGrey),
            activeIcon: Icon(Icons.account_circle, color: Colors.blue),
            label: 'Account',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

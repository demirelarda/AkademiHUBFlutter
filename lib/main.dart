import 'package:akademi_hub_flutter/login_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'home_page.dart';
import 'post_page.dart';
import 'rank_page.dart';
import 'account_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // This is the last thing you need to add.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AkademiHUB',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _Wrapper(),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => HomePage(),
        '/post': (BuildContext context) => PostPage(),
        '/rank': (BuildContext context) => RankPage(),
        '/account': (BuildContext context) => AccountPage(),
        '/login': (context) => LoginPage(title: 'Login')
      },
    );
  }
}

class _Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.data?.uid == null) {
            return LoginPage(title: '',);
          } else {
            return MyHomePage(title: 'AkademiHUB'); //eğer kullanıcı giriş yaptıysa direkt olarak Login'i geç
          }
        } else {
          return CircularProgressIndicator();
        }
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
        elevation: 20,
        // gölge ekleme
        type: BottomNavigationBarType.fixed,
        // item'lar fixed olsun
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
            icon: Icon(Icons.account_circle, color: Colors.blueGrey),
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


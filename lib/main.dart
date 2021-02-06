import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:futcrick/AuthService.dart';
import 'package:futcrick/Constants.dart';
import 'package:futcrick/Extension.dart';
import 'package:futcrick/pages/BlogPost.dart';
import 'package:futcrick/pages/Home.dart';
import 'package:futcrick/pages/Profile.dart';
import 'package:provider/provider.dart';

import 'pages/SignIn.dart';
import 'pages/matches/Matches.dart';
import 'pages/team.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

final CollectionReference postRef =
    FirebaseFirestore.instance.collection('posts');

final CollectionReference likedRef =
    FirebaseFirestore.instance.collection('liked');

final CollectionReference commentsRef =
    FirebaseFirestore.instance.collection('comments');

final CollectionReference matchesRef =
    FirebaseFirestore.instance.collection('matches');

final CollectionReference usersRef =
    FirebaseFirestore.instance.collection('users');

final CollectionReference trophiesRef =
    FirebaseFirestore.instance.collection('trophies');

final Timestamp timeStamp = Timestamp.now();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
            create: (_) => AuthService(FirebaseAuth.instance)),
        StreamProvider(
            create: (context) => context.read<AuthService>().authStateChanges)
      ],
      child: MaterialApp(
        title: 'Futcrick',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: AuthenticationWrapper(),
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final User _firebaseUser = context.watch<User>();

    if (_firebaseUser != null) {
      print(_firebaseUser.displayName);
      print(_firebaseUser.email);
      print(_firebaseUser.photoURL);
      print(_firebaseUser.uid);
      return MainScreen(user: _firebaseUser);
    }
    return SignIn();
  }
}

class MainScreen extends StatefulWidget {
  final User user;

  MainScreen({Key key, title, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final List<Widget> pages = [];
  int _currentPageIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    pages.add(MyHomePage(user: widget.user));
    pages.add(Matches());
    pages.add(Team());
    pages.add(BlogPost());
    pages.add(Profile());
    _pageController = PageController(initialPage: 2);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: PageView(
        onPageChanged: (index) {
          setState(() {
            _currentPageIndex = index;
          });
        },
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: pages,
      )), //pages[
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                  color: backgroundColor,
                  offset: Offset(0, 0),
                  blurRadius: 20,
                  spreadRadius: 3)
            ]),
        child: Row(
          children: [
            navBarItem(Icons.home, Icons.home_outlined, 0),
            navBarItem(Icons.group_rounded, Icons.group_outlined, 2),
            navBarItem(
                Icons.sports_soccer_rounded, Icons.sports_soccer_rounded, 1),
            navBarItem(Icons.whatshot, Icons.whatshot_outlined, 3),
            navBarItem(Icons.account_circle, Icons.account_circle_outlined, 4),
          ],
        ),
      ),
    );
  }

  GestureDetector navBarItem(
      IconData selectedIcon, IconData unSelectedIcon, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _currentPageIndex = index;
          _pageController.jumpToPage(index);
        });
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 30) / 5,
        child: Icon(index == _currentPageIndex ? selectedIcon : unSelectedIcon,
            color: index == _currentPageIndex ? Colors.white : Colors.white54),
      ).center(),
    );
  }
}

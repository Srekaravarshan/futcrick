import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:futcrick/AuthService.dart';
import 'package:futcrick/Constants.dart';
import 'package:futcrick/pages/Home.dart';
import 'package:futcrick/pages/Profile.dart';
import 'package:provider/provider.dart';
import 'pages/SignIn.dart';
import 'package:futcrick/Extension.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MultiProvider(providers: [
      Provider<AuthService>(create: (_) => AuthService(FirebaseAuth.instance)),
      StreamProvider(create: (context) => context.read<AuthService>().authStateChanges)
    ],
      child: MaterialApp(
        title: 'Futcrick',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: AuthenticationWrapper(),
      ),);
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final User _firebaseUser = context.watch<User>();

    if(_firebaseUser != null){
      print(_firebaseUser.displayName);
      print(_firebaseUser.email);
      print(_firebaseUser.photoURL);
      print(_firebaseUser.uid);
      return MainScreen();
    }
    return SignIn();
  }
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  List<Widget> pages = [MyHomePage(), Profile()];
  int _currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: pages[_currentPageIndex],
      bottomNavigationBar: Container(
        height: 60,
        margin: EdgeInsets.only(left: 15, right: 15, bottom: 15),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Row(
          children: [
            navBarItem(Icons.home, Icons.home_outlined, 0),
            navBarItem(Icons.person ,Icons.person_outline_rounded, 1)
          ],
        ),
      ),
    );
  }

  GestureDetector navBarItem(IconData selectedIcon, IconData unSelectedIcon, int index){
    return GestureDetector(
      onTap: (){
        setState(() {
          _currentPageIndex = index;
        });
      },
      child: Container(
        width: (MediaQuery.of(context).size.width - 30)/pages.length,
        child: Icon(index == _currentPageIndex ? selectedIcon : unSelectedIcon),
      ).center(),
    );
  }

}



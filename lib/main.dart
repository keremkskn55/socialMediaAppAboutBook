import 'package:book_app/screens/sign_in_screen.dart';
import 'package:book_app/services/auth.dart';
import 'package:book_app/services/storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'on_board.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Auth>(create: (context) => Auth()),
        Provider<Storage>(create: (context) => Storage()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MainApp(),
      ),
    );
  }
}

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return OutBoard(
            textInfo: 'Error',
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return OnBoard();
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return OutBoard(
          textInfo: 'Loading',
        );
      },
    );
  }
}

class OutBoard extends StatelessWidget {
  String textInfo;
  OutBoard({required this.textInfo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(textInfo),
      ),
    );
  }
}

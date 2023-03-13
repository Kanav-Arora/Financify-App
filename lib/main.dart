import 'dart:async';
import 'package:accouting_software/screens/home_screen.dart';
import 'package:accouting_software/screens/login_screen.dart';
import 'package:accouting_software/screens/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FirebaseAuth.instance.signOut();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription<User?> user;
  void initState() {
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    user = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    user.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Accounting App',
      theme: ThemeData(
        primaryColor: Colors.white,
        textTheme: const TextTheme(
          labelMedium: TextStyle(color: Colors.black, fontSize: 18),
          bodyMedium: TextStyle(color: Colors.black, fontSize: 15),
        ),
        colorScheme:
            Theme.of(context).colorScheme.copyWith(secondary: Colors.black),
        appBarTheme: const AppBarTheme(
          color: Colors.white,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 35,
          ),
        ),
      ),
      darkTheme: ThemeData(
          primaryColor: const Color.fromARGB(255, 16, 16, 16),
          textTheme: const TextTheme(
            labelMedium: TextStyle(color: Colors.white, fontSize: 18),
            bodyMedium: TextStyle(color: Colors.white, fontSize: 15),
          ),
          colorScheme:
              Theme.of(context).colorScheme.copyWith(secondary: Colors.white),
          appBarTheme: const AppBarTheme(
              color: Color.fromARGB(255, 16, 16, 16),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 35))),
      themeMode: ThemeMode.dark,
      routes: {
        LoginScreen.routeName: (ctx) => LoginScreen(),
        SignupScreen.routeName: (ctx) => SignupScreen(),
        HomeScreen.routeName: (ctx) => HomeScreen(),
      },
      initialRoute: FirebaseAuth.instance.currentUser == null
          ? LoginScreen.routeName
          : HomeScreen.routeName,
      home: LoginScreen(),
    );
  }
}

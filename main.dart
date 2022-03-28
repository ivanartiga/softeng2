import 'package:flutter/material.dart';
import 'package:softengapp/screens/login.dart';
import 'package:softengapp/screens/userdashboard.dart';
import 'package:softengapp/screens/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/userdashboard': (context) => Userdashboard(),
        '/register': (context) => Register(),
      },
      title: 'Barangay Basak Assistance System',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}


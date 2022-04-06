import 'package:flutter/material.dart';
import 'package:softengapp/screens/login.dart';
import 'package:softengapp/screens/userdashboard.dart';
import 'package:softengapp/screens/register.dart';
import 'package:softengapp/screens/userprofile.dart';
import 'package:softengapp/screens/utilities.dart';
import 'package:softengapp/screens/documentrequests.dart';
import 'package:softengapp/screens/complaints.dart';
import 'package:softengapp/screens/organization.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
        '/services/utilities': (context) => Utilities(),
        '/services/complaints': (context) => Complaints(),
        '/services/documentrequests': (context) => Documentrequests(),
        '/organization': (context) => Organization(),
        '/userprofile': (context) => Userprofile(),
      },
      title: 'Barangay Basak Assistance System',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
    );
  }
}


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:softengapp/widgets/navigationdrawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../model/user_model.dart';

class Userprofile extends StatefulWidget {
  const Userprofile({Key? key}) : super(key: key);

  @override
  State<Userprofile> createState() => _UserprofileState();
}

class _UserprofileState extends State<Userprofile> {


  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance
    .collection("users")
    .doc(user!.uid)
    .get()
    .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,title: Text('User Profile')),
        drawer: Navigationdrawer(),
        body: Padding(
    padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      Divider(
    color: Colors.grey[800],
    height: 60.0,
    ),
    Text(
    'NAME',
    style: TextStyle(
    color: Colors.grey,
    letterSpacing: 2.0,
    ),
    ),
    SizedBox(height: 10.0),
    Text(
    "${loggedInUser.firstName} ${loggedInUser.lastName}",
    style: TextStyle(
    color: Colors.blueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 28.0,
    letterSpacing: 2.0,
    ),
    ),
    SizedBox(height: 30.0),
      Text(
        'SITIO',
        style: TextStyle(
          color: Colors.grey,
          letterSpacing: 2.0,
        ),
      ),
      SizedBox(height: 10.0),
      Text(
        "${loggedInUser.sitio}",
        style: TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
          letterSpacing: 2.0,
        ),
      ),
      SizedBox(height: 30.0),
    Text(
    'PUROK',
    style: TextStyle(
    color: Colors.grey,
    letterSpacing: 2.0,
    ),
    ),
    SizedBox(height: 10.0),
    Text(
    '${loggedInUser.purok}',
    style: TextStyle(
    color: Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 28.0,
    letterSpacing: 2.0,
    ),
    ),
    SizedBox(height: 30.0),
      Text(
        'DATE OF BIRTH',
        style: TextStyle(
          color: Colors.grey,
          letterSpacing: 2.0,
        ),
      ),
      SizedBox(height: 10.0),
      Text(
        "${loggedInUser.dateOfBirth}",
        style: TextStyle(
          color: Colors.orange,
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
          letterSpacing: 2.0,
        ),
      ),
      SizedBox(height: 30.0),
    Text(
    'GENDER',
    style: TextStyle(
    color: Colors.grey,
    letterSpacing: 2.0,
    ),
    ),
    SizedBox(height: 10.0),
    Text(
    '${loggedInUser.gender}',
    style: TextStyle(
    color: Colors.orange,
    fontWeight: FontWeight.bold,
    fontSize: 28.0,
    letterSpacing: 2.0,
    ),
    ),
    SizedBox(height: 30.0),
    Row(
    children: <Widget>[
    Icon(
    Icons.email,
    color: Colors.grey[400],
    ),
    SizedBox(width: 10.0),
    Text(
    '${loggedInUser.email}',
    style: TextStyle(
    color: Colors.grey[400],
    fontSize: 18.0,
    letterSpacing: 1.0,
    ),
    )
    ],
    ),
    ],
    ),

    ));
  }
}

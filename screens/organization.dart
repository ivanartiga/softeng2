import 'package:flutter/material.dart';
import 'package:softengapp/widgets/navigationdrawer.dart';

class Organization extends StatefulWidget {
  const Organization({Key? key}) : super(key: key);

  @override
  State<Organization> createState() => _OrganizationState();
}

class _OrganizationState extends State<Organization> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
        drawer: Navigationdrawer(),
        appBar: AppBar(
          title: Text("Barangay Basak Organizational Structure",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:softengapp/widgets/navigationdrawer.dart';

class Complaints extends StatefulWidget {
  const Complaints({Key? key}) : super(key: key);

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(backgroundColor: Colors.white,
          drawer: Navigationdrawer(),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Complaints and Appointments"),
              bottom: TabBar(
                  tabs: [
                    Tab(text: 'Complaints', icon: Icon(Icons.warning_outlined)),
                    Tab(text: 'Appointments', icon: Icon(Icons.calendar_month_outlined)),
                  ]
              )
          ),
        body: TabBarView(
          children: [
            Center(child: Text('Complaints')),
            Center(child: Text('Appointments')),
          ],
        ),
          ),
    );
  }
}


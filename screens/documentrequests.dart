import 'package:flutter/material.dart';
import 'package:softengapp/widgets/navigationdrawer.dart';

class Documentrequests extends StatefulWidget {
  const Documentrequests({Key? key}) : super(key: key);

  @override
  State<Documentrequests> createState() => _DocumentrequestsState();
}

class _DocumentrequestsState extends State<Documentrequests> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(backgroundColor: Colors.white,
          drawer: Navigationdrawer(),
          appBar: AppBar(
            centerTitle: true,
            title: Text("Document Requests"),
              bottom: TabBar(
                  tabs: [
                    Tab(text: 'Cedula', icon: Icon(Icons.sticky_note_2)),
                    Tab(text: 'Barangay Clearance', icon: Icon(Icons.document_scanner_outlined)),
                  ]
              ),
          ),
        body:
        TabBarView(
          children: [
            Center(child: Text('Cedula')),
            Center(child: Text('Barangay Clearance')),
          ],
        ),
      ),
    );
  }
}

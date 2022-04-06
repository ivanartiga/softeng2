import 'package:flutter/material.dart';
import 'package:softengapp/screens/subpages/activities.dart';
import 'package:softengapp/screens/subpages/announcements.dart';
import 'package:softengapp/screens/subpages/vmgo.dart';
import 'package:softengapp/widgets/navigationdrawer.dart';
import 'package:tuple/tuple.dart';

class Userdashboard extends StatefulWidget {
  const Userdashboard({Key? key}) : super(key: key);
  @override
  State<Userdashboard> createState() => _UserdashboardState();
}


class _UserdashboardState extends State<Userdashboard> with SingleTickerProviderStateMixin {

    final bodyGlobalKey = GlobalKey();

    final List<Tuple3> subpages = [
      Tuple3('Announcements', announcements(),Icon(Icons.volume_down_sharp)),
      Tuple3('Activities', activities(),Icon(Icons.event)),
      Tuple3('Vision and Mission', vmgo(),Icon(Icons.assessment_outlined)),
    ];

     TabController? _tabController;

    @override
    void initState() {
      _tabController = TabController(length: subpages.length, vsync: this);
      _tabController?.addListener(() => setState(() {}));
      super.initState();
    }
    @override
    void dispose() {
      _tabController?.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(

        drawer: Navigationdrawer(),
        appBar: AppBar(
          title: Text('Home'),
          bottom: TabBar(
            isScrollable: true,
          controller: _tabController,
          tabs:  subpages
              .map<Tab>((Tuple3 page) => Tab(text: page.item1, icon: page.item3))
              .toList(),
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: subpages.map<Widget>((Tuple3 page)=>page.item2).toList(),
        ),
      );
    }
  }





import 'package:flutter/material.dart';
import 'package:softengapp/screens/subpages/Multipurposereservation.dart';
import 'package:softengapp/screens/subpages/tanodservices.dart';
import 'package:softengapp/screens/subpages/tents.dart';
import 'package:softengapp/widgets/navigationdrawer.dart';
import 'package:tuple/tuple.dart';

class Utilities extends StatefulWidget {
  const Utilities({Key? key}) : super(key: key);

  @override
  State<Utilities> createState() => _UtilitiesState();
}

class _UtilitiesState extends State<Utilities> with SingleTickerProviderStateMixin {


  final bodyGlobalKey = GlobalKey();

  final List<Tuple3> subpages = [
    Tuple3('Tents, Tables & Chairs', Tents(),Icon(Icons.chair)),
    Tuple3('Barangay Tanod Services', Tanodservices(),Icon(Icons.person)),
    Tuple3('Multi Purpose Center Reservations', Multipurposereservation(),Icon(Icons.warehouse)),
  ];

  TabController? _tabController;
  int _selectedIndex = 0;
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
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: Navigationdrawer(),
      appBar: AppBar(
        title: Center(child: Text('Utilities')),
      ),
      body: subpages[_selectedIndex].item2,
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white54,
        items:
         <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: subpages[0].item3,
          label: subpages[0].item1,
        ),
        BottomNavigationBarItem(
          icon: subpages[1].item3,
          label: subpages[1].item1,
        ),
           BottomNavigationBarItem(
             icon: subpages[2].item3,
             label: subpages[2].item1,
           ),
        ],
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        backgroundColor: Colors.blue,
      ),

      /* CustomScrollView(
          slivers: [SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: Colors.blue,
            expandedHeight: 200,
            pinned: true,
            floating: true,
            flexibleSpace: FlexibleSpaceBar(title: Text('Dashboard', style: TextStyle(color: Colors.white)),
            background: Image.network('https://media.philstar.com/images/articles/lgu-barangay-hall_2018-10-07_20-38-37.jpg',fit:BoxFit.cover),
            ),
          ),
          ],
        ), */
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';


class announcements extends StatefulWidget {
  const announcements({Key? key}) : super(key: key);

  @override
  State<announcements> createState() => _announcementsState();
}

class _announcementsState extends State<announcements> {

  static const List<Tuple3> announcementList = [
    const Tuple3<String, String, String>(
        'Gwapo nakit-an sa Estaca',
        'Lima ka mga tawo ang nadakpan sa mga sakop sa National Bureau of Investigation (NBI)-7 sa managlahi nga gihimo nila nga pagpanakop sa dakbayan sa Talisay ug dakbayan sa Sugbo.',
        'Ivan Artiga'
    ),
    const Tuple3<String, String, String>(
        'Amigo Kong Tunay',
        'Daghag Amigo',
        'Ivan Artiga'
    ),
    const Tuple3<String, String, String>(
        'Feeding Program',
        'Walay Lugaw',
        'Maria Hazel Dolera'
    ),
  ];
  Widget announcementTemplate(Tuple3 announcements) {
    return
      Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(5),
              child: ListTile(
                leading: Icon(Icons.volume_down),
                title: Text(announcements.item1),
                subtitle: Text(DateTime.now().toString().substring(0, 10)),
              ),
            ),
            SizedBox(height: 100, width: 100, child: Image.asset('assets/logo_transparent.png'),),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                  announcements.item2,
                textAlign: TextAlign.left,
              ),
            ),
            Padding(padding: EdgeInsets.all(10), child: Text(announcements.item3)),
          ],
        ),
        elevation: 5,
        margin: EdgeInsets.all(10),
      );
  }
  SliverList _buildSliverContent() {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          return announcementTemplate(announcementList[index]);
        },
        childCount: announcementList.length,
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        _buildSliverContent(),
      ],
    );
  }
  }

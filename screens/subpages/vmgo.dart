import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
class vmgo extends StatefulWidget {
  const vmgo({Key? key}) : super(key: key);

  @override
  State<vmgo> createState() => _vmgoState();
}

class _vmgoState extends State<vmgo> {
  @override
  Widget build(BuildContext context) {
    return Container(child:
    Column(
      children: [
    Text('Republic of the Philippines',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
        Text('City of Lapu Lapu',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
        Text('Barangay Basak',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
      Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Container(
            width: 150,
            height: 150,
            child: Image.asset('assets/logo_transparent.png'),
          ),
        ),
      ),
        Text('Vision',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
        SizedBox(height: 10,),
        Text('To attend a peaceful, progressive and eco-friendly barangay',style: TextStyle(fontSize: 12)),
        SizedBox(height: 30,),
        Text('Mission',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,)),
        SizedBox(height: 10,),
        Text('To render fast and efficient basic services to Barangay Basak constituents',style: TextStyle(fontSize: 12)),
      ],
    ),
    padding: EdgeInsets.all(30)
      ,);
  }
}

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:softengapp/model/borrowModel.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Tents extends StatefulWidget {
  const Tents({Key? key}) : super(key: key);

  @override
  State<Tents> createState() => _TentsState();
}

class ResourceModel {
  String? supplyid;
  int? tents;
  int? tables;
  int? chairs;

  ResourceModel({this.supplyid, this.tents, this.tables, this.chairs});

  // receiving data from server
  factory ResourceModel.fromMap(map) {
    return ResourceModel(
      supplyid: map['supplyid'],
      tables: map['tables'],
      chairs: map['chairs'],
      tents: map['tents'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'supplyid': supplyid,
      'tents': tents,
      'tables': tables,
      'chairs': chairs,
    };
  }
}


class _TentsState extends State<Tents> {

  final _formKey = GlobalKey<FormState>();

  final urlImages = [
    'https://i.prcdn.co/img?regionKey=5SYYJWIPAFF%2Ftb8r6aqtDw%3D%3D',
    'https://cebudailynews.inquirer.net/files/2016/01/lahug-fire16.jpg',
    'https://lanaodelnorte.gov.ph/wp-content/uploads/2020/09/119082902_3469239919793122_6006982020007181390_o.jpg',
    'https://fionakearlonlineshopping.com/wp-content/uploads/2021/03/250690970_585285592528137_8868278838609422948_n.jpg'
  ];

  final TentQuantityController = TextEditingController();
  final ChairQuantityController = TextEditingController();
  final TableQuantityController = TextEditingController();

  ResourceModel supply = ResourceModel();
  int? tentSupply;
  int? chairSupply;
  int? tableSupply;

  @override
  void initState(){
    super.initState();
    FirebaseFirestore.instance
        .collection("resourcesSupply")
        .doc("supplyid")
        .get()
        .then((value) {
      supply = ResourceModel.fromMap(value.data());
      setState(() {
        tentSupply = supply.tents;
        chairSupply = supply.chairs;
        tableSupply = supply.tables;
      });
    });
    BorrowRequests().getUserRequests(_auth).then((QuerySnapshot docs){
      if(docs.docs.isNotEmpty)
        {
          requestFlag = true;
          requests = docs.docs;
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
              children: [
                Container(
                    padding: EdgeInsets.only(bottom: 10),
                    child:CarouselSlider.builder(itemCount: urlImages.length,
                    itemBuilder: (context,index,realIndex)
                  {
                      final urlImage = urlImages[index];
                      return buildImage(urlImage,index);
                  },
                    options: CarouselOptions(
                     autoPlay: true,
                     reverse: true,
                     height: 200,
                    )
                )),
                Center(child: Text("Tents, Tables and Chairs", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                SizedBox(width: 20,),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Card(
                    color: Colors.white70,
                    elevation: 5,
                    margin: EdgeInsets.all(10),

                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [ListTile(title: Text('Available Resources', style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Text('Tents:        ${supply.tents.toString()}    '
                            'Tables:        ${supply.tables.toString()}   '
                            'Chairs:        ${supply.chairs.toString()}', style: TextStyle(fontWeight: FontWeight.bold) ,
                        ),
                        ),
                  ]),
                ),
                ),
                Center(child: Text("Borrow Form", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                SizedBox(height: 5),
                Form(key: _formKey, child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text('Tents'),
                    TextFormField(
                      decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Tent Quantity',
                       ),
                      textInputAction: TextInputAction.next,
                      controller: TentQuantityController,
                      onSaved: (value){
                      TentQuantityController.text = value!;
                      },
                       validator: (text) {
                         if (text == null || text.isEmpty) {
                                return 'Can\'t be empty';}
                         if (RegExp("[a-zA-Z][a-zA-Z ]+[a-zA-Z]\$")
                                  .hasMatch(text)) {
                                return ("Quantity must be numeric");
                          }
                        return null;
                        },
                    ),
                    Text('Tables'),TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Enter Table Quantity',
                      ),
                      textInputAction: TextInputAction.next,
                      controller: TableQuantityController,
                      onSaved: (value){
                        TableQuantityController.text = value!;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Can\'t be empty';}
                        if (RegExp("[a-zA-Z][a-zA-Z ]+[a-zA-Z]\$")
                            .hasMatch(text)) {
                          return ("Quantity must be numeric");
                        }
                        return null;
                      },
                    ),
                    Text('Chairs'),TextFormField(decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Enter Chair Quantity',
                    ),
                      textInputAction: TextInputAction.next,
                      controller: ChairQuantityController,
                      onSaved: (value){
                        ChairQuantityController.text = value!;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Can\'t be empty';}
                        if (RegExp("[a-zA-Z][a-zA-Z ]+[a-zA-Z]\$")
                            .hasMatch(text)) {
                          return ("Quantity must be numeric");
                        }
                        return null;
                      },),
                    SizedBox(height:20),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          submitRequest();
                        },
                        child: Text(
                          'Submit Request',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    SizedBox(height:30),
                    Container(
                      height: 30,
                      width: 600,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          showInformationDialog(context);
                        },
                        child: Text(
                          'Check Requests Status',
                          style: TextStyle(color: Colors.blue, fontSize: 12),
                        ),
                      ),
                    ),
                    SizedBox(height:50),
                  ],
                ))
            ],

            ),
    );
  }

  final _auth = FirebaseAuth.instance;
  Widget buildImage(String urlImage, int index) => Container(
    margin: EdgeInsets.symmetric(horizontal: 12),
    color: Colors.grey,
    child: Image.network(urlImage,fit:BoxFit.cover),
  );

  void submitRequest() async {
    if (_formKey.currentState!.validate()) {
      try {
        if (int.parse(TentQuantityController.text) < tentSupply!
        &&int.parse(TableQuantityController.text) < tableSupply!
        &&int.parse(ChairQuantityController.text) < chairSupply!
        ) {
            postDetailsToFirestore();
        }
        else {
          Fluttertoast.showToast(msg: "Quantity must not exceed available resources");
        }
      }
      catch(e) {}
    }
    }
  postDetailsToFirestore() async {
    // calling our firestore
    // calling our borrow model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    BorrowModel borrowModel = BorrowModel();

    // writing all the values
     borrowModel.uid = user!.uid;
     borrowModel.tentQty = int.parse(TentQuantityController.text);
     borrowModel.tableQty = int.parse(TableQuantityController.text);
     borrowModel.chairQty = int.parse(ChairQuantityController.text);
     borrowModel.isApproved = false; // try
     borrowModel.isReturned = false;
     borrowModel.daterequested = DateTime.now();

    await firebaseFirestore
        .collection("borrowForms")
        .doc(borrowModel.requestid)
        .set(borrowModel.toMap());
    Fluttertoast.showToast(msg: "Request Submitted successfully :) ");
    Navigator.pushNamed(context, '/services/utilities');
  }

  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(context: context,
        builder: (context){
          return StatefulBuilder(builder: (context,setState){
            return AlertDialog(
              content: setupAlertDialoadContainer());
          });
        });
  }
  bool requestFlag = false;
  late List requests;
  Widget setupAlertDialoadContainer() {
    if(requestFlag) {
      int items = requests.length;
      return Container(
        height: 300.0, // Change as per your requirement
        width: 300.0, // Change as per your requirement
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: requests.length,
          itemBuilder: (BuildContext context, int index) {
            return requestTemplate(requests[index]);
                }
              ),
            );
          }
    else {
      return Container(child: Text("There are no pending borrow requests", style: TextStyle(fontWeight: FontWeight.bold),));
    }
    }

    Widget requestTemplate(dynamic requests){
    String status = "Pending";
    if(requests.get("isApproved"))
      {
       status = "Borrow Application Approved";
      }
    return Card(child:
      ListTile(
        title: Text(" Request ",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
        subtitle: Text("Details: Chairs: ${requests.get("chairQty")}   Tables:  ${requests.get("tableQty")}    Tents: ${requests.get("tentQty")} Status: $status ${requests.get('daterequested').toDate()}"),
      ),
    elevation: 5,
    );
    }

  }

class BorrowRequests{
  getUserRequests(FirebaseAuth _auth){
    User? user = _auth.currentUser;
    return FirebaseFirestore.instance.collection("borrowForms").where('uid', isEqualTo: user!.uid.toString()).get();
  }
}


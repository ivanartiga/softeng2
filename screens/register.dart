import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:string_validator/string_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import  'package:softengapp/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  int? _value = 1;
  DateTime? _dateTime;

  final _auth = FirebaseAuth.instance;
  // displaying error
  String? errorMessage;

  final fNameEditingController = new TextEditingController();
  final lNameEditingController = new TextEditingController();
  final purokEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final confirmPasswordEditingController = new TextEditingController();
  final dateOfBirthEditingController = new TextEditingController();
  String sitioChosen = 'Sudtonggan';
  String? gender;
  String? passwordCheck;


  var sitio = [
    'Sudtonggan',
    'Tamiya',
    'Basak Main',
    'Pakpakan',
    'Suba-Masulog',
    'Kagudoy',
  ];
  String dropdownvalue = 'Sudtonggan';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Create an Account"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child:
          Column(
            children: <Widget>[
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.all(15),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'First Name',
                      hintText: 'Enter First Name'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    fNameEditingController.text = value!;
                  },
                  controller: fNameEditingController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    if (!RegExp("[a-zA-Z][a-zA-Z ]+[a-zA-Z]\$")
                        .hasMatch(text)) {
                      return ("Invalid First Name");
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    lNameEditingController.text = value!;
                  },
                  controller: lNameEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Last Name',
                      hintText: 'Enter Last Name'),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    if (!RegExp("[a-zA-Z][a-zA-Z ]+[a-zA-Z]\$")
                        .hasMatch(text)) {
                      return ("Invalid Last Name");
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        textInputAction: TextInputAction.next,
                        onSaved: (value) {
                          dateOfBirthEditingController.text = value!;
                        },
                        controller: dateOfBirthEditingController,
                        enableInteractiveSelection: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: (_dateTime == null
                              ? 'Select Date of Birth'
                              : (_dateTime.toString()).substring(0, 10)),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.calendar_month),
                            onPressed: () {
                              showDatePicker(context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1930),
                                  lastDate: DateTime.now()
                              ).then((date) {
                                setState(() {
                                  _dateTime = date;
                                  dateOfBirthEditingController.text = _dateTime.toString().substring(0, 10);
                                });
                              });
                            },),
                        ),
                        validator: (text) {
                          if (text == null || text.isEmpty) {
                            return 'Can\'t be empty';
                          }
                          return null;
                        },
                      ),
                    ]
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                    children: <Widget>[
                      Radio<String>(
                        value: 'Male', groupValue: gender,
                        onChanged: (value) {
                          _handleGenderChange(value!);
                        },
                      ),
                      SizedBox(width: 5),
                      Text('Male'),
                      Radio<String>(
                        value: "Female",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            _handleGenderChange(value!);
                          });
                        },
                      ),
                      SizedBox(width: 5),
                      Text('Female'),
                      Radio<String>(
                        value: "Others",
                        groupValue: gender,
                        onChanged: (value) {
                          setState(() {
                            _handleGenderChange(value!);
                          });
                        },
                      ),
                      SizedBox(width: 5),
                      Text('Others'),
                    ]
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 10,
                          child: Text('Sitio: ')
                      ),
                      Expanded(
                          flex: 5,
                          child: SizedBox(width: 10)
                      ),
                      Expanded(
                        flex: 85,
                        child: Container(
                          child: DropdownButton(
                            isExpanded: true,
                            borderRadius: BorderRadius.circular(12.0),
                            // Initial Value
                            value: dropdownvalue,
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                            // Array list of items
                            items: sitio.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                sitioChosen = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ]
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Purok',
                      hintText: 'Enter Purok'),
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    purokEditingController.text = value!;
                  },
                  controller: purokEditingController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    emailEditingController.text = value!;
                  },
                  controller: emailEditingController,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                      hintText: 'Enter Email'),
                  validator: (value)
                  {
                    if (value == null || value.isEmpty) {
                      return 'Can\'t be empty';
                    }
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  onSaved: (value) {
                    passwordEditingController.text = value!;
                  },
                  controller: passwordEditingController,
                  obscureText: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      hintText: 'Enter Password'),
                  validator: (value) {
                    RegExp regex = new RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return ("Password is required for login");
                    }
                    if (!regex.hasMatch(value)) {
                      return ("Enter Valid Password(Min. 6 Character)");
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0, bottom: 15),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  onSaved: (value) {
                    confirmPasswordEditingController.text = value!;
                  },
                  controller: confirmPasswordEditingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                  ),
                  validator: (value) {
                    if (confirmPasswordEditingController.text!=passwordEditingController.text) {
                      return 'Password does not match';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(20)),
                child: TextButton(
                  onPressed: () {
                    signUp(emailEditingController.text, passwordEditingController.text);
                  },
                  child: Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _handleGenderChange(String value) {
    setState(() {
      gender = value;
    });
  }
    String chosenGender() {
      return gender!;
    }
  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "wrong-password":
            errorMessage = "Your password is wrong.";
            break;
          case "user-not-found":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "user-disabled":
            errorMessage = "User with this email has been disabled.";
            break;
          case "too-many-requests":
            errorMessage = "Too many requests";
            break;
          case "operation-not-allowed":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
        print(error.code);
      }
    }
  }
    postDetailsToFirestore() async {
      // calling our firestore
      // calling our user model
      // sending these values

      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      User? user = _auth.currentUser;

      UserModel userModel = UserModel();

      // writing all the values
      userModel.email = user!.email;
      userModel.uid = user.uid;
      userModel.firstName = fNameEditingController.text;
      userModel.lastName = lNameEditingController.text;
      userModel.dateOfBirth = dateOfBirthEditingController.text;
      userModel.sitio = sitioChosen; // try
      userModel.purok = purokEditingController.text;
      userModel.gender = chosenGender();

      await firebaseFirestore
          .collection("users")
          .doc(user.uid)
          .set(userModel.toMap());
      Fluttertoast.showToast(msg: "Account created successfully :) ");
      Navigator.pushNamedAndRemoveUntil(context, '/login', (_) => false);
    }
  }

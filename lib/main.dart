import 'dart:io';

import 'package:flutter/material.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

void main() async {
  runApp(MyApp());
}

void _showDialog(String title, String content, BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: new Text(title),
            content: new Text(content),
            actions: <Widget>[
              new FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: new Text("Close"))
            ]);
      });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController birthday = TextEditingController();
  TextEditingController location = TextEditingController();
  DateTime dob;
  bool _obscureText = true;

  var internetStatus = "Unknown";
  var contentmessage = "Unknown";

  File image;
  void onBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              color: Color(0xFF737373),
              height: 160,
              child: Container(
                margin: EdgeInsets.only(left: 0, right: 0),
                child: _bottomNavigationMenu(),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(30),
                        topRight: const Radius.circular(30))),
              ));
        });
  }

  @override
  void initState() {
    DataConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case DataConnectionStatus.connected:
          internetStatus = "Connected to the Internet";
          contentmessage = "Connected to the Internet";
          _showDialog(internetStatus, contentmessage, context);
          break;
        case DataConnectionStatus.disconnected:
          internetStatus = "You are disconnected to the Internet. ";
          contentmessage = "Please check your internet connection";
          _showDialog(internetStatus, contentmessage, context);
          break;
      }
    });
    super.initState();
  }

  Column _bottomNavigationMenu() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.camera_enhance, color: Colors.blue),
          title: Text('Click Picture', style: TextStyle(color: Colors.blue)),
          onTap: () {
            Navigator.of(context).pop();
            getImage(ImageSource.camera);
          },
        ),
        ListTile(
            leading: Icon(Icons.image, color: Colors.blue),
            title: Text(
              'Select image from Phone Gallery',
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () {
              Navigator.of(context).pop();
              getImage(ImageSource.gallery);
            }),
      ],
    );
  }

  Future getImage(source) async {
    image = await ImagePicker.pickImage(source: source);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Registration Screen"),
          centerTitle: true,
          backgroundColor: Colors.green,
        ),
        body: new Container(
          color: Colors.white,
          child: new ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  new Container(
                    height: MediaQuery.of(context).size.height / 4,
                    color: Colors.white,
                    child: new Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 20.0),
                          child:
                              new Stack(fit: StackFit.loose, children: <Widget>[
                            new Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                new Container(
                                    width: 140.0,
                                    height: 140.0,
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                        image: image != null
                                            ? FileImage(image)
                                            : new NetworkImage(
                                                "https://cdn0.iconfinder.com/data/icons/professional-avatar-5/48/Gamer_male_avatar_men_character_professions-512.png"),
                                        fit: BoxFit.cover,
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                                padding:
                                    EdgeInsets.only(top: 90.0, right: 100.0),
                                child: new Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    GestureDetector(
                                      onTap: () {
                                        onBottomSheet(
                                          context,
                                        );
                                      },
                                      child: new CircleAvatar(
                                        backgroundColor: Colors.green,
                                        radius: 25.0,
                                        child: new Icon(
                                          Icons.camera_alt,
                                          color: Colors.white,
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          ]),
                        )
                      ],
                    ),
                  ),
                  new Container(
                    color: Color(0xffFFFFFF),
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 25.0),
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Parsonal Information',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'User Name',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      controller: controller,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[a-zA-Z]')),
                                      ],
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Name",
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Email Id',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      decoration: const InputDecoration(
                                        hintText: "Enter Your Email",
                                      ),
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Mobile',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "mobile no",
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Password',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 2.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Flexible(
                                    child: new TextField(
                                      obscureText: _obscureText,
                                      decoration: InputDecoration(
                                          hintText: "Enter Password",
                                          suffixIcon: IconButton(
                                            icon: Icon(
                                              _obscureText
                                                  ? Icons.visibility_off
                                                  : Icons.visibility,
                                              color: Colors.black,
                                            ),
                                            onPressed: () => setState(() =>
                                                _obscureText = !_obscureText),
                                          )),
                                    ),
                                  ),
                                ],
                              )),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Date of Birth',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(
                                context,
                                showTitleActions: true,
                                locale: LocaleType.en,
                                minTime: DateTime(1930, 1, 1),
                                maxTime: DateTime.now(),
                                currentTime: dob,
                                onChanged: (date) {},
                                onConfirm: (date) {
                                  setState(() {
                                    birthday.text = DateFormat.yMMMd()
                                        .format(DateTime.parse(date.toString()))
                                        .toString()
                                        .toString();
                                    dob = date;
                                  });
                                },
                              );
                            },
                            child: Padding(
                                padding: EdgeInsets.only(
                                    left: 25.0, right: 25.0, top: 2.0),
                                child: new Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    new Flexible(
                                      child: new TextField(
                                          controller: birthday,
                                          /* autofillHints: [
                                            AutofillHints.birthday
                                          ], */
                                          enabled: false,
                                          decoration: InputDecoration(
                                            hintText: "Birthday",
                                          )),
                                    ),
                                  ],
                                )),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 25.0, right: 25.0, top: 25.0),
                              child: new Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  new Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      new Text(
                                        'Gender',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 20),
                            child: Container(
                              height: 55,
                              child: DropdownButtonFormField(
                                  isDense: true,
                                  style: TextStyle(fontSize: 14),
                                  decoration: InputDecoration(
                                    hintText: "Gender",
                                    // contentPadding: EdgeInsets.only(bottom: 2, top:5,right: 8, left: 8),
                                    filled: true,
                                    fillColor: Colors.white,
                                    disabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 1.0),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color:
                                              Theme.of(context).primaryColor),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                  isExpanded: true,
                                  items: ["Male", "Female", "Other"]
                                      .map((item) => DropdownMenuItem(
                                            child: Text(
                                              item,
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            value: item,
                                          ))
                                      .toList(),
                                  onChanged: (val) {
                                    print(val);
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 25.0, right: 25.0, bottom: 45.0, top: 20),
                child: new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                        width: 200,
                        height: 40,
                        child: new RaisedButton(
                          child: new Text("Save"),
                          textColor: Colors.white,
                          color: Colors.green,
                          onPressed: () async {},
                          shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                        )),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

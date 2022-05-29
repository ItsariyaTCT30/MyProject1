import 'dart:io';

import 'package:bordered_text/bordered_text.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';
import 'package:login_logout_app/Screens/Index.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';
import 'package:login_logout_app/Screens/Menu/disease.dart';
import 'package:login_logout_app/Screens/Menu/favorite.dart';
import 'package:login_logout_app/Screens/Menu/herb.dart';
import 'package:login_logout_app/Screens/Menu/search.dart';
import 'package:login_logout_app/Screens/Menu2.dart';
import 'package:login_logout_app/Screens/admin/backend/admin_data.dart';
import 'package:login_logout_app/Screens/components/Herb_Details_Screens.dart';
import 'package:login_logout_app/Screens/index_home.dart';
import 'package:login_logout_app/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:path/path.dart' as path;

class Herb1 extends StatefulWidget {
  final String ssname;
  const Herb1({
    Key? key,
    required this.ssname,
  }) : super(key: key);

  @override
  _Herb1State createState() => _Herb1State();
}

class _Herb1State extends State<Herb1> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  var isSelected = false;
  var icon = Icons.favorite_border;

  String email = 'lemail';
  String password = 'lpassword';
  bool isloading = false;

  _signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  FirebaseStorage storage = FirebaseStorage.instance;
  String? fName, fEName, fDName, fHName, fimgURL;
  final formKey = GlobalKey<FormState>();
  var file;
  final picker = ImagePicker();
  File? fimageFile;
  String? filefName;
  String? filefEName;
  String? filefDName;
  String? filefHName;

  ListResult? result;
  List<Reference>? allFiles;
  String? fileUrl;
  FullMetadata? fileMeta;

  //ประกาศตัวแปรอ้างอิงไปยัง Child ที่ต้องการ

  final fdbfirebase = FirebaseDatabase.instance.reference().child('favorite');

  Future<void> createData(fimgURL, fName, fEName, fDName, fHName) async {
    // if (file != null) {
    try {
      await fdbfirebase.push().set({
        'ftName': fName,
        'feName': fEName,
        'fdName': fDName,
        'fhName': fHName,
        'fimgURL': fimgURL,
        'amonth': 0,
      }).then((value) {
        formKey.currentState!.reset();
        file = null;
        print("Success");
      }).catchError((onError) {
        print(onError.code);
        print(onError.message);
      });
      final snackBar =
          SnackBar(content: Text('สมุนไพรได้เพิ่มในลิสต์ของคุณแล้ว'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(filefName);
      print(filefEName);
      print(filefDName);
      print(filefHName);
      print(fimageFile);
      setState(() {});
    } on FirebaseException catch (error) {
      print(error);
    }
    // }
  }

  //Function สำหรับแก้ไขข้อมูล
  Future<void> updateData(String key, int amonth, String op) async {
    try {
      if (op == "add") {
        fdbfirebase.child(key).update({
          'amonth': amonth + 1,
        }).then((value) {
          print('Success');
        }).catchError((onError) {
          print(onError.code);
          print(onError.message);
        });
      } else if (op == "sub") {
        fdbfirebase.child(key).update({
          'amonth': amonth - 1,
        }).then((value) {
          print('Success');
        }).catchError((onError) {
          print(onError.code);
          print(onError.message);
        });
      }
    } catch (e) {
      print(e);
    }
  }

//-----------------------------------------------------------------------------------------------
  final hdbfirebase = FirebaseDatabase.instance.reference().child('Food');

  Future<void> orderN() async {
    var db = FirebaseDatabase.instance.reference().child("Food");
    db.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = snapshot.value;
      //print(values.toString());
      values.forEach((k, v) async {
        print(k);
        //print(v["amonth"]);
        if (v["amonth"] > 0) {
          await FirebaseDatabase.instance
              .reference()
              .child('Order')
              // .child(widget.tableName)
              .push()
              .set({
            //  'tableN': widget.tableName,
            'tName': v["tName"],
            'eName': v["eName"],
            'hName': v["hName"],
            'dName': v["dName"],
            'imgURL': v["imgURL"],
            'amonth': v["amonth"],
          }).then((value) {
            print("Update Success");
            hdbfirebase.child(k).update({
              'amonth': 0,
            }).then((value) {
              print('Success');
            }).catchError((onError) {
              print(onError.code);
              print(onError.message);
            });
          }).catchError((onError) {
            print(onError.code);
            print(onError.message);
          });
          //
        }
      });
      //  await _order(widget.tableName);
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Flexible(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: AssetImage("asset/image/123321.jpg"),
                ),
                accountEmail: Text('itsariya175@gmail.com'),
                accountName: Text(
                  'Itsariya Narong',
                  style: TextStyle(fontSize: 24.0),
                ),
                decoration: BoxDecoration(
                  color: gColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_rounded, size: 32, color: gColor),
                title: Text(
                  'หน้าหลัก',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contex) => IndexHome(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: ImageIcon(
                    AssetImage("asset/image/herbal-spa-treatment-leaves.png"),
                    size: 32,
                    color: gColor),
                title: Text(
                  'สมุนไพร',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contex) => Herb(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.sick, size: 32, color: gColor),
                title: Text(
                  'ข้อบ่งใช้',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contex) => Menu2(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.insert_drive_file_rounded,
                    size: 32, color: gColor),
                title: Text(
                  'คลังข้อมูล',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contex) => Data(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: Icon(Icons.favorite, size: 32, color: gColor),
                title: Text(
                  'สิ่งที่ฉันถูกใจ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contex) => favorite(),
                    ),
                  );
                },
              ),
              SizedBox(
                height: size.height * 0.15,
              ),
              Container(
                height: 1,
                width: 1,
                color: ttColor,
              ),
              ListTile(
                leading: Icon(Icons.logout, size: 32, color: gColor),
                title: Text(
                  'ออกจากจากระบบ',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                onTap: () async {
                  await _signOut();
                  if (_firebaseAuth.currentUser == null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Index()),
                    );
                  }
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          backgroundColor: gColor,
          title: Text(
            "Medicinal Herbs",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: [
            /*  IconButton(
              iconSize: 32,
              onPressed: () async {
                await _signOut();
                if (_firebaseAuth.currentUser == null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Index()),
                  );
                }
              },
              icon: Icon(Icons.logout),
            )*/
            IconButton(
                onPressed: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => SearchPage())),
                icon: Icon(Icons.search))
          ],
        ),
        body: Stack(children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'asset/image/path.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Form(
            key: formKey,
            child: Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                //    crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'สมุนไพร',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Herb',
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  /*  Container(
                    decoration: BoxDecoration(
                      color: Color(0xffffffff).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 200,
                          padding: EdgeInsets.only(left: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hintStyle: TextStyle(color: Colors.white),
                                hintText: 'Search',
                                border: InputBorder.none),
                          ),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                            ),
                            onPressed: null),
                      ],
                    ),
                  ),*/
                  SizedBox(
                    height: 25,
                  ),
                  Expanded(
                    flex: 12,
                    child: FirebaseAnimatedList(
                      query: hdbfirebase,
                      itemBuilder: (context, snapshot, animation, index) {
                        return //Control(),
                            snapshot.value['tName'] == widget.ssname
                                ? Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => DetailsScreens(
                                                imgURL:
                                                    snapshot.value['imgURL'],
                                                name: snapshot.value['tName'],
                                                ename: snapshot.value['eName'],
                                                dname: snapshot.value['dName'],
                                              ),
                                            ),
                                          );
                                        },
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(10),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(50),
                                          ),
                                          child: Container(
                                            height: 170,
                                            color: Colors.grey,
                                            child: Stack(
                                              children: <Widget>[
                                                Align(
                                                  child: Image.network(
                                                    ('${snapshot.value['imgURL']}'),
                                                    width: 400,
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                                //-------------------------------------------

                                                //---------------------------------------
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: IconButton(
                                                    icon: Icon(Icons.favorite,
                                                        color: Colors.red),
                                                    iconSize: 30,
                                                    onPressed: () {
                                                      fimgURL = snapshot
                                                          .value['imgURL'];
                                                      fName = snapshot
                                                          .value['tName'];
                                                      fEName = snapshot
                                                          .value['eName'];
                                                      fDName = snapshot
                                                          .value['dName'];
                                                      fHName = snapshot
                                                          .value['hName'];

                                                      createData(
                                                          fimgURL,
                                                          fName,
                                                          fEName,
                                                          fDName,
                                                          fHName);
                                                      print(fimgURL);
                                                      print(fName);
                                                      print(fEName);
                                                      print(fDName);
                                                      print(fHName);
                                                    },
                                                  ),
                                                ),
                                                /*Align(
                                        alignment: Alignment.topRight,
                                        child: IconButton(
                                            icon: Icon(Icons.favorite,
                                                color: Colors.red),
                                            onPressed: null),
                                      ),*/
                                                //  Container(
                                                //      width: double.infinity,
                                                //      color:
                                                //          Color.fromARGB(100, 22, 44, 33),
                                                //  margin: EdgeInsets.all(20),
                                                //  padding: EdgeInsets.all(0),
                                                /*  child:*/ Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          bottom: 15,
                                                          top: 10),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomLeft,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        BorderedText(
                                                          strokeWidth: 3.5,
                                                          strokeColor: sColor,
                                                          child: Text(
                                                            '${snapshot.value['tName']}',
                                                            style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 30,
                                                              color: Color(
                                                                  0xFF2C3333),
                                                            ),
                                                          ),
                                                        ),
                                                        Row(
                                                          children: <Widget>[
                                                            /*  CircleAvatar(
                                                    radius: 10,
                                                    backgroundImage: AssetImage(
                                                        'asset/image/123321.jpg'),
                                                  ),*/
                                                            Flexible(
                                                              child: Container(
                                                                child: Padding(
                                                                  padding: new EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          13.0),
                                                                  child: Text(
                                                                    '${snapshot.value['eName']}',
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    style: TextStyle(
                                                                        color:
                                                                            sColor,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                                //)
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                    ],
                                  )
                                : Container();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
/*
// Search Page
class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: gColor,
          // The search area here
          title: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(5)),
            child: Center(
              child: TextField(
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        /* Clear the search field */
                      },
                    ),
                    hintText: 'Search...',
                    border: InputBorder.none),
              ),
            ),
          )),
    );
  }
}
*/
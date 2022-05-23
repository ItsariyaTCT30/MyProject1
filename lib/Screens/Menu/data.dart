import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';
import 'package:login_logout_app/Screens/Index.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';
import 'package:login_logout_app/Screens/Menu/disease.dart';
import 'package:login_logout_app/Screens/Menu/favorite.dart';
import 'package:login_logout_app/Screens/Menu/herb.dart';

import 'package:login_logout_app/Screens/Menu2.dart';
import 'package:login_logout_app/Screens/admin/backend/admin_data.dart';
import 'package:login_logout_app/Screens/components/Herb_Details_Screens.dart';
import 'package:login_logout_app/Screens/index_home.dart';
import 'package:login_logout_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class Data extends StatefulWidget {
  const Data({Key? key}) : super(key: key);

  @override
  _DataState createState() => _DataState();
}

class _DataState extends State<Data> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  String email = 'lemail';
  String password = 'lpassword';
  bool isloading = false;

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  List<MenuRecom> menuRecom = getMenuRecomList();
  //ประกาศตัวแปรอ้างอิงไปยัง Child ที่ต้องการ
  final dbfirebase = FirebaseDatabase.instance.reference().child('Data');
  //Function สำหรับแก้ไขข้อมูล
  Future<void> updateData(String key, int amonth, String op) async {
    try {
      if (op == "add") {
        dbfirebase.child(key).update({
          'amonth': amonth + 1,
        }).then((value) {
          print('Success');
        }).catchError((onError) {
          print(onError.code);
          print(onError.message);
        });
      } else if (op == "sub") {
        dbfirebase.child(key).update({
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

  Future<void> orderN() async {
    var db = FirebaseDatabase.instance.reference().child("Data");
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
            'imgURL': v["imgURL"],
            'amonth': v["amonth"],
          }).then((value) {
            print("Update Success");
            dbfirebase.child(k).update({
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
            IconButton(
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
            )
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
          Container(
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
                      'คลังข้อมูล',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Data',
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
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xffffffff).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  flex: 12,
                  child: FirebaseAnimatedList(
                    query: dbfirebase,
                    itemBuilder: (context, snapshot, animation, index) {
                      return Column(
                        children: [
                          InkWell(
                            onTap: () async {
                              await launch('${snapshot.value['eName']}');
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
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 15, top: 10),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              '${snapshot.value['tName']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  color: sColor),
                                            ),
                                            Row(
                                              children: <Widget>[
                                                /*      CircleAvatar(
                                              radius: 10,
                                              backgroundImage: AssetImage(
                                                  'asset/image/123321.jpg'),
                                            ),*/
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

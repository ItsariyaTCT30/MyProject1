import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';
import 'package:login_logout_app/Screens/Index.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';
import 'package:login_logout_app/Screens/Menu/disease.dart';
import 'package:login_logout_app/Screens/Menu/favorite.dart';
import 'package:login_logout_app/Screens/admin/backend/admin_data.dart';
import 'package:login_logout_app/Screens/index_home.dart';
import 'package:login_logout_app/constants.dart';

class Fever extends StatefulWidget {
  const Fever({Key? key}) : super(key: key);

  @override
  _FeverState createState() => _FeverState();
}

class _FeverState extends State<Fever> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  List<MenuRecom> menuRecom = getMenuRecomList();
  //ประกาศตัวแปรอ้างอิงไปยัง Child ที่ต้องการ
  final dbfirebase = FirebaseDatabase.instance.reference().child('Disease');
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
    var db = FirebaseDatabase.instance.reference().child("Disease");
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
            'type': v["type"],
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
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 12,
            child: FirebaseAnimatedList(
              query: dbfirebase,
              itemBuilder: (context, snapshot, animation, index) {
                return snapshot.value['type'] == 'แก้ไข้'
                    ? Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0 / 2,
                        ),
                        // color: Colors.blueAccent,
                        height: 160,
                        child: InkWell(
                          child: Stack(
                            alignment: Alignment.bottomCenter,
                            children: <Widget>[
                              // Those are our background
                              Container(
                                height: 136,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 15),
                                      blurRadius: 27,
                                      color: Colors
                                          .black12, // Black color with 12% opacity
                                    )
                                  ],
                                ),
                                child: Container(
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(22),
                                  ),
                                ),
                              ),
                              // our product image
                              Positioned(
                                top: 0,
                                right: 0,
                                child: Container(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 20.0),
                                  height: 160,
                                  // image is square but we add extra 20 + 20 padding thats why width is 200
                                  width: 200,
                                  child: Image.asset(
                                    "asset/image/patient1.png",
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              // Product title and price
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: SizedBox(
                                  height: 136,
                                  // our image take 200 width, thats why we set out total width - 200
                                  width: size.width - 200,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20.0),
                                        child: Text(
                                          '${snapshot.value['tName']}',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      // it use the available space
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container();
              },
            ),
          ),
        ],
      ),
    );
  }
}

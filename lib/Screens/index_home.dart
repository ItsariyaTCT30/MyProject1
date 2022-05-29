import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_logout_app/Screens/Index.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';
import 'package:login_logout_app/Screens/Menu/disease.dart';
import 'package:login_logout_app/Screens/Menu/favorite.dart';
import 'package:login_logout_app/Screens/Menu/herb.dart';
import 'package:login_logout_app/Screens/Menu2.dart';
import 'package:login_logout_app/Screens/admin/backend/admin_data.dart';
import 'package:login_logout_app/Screens/admin/backend/recommend.dart';
import 'package:login_logout_app/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class IndexHome extends StatelessWidget {
  final _auth = FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  var ct;
  //const Index({Key? key}) : super(key: key);
  List<Recom> recom = getRecomList();
  @override
  Widget build(BuildContext context) {
    ct = context;
    var size = MediaQuery.of(context).size;
    return Scaffold(
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
              leading: Icon(
                Icons.home_rounded,
                size: 32,
                color: gColor,
              ),
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
                color: gColor,
              ),
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
                {
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
      body: SingleChildScrollView(
        child: Container(
          color: gColor,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height * 0.01,
                    width: size.width,
                  ),
                  Image.asset(
                    "asset/image/2.1.1.png",
                    width: size.width * 0.40,
                    //height: size.height * 0.4,
                  ),
                  SizedBox(
                    height: size.height * 0.01,
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "ข่าวสาร",
                              //textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[200],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 400,
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: buildRecoms(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: size.height * 0.12,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildRecoms() {
    List<Widget> list = [];
    for (var i = 0; i < recom.length; i++) {
      list.add(buildRecom(recom[i], i, ct));
    }
    return list;
  }

  void signOut() {
    _googleSignIn.disconnect();
  }
}

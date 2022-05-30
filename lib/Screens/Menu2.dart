import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_logout_app/Screens/Disease_Screens/blood.dart';
import 'package:login_logout_app/Screens/Disease_Screens/contagious.dart';
import 'package:login_logout_app/Screens/Disease_Screens/fever.dart';
import 'package:login_logout_app/Screens/Disease_Screens/food.dart';
import 'package:login_logout_app/Screens/Disease_Screens/health.dart';
import 'package:login_logout_app/Screens/Disease_Screens/muscle.dart';
import 'package:login_logout_app/Screens/Disease_Screens/tooth.dart';
import 'package:login_logout_app/Screens/Disease_Screens/venom.dart';
import 'package:login_logout_app/Screens/Index.dart';
import 'package:login_logout_app/Screens/Menu/cookie.dart';
import 'package:login_logout_app/Screens/Menu/cookie_page.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';

import 'package:login_logout_app/Screens/Menu/disease.dart';
import 'package:login_logout_app/Screens/Menu/disease_card.dart';
import 'package:login_logout_app/Screens/Menu/favorite.dart';
import 'package:login_logout_app/Screens/Menu/herb.dart';
import 'package:login_logout_app/Screens/index_home.dart';

import '../constants.dart';

class Menu2 extends StatefulWidget {
  const Menu2({Key? key}) : super(key: key);

  @override
  State<Menu2> createState() => _Menu2State();
}

class _Menu2State extends State<Menu2> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 8,
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
          bottom: TabBar(
            isScrollable: true,
            physics: BouncingScrollPhysics(),
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorColor: sColor,
            tabs: [
              Tab(
                child: Text('ระบบไหลเวียนโลหิต'),
              ),
              Tab(
                child: Text('ระบบทางเดินอาหาร'),
              ),
              Tab(
                child: Text('แก้ไข้'),
              ),
              Tab(
                child: Text('โรคติดต่อ'),
              ),
              Tab(
                child: Text('อาการทางกล้ามเนื้อ'),
              ),
              Tab(
                child: Text('ฟัน'),
              ),
              Tab(
                child: Text('แก้พิษ'),
              ),
              Tab(
                child: Text('อาการทางผิวหนัง'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(child: Blood()),
            Center(child: Food()),
            Center(child: Fever()),
            Center(child: Contagious()),
            Center(child: Muscle()),
            Center(child: Tooth()),
            Center(child: Venom()),
            Center(child: Health()),
          ],
        ),
      ),
    );
  }
}

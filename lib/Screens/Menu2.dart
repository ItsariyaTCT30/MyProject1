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
                  backgroundImage: NetworkImage(
                      'https://images.unsplash.com/photo-1485290334039-a3c69043e517?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwxfDB8MXxyYW5kb218MHx8fHx8fHx8MTYyOTU3NDE0MQ&ixlib=rb-1.2.1&q=80&utm_campaign=api-credit&utm_medium=referral&utm_source=unsplash_source&w=300'),
                ),
                accountEmail: Text('jane.doe@example.com'),
                accountName: Text(
                  'Jane Doe',
                  style: TextStyle(fontSize: 24.0),
                ),
                decoration: BoxDecoration(
                  color: gColor,
                ),
              ),
              ListTile(
                leading: Icon(Icons.home_rounded, size: 32),
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
                leading: Icon(Icons.local_florist, size: 32),
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
                leading: Icon(Icons.sick, size: 32),
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
                leading: Icon(Icons.insert_drive_file_rounded, size: 32),
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
                leading: Icon(Icons.favorite, size: 32),
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
                leading: Icon(Icons.logout, size: 32),
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
                /* icon: ImageIcon(
                  AssetImage("asset/image/blood-bag.png"),
                  color: sColor,
                ),*/
              ),
              Tab(
                child: Text('ระบบทางเดินอาหาร'),
                /*  icon: ImageIcon(
                  AssetImage("asset/image/herbal-spa-treatment-leaves.png"),
                  color: sColor,
                ),*/
              ),
              Tab(
                child: Text('แก้ไข้'),
                /* icon: ImageIcon(
                  AssetImage("asset/image/herbal-spa-treatment-leaves.png"),
                  color: sColor,
                ),*/
              ),
              Tab(
                child: Text('โรคติดต่อ'),
                /*  icon: ImageIcon(
                  AssetImage("asset/image/herbal-spa-treatment-leaves.png"),
                  color: sColor,
                ),*/
              ),
              Tab(
                child: Text('อาการทางกล้ามเนื้อ'),
                /*   icon: ImageIcon(
                  AssetImage("asset/image/herbal-spa-treatment-leaves.png"),
                  color: sColor,
                ),*/
              ),
              Tab(
                child: Text('ฟัน'),
                /*   icon: ImageIcon(
                  AssetImage("asset/image/herbal-spa-treatment-leaves.png"),
                  color: sColor,
                ),*/
              ),
              Tab(
                child: Text('แก้พิษ'),
                /*  icon: ImageIcon(
                  AssetImage("asset/image/herbal-spa-treatment-leaves.png"),
                  color: sColor,
                ),*/
              ),
              Tab(
                child: Text('อาการทางผิวหนัง'),
                /*   icon: ImageIcon(
                  AssetImage("asset/image/herbal-spa-treatment-leaves.png"),
                  color: sColor,
                ),*/
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
            //----------------------------------------------
            /*    Container(
              height: MediaQuery.of(context).size.height / 1,
              child: ListView(
                children: <Widget>[
                  ProductCard(),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

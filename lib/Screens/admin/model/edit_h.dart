import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_logout_app/Screens/Index.dart';
import 'package:login_logout_app/Screens/admin/add_herb.dart';
import 'package:login_logout_app/Screens/admin/admin_home.dart';
import 'package:login_logout_app/Screens/admin/backend/admin_data.dart';
//import 'package:login_logout_app/Screens/admin/backend/menulist.dart';
import 'package:login_logout_app/Screens/admin/edit.dart';
import 'package:login_logout_app/Screens/admin/edit2.dart';
import 'package:login_logout_app/Screens/admin/edit3.dart';
import 'package:login_logout_app/Screens/admin/model/add_h.dart';
//import 'package:login_logout_app/Screens/admin/model/admin_data.dart';
import 'package:login_logout_app/constants.dart';

class EditH extends StatefulWidget {
  const EditH({Key? key}) : super(key: key);

  @override
  _EditHState createState() => _EditHState();
}

class _EditHState extends State<EditH> {
  List<MenuR> menu = getMenuList();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _signOut() async {
    await _firebaseAuth.signOut();
  }

  var ct;
  @override
  Widget build(BuildContext context) {
    ct = context;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: gColor,
              ),
              child: Text(
                'เมนู',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: sColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              leading: ImageIcon(
                AssetImage("asset/image/home.png"),
                size: 32,
              ),
              title: const Text(
                'หน้าหลัก',
                style: TextStyle(
                  color: gColor,
                  fontSize: 28,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => MainMenu(),
                  ),
                );
              },
            ),
            ListTile(
              leading: ImageIcon(
                AssetImage("asset/image/add (1).png"),
                size: 32,
              ),
              title: const Text(
                'หน้าเพิ่มข้อมูล',
                style: TextStyle(
                  color: gColor,
                  fontSize: 28,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => AddH(),
                  ),
                );
              },
            ),
            ListTile(
              leading: ImageIcon(
                AssetImage("asset/image/edit (1).png"),
                size: 32,
              ),
              title: const Text(
                'หน้าแก้ไขข้อมูล',
                style: TextStyle(
                  color: gColor,
                  fontSize: 28,
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => EditH(),
                  ),
                );
              },
            ),
            ListTile(
              leading: ImageIcon(
                AssetImage("asset/image/logout.png"),
                size: 32,
              ),
              title: const Text(
                'ออกจากระบบ',
                style: TextStyle(
                  color: gColor,
                  fontSize: 28,
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
            fontSize: 32,
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
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/image/bg1.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "แก้ไขข้อมูล",
                    //textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[200],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => Food(),
                        ),
                      );
                    },
                    child: Container(
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
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                height: 160,
                                // image is square but we add extra 20 + 20 padding thats why width is 200
                                width: 200,
                                child: Image.asset(
                                  "asset/image/mortar2.png",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        "แก้ไขสมุนไพร",
                                        style:
                                            Theme.of(context).textTheme.button,
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
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => SDisease(),
                        ),
                      );
                    },
                    child: Container(
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
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                height: 160,
                                // image is square but we add extra 20 + 20 padding thats why width is 200
                                width: 200,
                                child: Image.asset(
                                  "asset/image/fever2.png",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        "แก้ไขข้อบ่งใช้",
                                        style:
                                            Theme.of(context).textTheme.button,
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
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => SData(),
                        ),
                      );
                    },
                    child: Container(
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
                                padding: EdgeInsets.symmetric(horizontal: 20.0),
                                height: 160,
                                // image is square but we add extra 20 + 20 padding thats why width is 200
                                width: 200,
                                child: Image.asset(
                                  "asset/image/file-storage 2.png",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0),
                                      child: Text(
                                        "แก้ไขคลังข้อมูล",
                                        style:
                                            Theme.of(context).textTheme.button,
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
                    ),
                  ),
                  SizedBox(
                    height: 110,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

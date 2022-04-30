import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:login_logout_app/Screens/Index.dart';
import 'package:login_logout_app/Screens/admin/backend/admin_data.dart';
import 'package:login_logout_app/Screens/admin/model/add_h.dart';
import 'package:login_logout_app/Screens/admin/model/edit_h.dart';
import 'package:login_logout_app/constants.dart';

class MainMenu extends StatefulWidget {
  const MainMenu({Key? key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
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
              leading: Icon(
                Icons.home,
                size: 32,
                color: Colors.green[600],
              ),
              title: const Text(
                'หน้าหลัก',
                style: TextStyle(
                  color: aColor,
                  fontSize: 28,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.add_box,
                size: 32,
                color: Colors.yellow[800],
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
              leading: Icon(
                Icons.edit,
                size: 32,
                color: Colors.orange[900],
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
              leading: Icon(
                Icons.logout,
                size: 32,
                color: Colors.red[800],
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
          "Admin",
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
      body: Container(
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
                Image.asset(
                  "asset/image/MedicinalHerbs.png",
                  width: size.width * 0.9,
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  "asset/image/2.1.png",
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

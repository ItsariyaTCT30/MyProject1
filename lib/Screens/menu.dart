import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/components/Herb_Method_Screens.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';
import 'package:login_logout_app/Screens/Home_Screen.dart';
import 'package:login_logout_app/Screens/by.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';
import 'package:login_logout_app/Screens/Menu/disease.dart';
import 'package:login_logout_app/Screens/Menu/herb.dart';

import '../constants.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/image/bg4.png"),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 90,
                ),
                Image.asset(
                  "asset/image/MedicinalHerbs.png",
                  width: size.width * 0.9,
                ),
                SizedBox(
                  height: 50,
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: .85,
                    crossAxisSpacing: 1,
                    mainAxisSpacing: 1,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: 200,
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contex) => Herb(),
                                ),
                              );
                            },
                            title: Column(
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Image.asset(
                                  "asset/image/Asset2.png",
                                  width: 105,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("สมุนไพร"),
                              ],
                            ),
                          ),
                          elevation: 8,
                          shadowColor: pColor,
                          margin: EdgeInsets.all(15),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: pColor, width: 3)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: 200,
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contex) => Disease(),
                                ),
                              );
                            },
                            title: Column(
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Image.asset(
                                  "asset/image/Asset3.1.png",
                                  width: 105,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("ข้อบ่อใช้"),
                              ],
                            ),
                          ),
                          elevation: 8,
                          shadowColor: pColor,
                          margin: EdgeInsets.all(15),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: pColor, width: 3)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: 200,
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contex) => Data(),
                                ),
                              );
                            },
                            title: Column(
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Image.asset(
                                  "asset/image/Asset1.png",
                                  width: 105,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("คลังข้อมูล"),
                              ],
                            ),
                          ),
                          elevation: 8,
                          shadowColor: pColor,
                          margin: EdgeInsets.all(15),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: pColor, width: 3)),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200,
                        width: 200,
                        child: Card(
                          child: ListTile(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contex) => HomeScreen(),
                                ),
                              );
                            },
                            title: Column(
                              children: [
                                SizedBox(
                                  height: 25,
                                ),
                                Image.asset(
                                  "asset/image/admin.png",
                                  width: 105,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("ติดต่อ"),
                              ],
                            ),
                          ),
                          elevation: 8,
                          shadowColor: pColor,
                          margin: EdgeInsets.all(15),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: pColor, width: 3)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            /*
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: pColor,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    shape: StadiumBorder(),
                  ),
                  child: Image.asset(
                    "asset/image/bg401.png",
                    width: size.width * 0.9,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (contex) => Herb(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: pColor,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    shape: StadiumBorder(),
                  ),
                  child: Image.asset(
                    "asset/image/bg402.png",
                    width: size.width * 0.9,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (contex) => Disease(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: pColor,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    shape: StadiumBorder(),
                  ),
                  child: Image.asset(
                    "asset/image/bg403.png",
                    width: size.width * 0.9,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (contex) => Data(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: pColor,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    shape: StadiumBorder(),
                  ),
                  child: Image.asset(
                    "asset/image/bg404.png",
                    width: size.width * 0.9,
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (contex) => HomeScreen(),
                      ),
                    );
                  },
                ),
                */
          ],
        ),
      ),
    );
  }
}

//import 'dart:html';

import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/Disease_Screens/blood.dart';
import 'package:login_logout_app/Screens/Disease_Screens/contagious.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';
import 'package:login_logout_app/Screens/Menu/disease_card.dart';
import 'package:login_logout_app/Screens/Disease_Screens/fever.dart';
import 'package:login_logout_app/Screens/Disease_Screens/food.dart';
import 'package:login_logout_app/Screens/Disease_Screens/health.dart';
import 'package:login_logout_app/Screens/Menu/herb.dart';
import 'package:login_logout_app/Screens/Disease_Screens/muscle.dart';
import 'package:login_logout_app/Screens/Disease_Screens/tooth.dart';
import 'package:login_logout_app/Screens/Disease_Screens/venom.dart';
import 'package:provider/single_child_widget.dart';

import '../../constants.dart';

class Disease extends StatefulWidget {
  const Disease({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Disease>
    with SingleTickerProviderStateMixin {
  var data;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 8, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: gColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 15,
            ),
            Column(
              children: <Widget>[
                Text(
                  'ข้อบ่งใช้',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Indications',
                  style: TextStyle(
                      fontSize: 35,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            /*   Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 20.0 / 4, // 5 top and bottom
              ),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                // onChanged: onChanged,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
            ),*/
            //  CategoryList(),
            SizedBox(height: 20.0 / 2),

            TabBar(
                controller: _tabController,
                indicatorColor: Colors.transparent,
                labelColor: Color(0xFFC88D67),
                isScrollable: true,
                labelPadding: EdgeInsets.only(right: 45.0),
                unselectedLabelColor: Color(0xFFCDCDCD),
                /*      indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // Creates border
                    color: Colors.greenAccent),*/
                tabs: [
                  Tab(
                    child: Text('ระบบไหลเวียนโลหิต',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('ระบบทางเดินอาหาร',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('แก้ไข้',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('โรคติดต่อ',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('อาการทางกล้ามเนื้อ',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('ฟัน',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('แก้พิษ',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                  Tab(
                    child: Text('อาการทางผิวหนัง',
                        style: TextStyle(
                          fontFamily: 'Varela',
                          fontSize: 21.0,
                        )),
                  ),
                ]),
            SingleChildScrollView(
              child: Container(
                  height: MediaQuery.of(context).size.height - 329.0,
                  width: double.infinity,
                  child: TabBarView(controller: _tabController, children: [
                    ListView(
                      children: <Widget>[
                        Blood(),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        Food(),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        Fever(),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        Contagious(),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        Muscle(),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        Tooth(),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        Venom(),
                      ],
                    ),
                    ListView(
                      children: <Widget>[
                        Health(),
                      ],
                    ),
                    //  Blood(),
                    //Food(),
                    //Fever(),
                    //Contagious(),
                    //Muscle(),
                    //Tooth(),
                    //Venom(),
                    //Health(),
                  ])),
            ),
/*
            SizedBox(height: 20.0 / 2),
            Expanded(
              child: Stack(
                children: <Widget>[
                  // Our background
                  Container(
                    margin: EdgeInsets.only(top: 70),
                    decoration: BoxDecoration(
                      color: sColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                  ),

                        Container(
                    height: MediaQuery.of(context).size.height / 1,
                    child: ListView(
                      children: <Widget>[
                        ProductCard(),
                      ],
                    ),
                  ),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}

AppBar buildAppBar() {
  return AppBar(
    elevation: 0,
    centerTitle: false,
    title: Text('Dashboard'),
    actions: <Widget>[
      IconButton(
        icon: Image.asset("asset/image/circulatory.png"),
        onPressed: () {},
      ),
    ],
  );
}

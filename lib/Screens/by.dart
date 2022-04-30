import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';
import 'package:login_logout_app/Screens/Menu/disease.dart';
import 'package:login_logout_app/Screens/Menu/herb.dart';

import '../constants.dart';

class By extends StatefulWidget {
  const By({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<By> {
  var data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: sColor,
              ),
              child: Text(
                'Menu ',
                style: TextStyle(
                  fontSize: 28,
                  color: Colors.blue,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => Herb(),
                  ),
                );
              },
              title: Text(
                'สมุนไพร',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              leading: Icon(
                Icons.eco,
                color: Colors.green,
                size: 36,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => Disease(),
                  ),
                );
              },
              title: Text(
                'ข้อบ่อใช้',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              leading: Icon(
                Icons.airline_seat_flat_rounded,
                color: Colors.red,
                size: 36,
              ),
            ),
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => Data(),
                  ),
                );
              },
              title: Text(
                'คลังข้อมูล',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              leading: Icon(
                Icons.feed_sharp,
                color: Colors.amber,
                size: 36,
              ),
            ),
          ],
        ),
      ),
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/image/bg8.1.png"),
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
                    height: 1,
                  ),
                  Text(
                    'จัดทำโดย',
                    style: TextStyle(fontSize: 80, color: sColor),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "asset/image/pup.png",
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'นายอิสริยะ  ณรงค์',
                    style: TextStyle(fontSize: 30, color: tColor),
                  ),
                  Text(
                    '6302041510133',
                    style: TextStyle(fontSize: 20, color: tColor),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Text(
                        'ภาควิชาครุศาสตร์คอมพิวเตอร์ \n คณะครุศาสตร์อุตสาหกรรม \nมหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ',
                        style: TextStyle(fontSize: 18, color: tColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(50, 50, 50, 50),
                    height: 0.5,
                    color: tColor,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "asset/image/nam.png",
                    width: 200,
                    height: 200,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    'นางสาวภัครดา นนทสุขิตกุล',
                    style: TextStyle(fontSize: 30, color: tColor),
                  ),
                  Text(
                    '6302041510079',
                    style: TextStyle(fontSize: 20, color: tColor),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Container(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Text(
                        'ภาควิชาครุศาสตร์คอมพิวเตอร์ \n คณะครุศาสตร์อุตสาหกรรม \nมหาวิทยาลัยเทคโนโลยีพระจอมเกล้าพระนครเหนือ',
                        style: TextStyle(fontSize: 18, color: tColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      iconTheme: IconThemeData(
        color: yColor, //change your color here
      ),
      automaticallyImplyLeading: true,
      backgroundColor: pColor,
      elevation: 0,
      actions: [],
    );
  }
}

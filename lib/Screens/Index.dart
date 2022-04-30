import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/Home_Screen.dart';
import 'package:login_logout_app/Screens/Iogin_Screens/Login_Screen.dart';

import '../constants.dart';

class Index extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/image/bg1.png"),
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
                    height: size.height * 0.1,
                  ),
                  Image.asset(
                    "asset/image/MedicinalHerbs.png",
                    width: size.width * 0.8,
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  Image.asset(
                    "asset/image/2.1.png",
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: gColor,
                      padding: EdgeInsets.fromLTRB(60, 15, 60, 15),
                      shape: StadiumBorder(),
                    ),
                    child: Text(
                      "START",
                      style: TextStyle(fontSize: 30),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.07,
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

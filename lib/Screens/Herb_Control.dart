import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/components/Herb_Details_Screens.dart';
import 'package:login_logout_app/Screens/components/Herb_Method_Screens.dart';

import '../constants.dart';

class Control extends StatefulWidget {
  const Control({Key? key}) : super(key: key);

  @override
  State<Control> createState() => _ControlState();
}

class _ControlState extends State<Control> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: gColor,
          bottom: TabBar(
            indicatorColor: sColor,
            tabs: [
              Tab(
                icon: ImageIcon(
                  AssetImage("asset/image/list.png"),
                  color: sColor,
                ),
              ),
              Tab(
                icon: ImageIcon(
                  AssetImage("asset/image/herbs (1).png"),
                  color: sColor,
                ),
              ),
            ],
          ),
          title: Text('สมุนไพร'),
        ),
        body: TabBarView(
          children: [
            //  Center(child: DetailsScreens()),
            //  Center(child: MethodScreens()),
          ],
        ),
      ),
    );
  }
}

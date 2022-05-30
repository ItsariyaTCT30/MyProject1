import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/components/Herb_Method_Screens.dart';

import '../../constants.dart';

class DetailsScreens extends StatefulWidget {
  final String imgURL, name, ename, dname;
  const DetailsScreens({
    Key? key,
    required this.imgURL,
    required this.name,
    required this.ename,
    required this.dname,
  }) : super(key: key);

  @override
  _DetailsScreensState createState() => _DetailsScreensState();
}

class _DetailsScreensState extends State<DetailsScreens> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.imgURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gColor,
        title: Text(
          "รายละเอียด",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(
                height: 240.0,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        widget.imgURL,
                        height: 240.0,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                widget.name, // "กัญชา",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.ename,
                style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "รายละเอียด",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.dname,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.0),

              SizedBox(height: 10.0),
              //buildProductList(),
              SizedBox(height: 10.0),
            ],
          ),
          // buildFloatingButton(),
        ],
      ),
    );
  }

  buildImage() {
    return Container(
      height: 240.0,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              widget.imgURL,
              height: 240.0,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/admin/backend/admin_data.dart';
import 'package:login_logout_app/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

Widget buildRecom(Recom recome, int index, dynamic context) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.all(
        Radius.circular(30),
      ),
    ),
    padding: EdgeInsets.all(15),
    margin: EdgeInsets.only(right: 16, left: index == 0 ? 16 : 0),
    width: 300,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        GestureDetector(
          onTap: () => _onBasicAlertPressed(context, recome.image),
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(recome.image),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
            ),
            height: 340,
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    ),
  );
}

_onBasicAlertPressed(context, dynamic img) {
  Alert(
    style: AlertStyle(
      backgroundColor: sColor,
      titleStyle: TextStyle(fontSize: 32),
    ),
    image: Image.asset(img),
    context: context,
    buttons: [
      DialogButton(
        child: Text(
          "OK",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        color: gColor,
        onPressed: () => Navigator.pop(context),
        width: 120,
      ),
    ],
    //desc: "Flutter is more awesome with RFlutter Alert.",
  ).show();
}

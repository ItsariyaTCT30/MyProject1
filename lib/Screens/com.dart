
import 'dart:io';

import 'package:comment_box/comment/comment.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';
import 'package:login_logout_app/Screens/Index.dart';
import 'package:login_logout_app/Screens/Menu/data.dart';
import 'package:login_logout_app/Screens/Menu/disease.dart';
import 'package:login_logout_app/Screens/Menu/favorite.dart';
import 'package:login_logout_app/Screens/Menu2.dart';
import 'package:login_logout_app/Screens/admin/backend/admin_data.dart';
import 'package:login_logout_app/Screens/components/Herb_Details_Screens.dart';
import 'package:login_logout_app/Screens/index_home.dart';
import 'package:login_logout_app/constants.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:path/path.dart' as path;

class Com extends StatefulWidget {
  const Com({Key? key}) : super(key: key);

  @override
  _ComState createState() => _ComState();
}

class _ComState extends State<Com> {
  final sdbfirebase = FirebaseDatabase.instance.reference().child('comment');

//------------------------------------------------------------------------------------------------
  Future<void> orderN() async {
    var db = FirebaseDatabase.instance.reference().child("comment");
    db.once().then((DataSnapshot snapshot) async {
      Map<dynamic, dynamic> values = snapshot.value;
      //print(values.toString());
      values.forEach((k, v) async {
        print(k);
        //print(v["amonth"]);
        if (v["amonth"] > 0) {
          await FirebaseDatabase.instance
              .reference()
              .child('Order')
              // .child(widget.tableName)
              .push()
              .set({
            //  'tableN': widget.tableName,
            'sName': v["sName"],
            'oName': v["oName"],
            'iName': v["iName"],
            'mName': v["mName"],
          }).then((value) {
            print("Update Success");
            sdbfirebase.child(k).update({
              'amonth': 0,
            }).then((value) {
              print('Success');
            }).catchError((onError) {
              print(onError.code);
              print(onError.message);
            });
          }).catchError((onError) {
            print(onError.code);
            print(onError.message);
          });
          //
        }
      });
      //  await _order(widget.tableName);
    });
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Flexible(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: gColor,
          title: Text(
            "Comments",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
        ),
        body: Stack(
          children: <Widget>[
            SizedBox(
              height: 25,
            ),
            Expanded(
              child: FirebaseAnimatedList(
                query: sdbfirebase,
                itemBuilder: (context, snapshot, animation, index) {
                  return
                      //--------------------------------------------------
                      ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage:
                          NetworkImage('${snapshot.value['iName']}'),
                      //backgroundColor: pColor,
                    ),
                    title: Text(
                      '${snapshot.value['mName']}',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Row(
                      children: <Widget>[
                        Row(children: <Widget>[
                          Icon(
                            Icons.star_rate_rounded,
                            color: wColor,
                            size: 20,
                          ),
                          Text(
                            '${snapshot.value['sName']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Text(" / "),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            '${snapshot.value['oName']}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ])
                      ],
                    ),
                  );
                  //---------------------------------

                  //---------------------------------
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

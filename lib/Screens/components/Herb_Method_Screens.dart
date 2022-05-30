import 'dart:io';

import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:login_logout_app/Screens/admin/model/test.dart';
import 'package:login_logout_app/Screens/com.dart';
import 'package:login_logout_app/Screens/menu.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class MethodScreens extends StatefulWidget {
  final String imgURL, name, ename, Cname;
  const MethodScreens({
    Key? key,
    required this.imgURL,
    required this.name,
    required this.ename,
    required this.Cname,
  }) : super(key: key);

  @override
  _MethodScreensState createState() => _MethodScreensState();
}

class _MethodScreensState extends State<MethodScreens> {
  double rating = 0;

  String? SName, OName, IName, MName;
  final formKey = GlobalKey<FormState>();
  var file;
  final picker = ImagePicker();
  String? fileSName;
  String? fileOName;
  String? fileIName;
  String? fileMName;

  ListResult? result;
  List<Reference>? allFiles;
  String? fileUrl;
  FullMetadata? fileMeta;

  //ประกาศตัวแปรอ้างอิงไปยัง Child ที่ต้องการ

  final sdbfirebase = FirebaseDatabase.instance.reference().child('comment');

  Future<void> createData(SName, OName, IName, MName) async {
    // if (file != null) {
    try {
      await sdbfirebase.push().set({
        'sName': SName,
        'oName': OName,
        'iName': IName,
        'mName': MName,
      }).then((value) {
        formKey.currentState!.reset();
        file = null;
        print("Success");
      }).catchError((onError) {
        print(onError.code);
        print(onError.message);
      });
      final snackBar = SnackBar(content: Text('เพิ่มสำเร็จ'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print(fileSName);
      print(fileOName);
      print(fileIName);
      setState(() {});
    } on FirebaseException catch (error) {
      print(error);
    }
    // }
  }

  //Function สำหรับแก้ไขข้อมูล
  Future<void> updateData(String key, int amonth, String op) async {
    try {
      if (op == "add") {
        sdbfirebase.child(key).update({
          'amonth': amonth + 1,
        }).then((value) {
          print('Success');
        }).catchError((onError) {
          print(onError.code);
          print(onError.message);
        });
      } else if (op == "sub") {
        sdbfirebase.child(key).update({
          'amonth': amonth - 1,
        }).then((value) {
          print('Success');
        }).catchError((onError) {
          print(onError.code);
          print(onError.message);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  final hdbfirebase = FirebaseDatabase.instance.reference().child('Food');

  Future<void> orderN() async {
    var db = FirebaseDatabase.instance.reference().child("Food");
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
            'tName': v["tName"],
            'eName': v["eName"],
            'dName': v["dName"],
            'imgURL': v["imgURL"],
            'amonth': v["amonth"],
          }).then((value) {
            print("Update Success");
            hdbfirebase.child(k).update({
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

  //-------------------------------------------------------------------------------
  // show the rating dialog
  void _showRatingDialog() {
    // actual store listing review & rating
    void _rateAndReviewApp() async {
      // refer to: https://pub.dev/packages/in_app_review
      final _inAppReview = InAppReview.instance;

      if (await _inAppReview.isAvailable()) {
        print('request actual review from store');
        _inAppReview.requestReview();
      } else {
        print('open actual store listing');
        // TODO: use your own store ids
        _inAppReview.openStoreListing(
          appStoreId: '<your app store id>',
          microsoftStoreId: '<your microsoft store id>',
        );
      }
    }

    final _dialog = RatingDialog(
      initialRating: 1.0,
      // your app's name?
      title: Text(
        'Medicinal Herbs',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
      // encourage your user to leave a high rating?
      message: Text(
        'ให้คะแนนสมุนไพร',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 18),
      ),
      // your app's logo?
      image: Image.asset(
        "asset/image/2.1.png",
        height: 250,
      ),
      //image: const FlutterLogo(size: 100),
      submitButtonText: 'ส่ง',
      commentHint: 'ข้อเสนอแนะ',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');
        SName = '${response.rating}';
        OName = '${response.comment}';

        createData(
          SName,
          OName,
          (IName = widget.imgURL),
          (MName = widget.name),
        );

        // TODO: add your own logic
        if (response.rating < 3.0) {
          // send their comments to your email or anywhere you wish
          // ask the user to contact you instead of leaving a bad review
        } else {
          _rateAndReviewApp();
        }
      },
    );

    // show the dialog
    showDialog(
      context: context,
      barrierDismissible: true, // set to false if you want to force a rating
      builder: (context) => _dialog,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: gColor,
          title: Text(
            "วิธีปรุงยาสมุนไพร",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                icon: Icon(Icons.star_rounded),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (contex) => Com(),
                    ),
                  );
                })
          ]),
      body: Stack(
        children: <Widget>[
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            children: <Widget>[
              SizedBox(height: 10.0),
              buildImage(),
              SizedBox(height: 20.0),

              Text(
                widget.name, //"กัญชา",
                style: TextStyle(
                  fontSize: 32.0,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.ename, //"\Cannabis indica",
                style: TextStyle(
                  fontSize: 27.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 30.0),
              Text(
                "วิธีการปรุง",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10.0),
              Text(
                widget.Cname,
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
              Row(
                mainAxisAlignment: MainAxisAlignment
                    .spaceEvenly, // use whichever suits your need
                children: <Widget>[
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: gColor,
                      fixedSize: const Size(150, 43),
                      shape: StadiumBorder(),
                    ),
                    icon: Icon(
                      Icons.comment,
                      color: sColor,
                      size: 20,
                    ),
                    label: Text(
                      'Comment',
                      style: TextStyle(fontSize: 18, color: sColor),
                    ),
                    onPressed: _showRatingDialog,
                  ),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: gColor,
                      fixedSize: const Size(150, 43),
                      shape: StadiumBorder(),
                    ),
                    icon: Icon(
                      Icons.fastfood,
                      size: 20,
                    ),
                    label: Text(
                      'เมนูสมุนไพร',
                      style: TextStyle(fontSize: 18, color: sColor),
                    ),
                    onPressed: () async {
                      await launch(
                          'https://www.youtube.com/results?search_query=' +
                              'เมนู' +
                              (widget.name)); //widget.ename,
                    },
                  ),
                ],
              ),
              SizedBox(height: 10.0),
            ],
          ),
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
            child: Image.network(
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

class DemoPage extends StatelessWidget {
  const DemoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Button usage demo'),
      ),
      body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FavoriteButton(
                isFavorite: true,
                // iconDisabledColor: Colors.white,
                valueChanged: (_isFavorite) {
                  print('Is Favorite : $_isFavorite');
                },
              ),
              StarButton(
                isStarred: false,
                // iconDisabledColor: Colors.white,
                valueChanged: (_isStarred) {
                  print('Is Starred : $_isStarred');
                },
              )
            ],
          )),
    );
  }
}

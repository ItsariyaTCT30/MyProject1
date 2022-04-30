import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:login_logout_app/Screens/com.dart';
import 'package:login_logout_app/Screens/menu.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants.dart';

class MethodScreens extends StatefulWidget {
  final String imgURL, name, ename, hname;
  const MethodScreens(
      {Key? key,
      required this.imgURL,
      required this.name,
      required this.ename,
      required this.hname})
      : super(key: key);

  @override
  _MethodScreensState createState() => _MethodScreensState();
}

class _MethodScreensState extends State<MethodScreens> {
  double rating = 0;

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
        'Tap a star to set your rating. Add more description here if you want.',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 15),
      ),
      // your app's logo?
      image: const FlutterLogo(size: 100),
      submitButtonText: 'Submit',
      commentHint: 'Set your custom comment hint',
      onCancelled: () => print('cancelled'),
      onSubmitted: (response) {
        print('rating: ${response.rating}, comment: ${response.comment}');

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
      ),
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
                widget
                    .hname, //"รูปแบบยา ยาต้ม, ยาแคปซูล\nขนาดและวิธีใช้ \nยาต้ม\nต้มเดือด น้ำหนักยา สิ่งละ ๑-๕ บาท (๑๕-๗๕ กรัม) ตามอาการคนไข้ รับประทาน\nครั้งละ ๑ ถ้วยชา (๑๓๕ มิลลิลิตร) วันละ ๒-๓ ครั้ง ก่อนอาหาร\nชนิดแคปซูล\nรับประทานครั้งละ ๐.๕ กรัม วันละ ๓ ครั้ง ก่อนอาหาร",
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 20.0),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: gColor,
                  fixedSize: const Size(50, 50),
                  shape: StadiumBorder(),
                ),
                icon: Icon(
                  Icons.comment,
                  color: sColor,
                  size: 20,
                ),
                label: Text(
                  '',
                  style: TextStyle(fontSize: 18, color: sColor),
                ),
                onPressed: _showRatingDialog,
              ),
              SizedBox(height: 10.0),
              //buildProductList(),
              Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text(
                      'Rating: $rating',
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    RatingBar.builder(
                      minRating: 1,
                      itemSize: 46,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4),
                      itemBuilder: (context, _) =>
                          Icon(Icons.star, color: Colors.amber),
                      updateOnDrag: true,
                      onRatingUpdate: (rating) => setState(() {
                        this.rating = rating;
                      }),
                    ),
                  ])),

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
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (contex) => Com(),
                        ),
                      );
                    },
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

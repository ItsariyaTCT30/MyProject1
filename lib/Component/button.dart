import 'package:flutter/material.dart';
import '../constants.dart';

class LoginSignupButton extends StatelessWidget {
  final String title;
  final dynamic ontapp;

  LoginSignupButton({required this.title, required this.ontapp});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: SizedBox(
        height: 45,
        child: ElevatedButton(
          onPressed: ontapp,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: TextStyle(fontSize: 25, color: sColor),
            ),
          ),
          style: ElevatedButton.styleFrom(
              primary: gColor,
              fixedSize: const Size(300, 40),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50))),
          /*
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black45),
          */
        ),
      ),
    );
  }
}

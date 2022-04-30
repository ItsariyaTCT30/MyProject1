import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';

class Tooth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // It  will provide us total height and width of our screen
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (contex) => Control(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0 / 2,
            ),
            // color: Colors.blueAccent,
            height: 160,
            child: InkWell(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  // Those are our background
                  Container(
                    height: 136,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 27,
                          color: Colors.black12, // Black color with 12% opacity
                        )
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  // our product image
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 160,
                      // image is square but we add extra 20 + 20 padding thats why width is 200
                      width: 200,
                      child: Image.asset(
                        "asset/image/dental-care.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Product title and price
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: SizedBox(
                      height: 136,
                      // our image take 200 width, thats why we set out total width - 200
                      width: size.width - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "ฟัน",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          // it use the available space
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (contex) => Control(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0 / 2,
            ),
            // color: Colors.blueAccent,
            height: 160,
            child: InkWell(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  // Those are our background
                  Container(
                    height: 136,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 27,
                          color: Colors.black12, // Black color with 12% opacity
                        )
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  // our product image
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 160,
                      // image is square but we add extra 20 + 20 padding thats why width is 200
                      width: 200,
                      child: Image.asset(
                        "asset/image/dental-care.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Product title and price
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: SizedBox(
                      height: 136,
                      // our image take 200 width, thats why we set out total width - 200
                      width: size.width - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "ฟัน",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          // it use the available space
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (contex) => Control(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0 / 2,
            ),
            // color: Colors.blueAccent,
            height: 160,
            child: InkWell(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  // Those are our background
                  Container(
                    height: 136,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 27,
                          color: Colors.black12, // Black color with 12% opacity
                        )
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  // our product image
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 160,
                      // image is square but we add extra 20 + 20 padding thats why width is 200
                      width: 200,
                      child: Image.asset(
                        "asset/image/dental-care.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Product title and price
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: SizedBox(
                      height: 136,
                      // our image take 200 width, thats why we set out total width - 200
                      width: size.width - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "ฟัน",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          // it use the available space
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (contex) => Control(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0 / 2,
            ),
            // color: Colors.blueAccent,
            height: 160,
            child: InkWell(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  // Those are our background
                  Container(
                    height: 136,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 27,
                          color: Colors.black12, // Black color with 12% opacity
                        )
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  // our product image
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 160,
                      // image is square but we add extra 20 + 20 padding thats why width is 200
                      width: 200,
                      child: Image.asset(
                        "asset/image/dental-care.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Product title and price
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: SizedBox(
                      height: 136,
                      // our image take 200 width, thats why we set out total width - 200
                      width: size.width - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "ฟัน",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          // it use the available space
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        FlatButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (contex) => Control(),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0 / 2,
            ),
            // color: Colors.blueAccent,
            height: 160,
            child: InkWell(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: <Widget>[
                  // Those are our background
                  Container(
                    height: 136,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 15),
                          blurRadius: 27,
                          color: Colors.black12, // Black color with 12% opacity
                        )
                      ],
                    ),
                    child: Container(
                      margin: EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(22),
                      ),
                    ),
                  ),
                  // our product image
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: 160,
                      // image is square but we add extra 20 + 20 padding thats why width is 200
                      width: 200,
                      child: Image.asset(
                        "asset/image/dental-care.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Product title and price
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: SizedBox(
                      height: 136,
                      // our image take 200 width, thats why we set out total width - 200
                      width: size.width - 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(
                              "ฟัน",
                              style: Theme.of(context).textTheme.button,
                            ),
                          ),
                          // it use the available space
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

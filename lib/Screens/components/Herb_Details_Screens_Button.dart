import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/components/Herb_Method_Screens.dart';

import '../../constants.dart';

class DetailsScreensButton extends StatefulWidget {
  final String imgURL, name, ename, dname, Cname;
  const DetailsScreensButton({
    Key? key,
    required this.imgURL,
    required this.name,
    required this.ename,
    required this.dname,
    required this.Cname,
  }) : super(key: key);

  @override
  _DetailsScreensButtonState createState() => _DetailsScreensButtonState();
}

class _DetailsScreensButtonState extends State<DetailsScreensButton> {
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
                widget.ename, //"Cannabis sativa subsp. indica (Lam.)",
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
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  primary: gColor,
                  fixedSize: const Size(150, 43),
                  shape: StadiumBorder(),
                ),
                icon: Icon(
                  Icons.navigate_next,
                  color: sColor,
                  size: 30,
                ),
                label: Text(
                  'วิธีปรุงยาสมุนไพร',
                  style: TextStyle(fontSize: 18, color: sColor),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MethodScreens(
                        imgURL: widget.imgURL,
                        name: widget.name,
                        ename: widget.ename,
                        Cname: widget.Cname,
                      ),
                    ),
                  );
                },
              ),
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

/*
  buildFloatingButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(right: 20.0),
        child: Container(
          height: 60.0,
          width: 60.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Theme.of(context).accentColor,
            boxShadow: [
              BoxShadow(
                //color: Colors.orange[200],
                offset: Offset(0.0, 10.0),
                blurRadius: 10,
              ),
            ],
          ),
          child: IconButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (contex) => DetailsScreensDS(),
                  ),
                );
              },
              icon: Icon(
                Icons.favorite,
              )),
          /*child: Center(
            child: Icon(
              Feather.plus,
              color: Colors.white,
              size: 25.0,
            ),
          ),
        ),*/
        ),
      ),
    );
  }
*/
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
/*
class ProductItem extends StatelessWidget {
  final Map furniture;

  ProductItem(this.furniture);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 20),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return Details();
              },
            ),
          );
        },
        child: Container(
          height: 140,
          width: 140,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(
              "${furniture["img"]}",
              height: 140,
              width: 140,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
*/
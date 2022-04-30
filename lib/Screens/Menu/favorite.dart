import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';
import 'package:login_logout_app/Screens/Menu2.dart';

import '../../constants.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite),
            color: aColor,
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (contex) => favorite(),
                ),
              );
            },
          ),
        ],
        backgroundColor: gColor,
        title: Text('Medicinal Herbs'),
      ),
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'asset/image/path.png',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.fitWidth,
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Text(
                      'สิ่งที่ฉันถูกใจ',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Herb',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 1.7,
                  child: ListView(
                    children: <Widget>[
                      Card(
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Expanded(
                                    child: Image.asset("asset/image/herb.jpg"),
                                    flex: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ListTile(
                                          title: Text("กัญชา"),
                                          subtitle: Text("Cannabis indica"),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: Text("รายละเอียด"),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (contex) =>
                                                        Control(),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            /*   TextButton(
                                  child: Text("วิธีการปรุง"),
                                  onPressed: () {},
                                ),*/
                                            SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 8,
                              ),
                            ],
                          ),
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        shadowColor: gColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Expanded(
                                    child: Image.asset("asset/image/ow.png"),
                                    flex: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ListTile(
                                          title: Text("กระเพรา"),
                                          subtitle: Text("Ocimum tenuiflorum"),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: Text("รายละเอียด"),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (contex) =>
                                                        Control(),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            /*   TextButton(
                                  child: Text("วิธีการปรุง"),
                                  onPressed: () {},
                                ),*/
                                            SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 8,
                              ),
                            ],
                          ),
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        shadowColor: gColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Expanded(
                                    child: Image.asset("asset/image/1628.png"),
                                    flex: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ListTile(
                                          title: Text(" ขมิ้นชัน"),
                                          subtitle: Text("Curcuma longa L."),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: Text("รายละเอียด"),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (contex) =>
                                                        Control(),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            /*   TextButton(
                                  child: Text("วิธีการปรุง"),
                                  onPressed: () {},
                                ),*/
                                            SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 8,
                              ),
                            ],
                          ),
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        shadowColor: gColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Expanded(
                                    child: Image.asset(
                                        "asset/image/storyetail.png"),
                                    flex: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ListTile(
                                          title: Text("กระเทียม"),
                                          subtitle: Text("Allium sativum L."),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: Text("รายละเอียด"),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (contex) =>
                                                        Control(),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            /*   TextButton(
                                  child: Text("วิธีการปรุง"),
                                  onPressed: () {},
                                ),*/
                                            SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 8,
                              ),
                            ],
                          ),
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        shadowColor: gColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Expanded(
                                    child: Image.asset("asset/image/zd43.png"),
                                    flex: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ListTile(
                                          title: Text("ว่านหางจระเข้"),
                                          subtitle:
                                              Text("Aloe vera (L.) Burm.f."),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: Text("รายละเอียด"),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (contex) =>
                                                        Control(),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            /*   TextButton(
                                  child: Text("วิธีการปรุง"),
                                  onPressed: () {},
                                ),*/
                                            SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 8,
                              ),
                            ],
                          ),
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        shadowColor: gColor,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Card(
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Expanded(
                                    child: Image.asset("asset/image/5f4af.png"),
                                    flex: 2,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.topLeft,
                                  child: Column(
                                    children: [
                                      Expanded(
                                        flex: 5,
                                        child: ListTile(
                                          title: Text("ฟ้าทะลายโจร"),
                                          subtitle:
                                              Text("Andrographis paniculata"),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            TextButton(
                                              child: Text("รายละเอียด"),
                                              onPressed: () {
                                                Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                    builder: (contex) =>
                                                        Control(),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 8,
                                            ),
                                            /*   TextButton(
                                  child: Text("วิธีการปรุง"),
                                  onPressed: () {},
                                ),*/
                                            SizedBox(
                                              width: 8,
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                flex: 8,
                              ),
                            ],
                          ),
                        ),
                        elevation: 8,
                        margin: EdgeInsets.all(10),
                        shadowColor: gColor,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

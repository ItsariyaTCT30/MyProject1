import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';
import 'package:login_logout_app/Screens/Menu2.dart';
import 'package:login_logout_app/Screens/components/Herb_Details_Screens.dart';

import '../../constants.dart';

class favorite extends StatefulWidget {
  const favorite({Key? key}) : super(key: key);

  @override
  State<favorite> createState() => _favoriteState();
}

class _favoriteState extends State<favorite> {
  final fdbfirebase = FirebaseDatabase.instance.reference().child('favorite');

  Future<void> _delete(String ref) async {
    await FirebaseStorage.instance.refFromURL(ref).delete();
  }

  Future<void> orderN() async {
    var db = FirebaseDatabase.instance.reference().child("favorite");
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
            'ftName': v["ftName"],
            'feName': v["feName"],
            'fhName': v["fhName"],
            'fdName': v["fdName"],
            'fimgURL': v["fimgURL"],
            'amonth': v["amonth"],
          }).then((value) {
            print("Update Success");
            fdbfirebase.child(k).update({
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
                    SizedBox(
                      width: 25,
                    ),
                    Text(
                      'สิ่งที่ฉันถูกใจ',
                      style: TextStyle(
                          fontSize: 35,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                  ],
                ),

                Expanded(
                  flex: 12,
                  child: FirebaseAnimatedList(
                    query: fdbfirebase,
                    itemBuilder: (context, snapshot, animation, index) {
                      return Card(
                        child: Container(
                          height: 100,
                          color: Colors.white,
                          child: Row(
                            children: [
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Expanded(
                                    child: Image.network(
                                      ('${snapshot.value['fimgURL']}'),
                                    ),
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
                                          title: Text(
                                            '${snapshot.value['ftName']}',
                                          ),
                                          subtitle: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                  child: Padding(
                                                    padding:
                                                        new EdgeInsets.only(
                                                            right: 13.0),
                                                    child: Text(
                                                      '${snapshot.value['feName']}',
                                                      /* style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),*/
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: Icon(
                                                  Icons.favorite_border,
                                                  color: Colors.red,
                                                ),
                                                onPressed: () {
                                                  _showMyDialog(
                                                    snapshot.key,
                                                    '${snapshot.value['fimgURL']}',
                                                  );
                                                  //dbfirebase.child(snapshot.key!).remove();
                                                },
                                              ),
                                            ],
                                          ),
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
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (_) =>
                                                        DetailsScreens(
                                                      imgURL: snapshot
                                                          .value['fimgURL'],
                                                      name: snapshot
                                                          .value['ftName'],
                                                      ename: snapshot
                                                          .value['feName'],
                                                      dname: snapshot
                                                          .value['fdName'],
                                                      hname: snapshot
                                                          .value['fhName'],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                            SizedBox(
                                              width: 15,
                                            ),
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
                      );

                      //----------------------------------------------------------------------
                    },
                  ),
                ),
                //--------------------------------------------------------------------------
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showMyDialog(var key, imgurl) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'ยืนยันการลบ',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text(
                  'คุณแน่ใจใช่ไหมที่จะลบรายการ',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'ยืนยัน',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                print('Confirmed');
                _delete(imgurl);
                fdbfirebase.child(key).remove();
                //print(key);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'ยกเลิก',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

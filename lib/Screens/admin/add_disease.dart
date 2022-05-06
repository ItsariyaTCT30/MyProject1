import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:login_logout_app/Screens/Herb_Control.dart';
import 'package:login_logout_app/Screens/admin/edit2.dart';
import 'package:login_logout_app/constants.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class AddDisease extends StatefulWidget {
  const AddDisease({Key? key}) : super(key: key);

  @override
  _AddDiseaseState createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? name, imgURL;
  final formKey = GlobalKey<FormState>();
  var file;
  final picker = ImagePicker();
  File? imageFile;
  String? fileName;

  //-----------------------------------------------
// Initial Selected Value
  List<String> _type = [
    'ระบบไหลเวียนโลหิต',
    'ระบบทางเดินอาหาร',
    'แก้ไข้',
    'โรคติดต่อ',
    'อาการทางกล้ามเนื้อ',
    'ฟัน',
    'แก้พิษ',
    'อาการทางผิวหนัง',
  ];

  String? _selectedType;

  //-------------------------------------------------

  ListResult? result;
  List<Reference>? allFiles;
  String? fileUrl;
  FullMetadata? fileMeta;

  //กำหนดค่าเริ่มต้นสำหรับการส่งข้อมูลไปที่ Realtime Firebase
  final dbfirebase = FirebaseDatabase.instance.reference().child('Disease');

  get hdbfirebase => FirebaseDatabase.instance.reference().child('Food');

  String myPet = '';

  // Select and image from the gallery or take a picture with the camera
  // Then upload to Firebase Storage
  Future<void> _upload(String inputSource) async {
    PickedFile? pickedImage;
    try {
      // ignore: deprecated_member_use
      pickedImage = await picker.getImage(
          source: inputSource == 'camera'
              ? ImageSource.camera
              : ImageSource.gallery);

      fileName = path.basename(pickedImage!.path);
      setState(() {
        file = File(pickedImage!.path);
      });

      imageFile = File(pickedImage.path);
    } catch (err) {
      print(err);
    }
  }

  Future<void> createData() async {
    if (file != null && _selectedType != null) {
      try {
        TaskSnapshot snapshot =
            await storage.ref().child("Image/$name").putFile(file);
        if (snapshot.state == TaskState.success) {
          final String downloadUrl = await snapshot.ref.getDownloadURL();
          await dbfirebase.push().set({
            'tName': name,
            'type': _selectedType,
            'imgURL': downloadUrl,
            'amonth': 0,
          }).then((value) {
            formKey.currentState!.reset();
            file = null;
            _selectedType = null;
            print("Success");
          }).catchError((onError) {
            print(onError.code);
            print(onError.message);
          });
          final snackBar = SnackBar(content: Text('เพิ่มสำเร็จ'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          print(fileName);
          print(imageFile);
          print(downloadUrl);
          setState(() {});
        } else {
          print('Error from image repo ${snapshot.state.toString()}');
          throw ('This file is not an image');
        }
      } on FirebaseException catch (error) {
        print(error);
      }
    } else {
      _onBasicAlertPressed(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    void _showSettingsPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
              child: Container(
                color: Colors.white,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.edit,
                    color: sColor,
                    size: 24.0,
                  ),
                  label: Text(
                    'แก้ไขข้อบ่งใช้',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (contex) => SDisease(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: gColor,
                    shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(20.0),
                    ),
                  ),
                ),
              ),
            );
          });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: gColor,
        title: Text(
          "เพิ่มข้อบ่งใช้",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.edit,
              color: sColor,
              size: 24.0,
            ),
            onPressed: () => _showSettingsPanel(),
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("asset/image/bg1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () => _upload('gallery'),
                            icon: Icon(Icons.library_add),
                            label: Text('Gallery'),
                            style: ElevatedButton.styleFrom(
                              primary: gColor,
                            ),
                          ),
                        ],
                      ),
                      txtTTTName(),
                      txtName(),
                      // txtTTName(),
                      Center(
                        child: file == null
                            ? Text('ไม่มีรูปภาพ')
                            : CircleAvatar(
                                radius: 50,
                                backgroundImage: Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                ).image,
                              ),
                      ),
                      btnSubmit(),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //-----------------------------------------------------

                //-----------------------------------------------------
                Expanded(
                  child: FirebaseAnimatedList(
                    query: hdbfirebase,
                    itemBuilder: (context, snapshot, animation, index) {
                      return /*Container(
                        child: Column(
                          children: [
                            RadioListTile(
                              value: '${snapshot.value['tName']}',
                              groupValue: myPet,
                              onChanged: (value) {
                                setState(() {
                                  myPet = value.toString();
                                });
                              },
                              title: Text('${snapshot.value['tName']}'),
                            ),
                          ],
                        ),
                      );*/
                          Container(
                        //height: 100,
                        child: Padding(
                          padding: EdgeInsets.all(3.0),
                          child: Card(
                            elevation: 5,
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 28,
                                backgroundImage:
                                    NetworkImage('${snapshot.value['imgURL']}'),
                                //backgroundColor: pColor,
                              ),
                              title: Text(
                                '${snapshot.value['tName']}',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Row(
                                children: <Widget>[
                                  Flexible(
                                    child: Container(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          '${snapshot.value['eName']}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  /* RadioListTile(
                                    value: 'dog',
                                    groupValue: myPet,
                                    onChanged: (value) {
                                      setState(() {
                                        myPet = value.toString();
                                      });
                                    },
                                  )*/
                                  IconButton(
                                    icon: Icon(
                                      Icons.add_box,
                                      color: Colors.red,
                                    ),
                                    onPressed: () {},
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                      //---------------------------------
/*
                          ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                          bottomLeft: Radius.circular(50),
                        ),
                        child: Container(
                          height: 170,
                          color: Colors.grey,
                          child: Stack(
                            children: <Widget>[
                              Align(
                                child: Image.network(
                                  ('${snapshot.value['imgURL']}'),
                                  width: 400,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              /*  Align(
                                  alignment: Alignment.topLeft,
                                  child: IconButton(
                                      icon: Icon(Icons.favorite_border,
                                          color: sColor),
                                      onPressed: null),
                                ),*/
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 20, bottom: 15, top: 10),
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        '${snapshot.value['tName']}',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 30,
                                            color: sColor),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          /*      CircleAvatar(
                                              radius: 10,
                                              backgroundImage: AssetImage(
                                                  'asset/image/123321.jpg'),
                                            ),*/
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              'Ocimum tenuiflorum',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w600,
                                                  color: sColor),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );*/
                      //---------------------------------
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _onBasicAlertPressed(context) {
    Alert(
      style: AlertStyle(
        backgroundColor: sColor,
        titleStyle: TextStyle(fontSize: 32),
      ),
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
      context: context,
      title: "กรุณาเพิ่มรูปภาพ",
      //desc: "Flutter is more awesome with RFlutter Alert.",
    ).show();
  }

  Widget txtName() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 15, 15, 10),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'ชื่ออาการ :',
          hintText: 'Input your table name',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาป้อนข้อมูล';
          }
        },
        onSaved: (value) {
          name = value!.trim();
        },
      ),
    );
  }

  Widget txtTTTName() {
    return Center(
      child: DropdownButton(
        hint: Text('กรุณาเลือกประเภท'), // Not necessary for Option 1
        value: _selectedType,
        onChanged: (newValue) {
          setState(() {
            _selectedType = newValue.toString();
          });
        },
        items: _type.map((type) {
          return DropdownMenuItem(
            child: new Text(type),
            value: type,
          );
        }).toList(),
      ),
    );
  }

  Widget btnSubmit() => ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: gColor,
        ),
        onPressed: () {
          if (formKey.currentState!.validate()) {
            formKey.currentState!.save();
            createData();
          }
        },
        child: Text('เพิ่ม'),
      );
}

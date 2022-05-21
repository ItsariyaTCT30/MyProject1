import 'dart:io';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:login_logout_app/constants.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditDisease extends StatefulWidget {
  final dynamic foodKey, readName, readtype, readURL;
  const EditDisease(
      {required this.foodKey, this.readName, this.readtype, this.readURL})
      : super();

  @override
  _EditDiseaseState createState() => _EditDiseaseState();
}

class _EditDiseaseState extends State<EditDisease> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? name, Cname, imgURL, Hiname, Htname, Hename, Hdname, Hhname;
  final formKey = GlobalKey<FormState>();
  var file;
  final picker = ImagePicker();
  File? imageFile;
  String? fileName;
  String? filecName;
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

  ListResult? result;
  List<Reference>? allFiles;
  String? fileUrl;
  FullMetadata? fileMeta;

  //กำหนดค่าเริ่มต้นสำหรับการส่งข้อมูลไปที่ Realtime Firebase
  final dbfirebase = FirebaseDatabase.instance.reference().child('Disease');
  get hdbfirebase => FirebaseDatabase.instance.reference().child('Food');
  var db;

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
        //img = File(pickedImage!.path).toString();
      });
      imageFile = File(pickedImage.path);
      //img = pickedImage.path;
    } catch (err) {
      print(err);
    }
  }

  Future<void> updateData(Hiname, Htname, Hename, Hdname, Hhname) async {
    FirebaseStorage.instance.refFromURL(widget.readURL).delete();
    try {
      TaskSnapshot snapshot =
          await storage.ref().child("Image/$name").putFile(file);
      if (snapshot.state == TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        await dbfirebase.child(widget.foodKey).update({
          'tName': name,
          'cName': Cname,
          'type': _selectedType,
          'imgURL': downloadUrl,
          'hiName': Hiname,
          'htName': Htname,
          'heName': Hename,
          'hdName': Hdname,
          'hhName': Hhname,
        }).then((value) {
          print("Success");
          Navigator.of(context).pop();
        }).catchError((onError) {
          print(onError.code);
          print(onError.message);
        });
        final snackBar = SnackBar(content: Text('แก้ไขสำเร็จ'));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        print(fileName);
        print(filecName);
        print(imageFile);
        print("URL" + downloadUrl.toString());
        //setState(() {});
      } else {
        print('Error from image repo ${snapshot.state.toString()}');
        throw ('This file is not an image');
      }
    } on FirebaseException catch (error) {
      print(error);
    }
  }

  Future<void> updateData2(Hiname, Htname, Hename, Hdname, Hhname) async {
    await dbfirebase.child(widget.foodKey).update({
      'tName': name,
      'cName': Cname,
      'type': _selectedType,
      'imgURL': widget.readURL,
      'hiName': Hiname,
      'htName': Htname,
      'heName': Hename,
      'hdName': Hdname,
      'hhName': Hhname,
    }).then((value) {
      print("Success2");
      Navigator.of(context).pop();
    }).catchError((onError) {
      print(onError.code);
      print(onError.message);
    });
    final snackBar = SnackBar(content: Text('แก้ไขสำเร็จ'));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    print(fileName);
    print(filecName);
    print(imageFile);
    print(file);
    //setState(() {});
  }

/*
  var img, nameE;
  Future loadData() async {
    await dbfirebase.child(widget.foodKey).once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value['tName']}');
      nameE = snapshot.value['tName'];
      img = snapshot.value['imgURL'];
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gColor,
        title: Text(
          "แก้ไขข้อบ่งใช้",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
            padding: const EdgeInsets.all(10),
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
                      txtcName(),
                      Center(
                        child: file == null
                            ? CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(widget.readURL!),
                                //backgroundColor: pColor,
                              )
                            : CircleAvatar(
                                radius: 100,
                                backgroundImage: Image.file(
                                  file,
                                  fit: BoxFit.cover,
                                ).image,
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      btnSubmit(),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: FirebaseAnimatedList(
                    query: hdbfirebase,
                    itemBuilder: (context, snapshot, animation, index) {
                      return Container(
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
                                          overflow: TextOverflow.ellipsis,
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
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        Hiname = snapshot.value['imgURL'];
                                        Htname = snapshot.value['tName'];
                                        Hename = snapshot.value['eName'];
                                        Hdname = snapshot.value['dName'];
                                        Hhname = snapshot.value['hName'];

                                        print(Hiname);
                                        print(Htname);
                                        print(Hename);
                                        print(Hdname);
                                        print(Hhname);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
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
        ),
      ),
    );
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

  Widget txtcName() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 15, 15, 10),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'วิธีการปรุงสมุนไพร :',
          hintText: 'Input your table name',
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาป้อนข้อมูล';
          }
        },
        onSaved: (value) {
          Cname = value!.trim();
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
            file == null
                ? updateData2(Hiname, Htname, Hename, Hdname, Hhname)
                : updateData(Hiname, Htname, Hename, Hdname, Hhname);
            formKey.currentState!.reset();
            file = null;
          }
          //print(nameE);
        },
        child: Text(
          'แก้ไข',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}

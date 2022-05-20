import 'dart:io';
import 'package:login_logout_app/constants.dart';
import 'package:path/path.dart' as path;
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditFood extends StatefulWidget {
  final dynamic foodKey, readName, readEName, readDName, readURL;
  const EditFood(
      {required this.foodKey,
      this.readName,
      this.readEName,
      this.readDName,
      this.readURL})
      : super();

  @override
  _EditFoodState createState() => _EditFoodState();
}

class _EditFoodState extends State<EditFood> {
  FirebaseStorage storage = FirebaseStorage.instance;
  String? name, Ename, Dname, imgURL;
  final formKey = GlobalKey<FormState>();
  var file;
  final picker = ImagePicker();
  File? imageFile;
  String? fileName;
  String? fileEName;
  String? fileDName;

  ListResult? result;
  List<Reference>? allFiles;
  String? fileUrl;
  FullMetadata? fileMeta;

  //กำหนดค่าเริ่มต้นสำหรับการส่งข้อมูลไปที่ Realtime Firebase
  final dbfirebase = FirebaseDatabase.instance.reference().child('Food');
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

  Future<void> updateData() async {
    FirebaseStorage.instance.refFromURL(widget.readURL).delete();
    try {
      TaskSnapshot snapshot =
          await storage.ref().child("Image/$name").putFile(file);
      if (snapshot.state == TaskState.success) {
        final String downloadUrl = await snapshot.ref.getDownloadURL();
        await dbfirebase.child(widget.foodKey).update({
          'tName': name,
          'eName': Ename,
          'dName': Dname,
          'imgURL': downloadUrl,
          'amonth': 0,
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
        print(fileEName);
        print(fileDName);
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

  Future<void> updateData2() async {
    await dbfirebase.child(widget.foodKey).update({
      'tName': name,
      'eName': Ename,
      'dName': Dname,
      'imgURL': widget.readURL,
      'amonth': 0,
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
    print(fileEName);
    print(fileDName);
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
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gColor,
        title: Text(
          "แก้ไขสมุนไพร",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
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
                              onPressed: () => _upload('camera'),
                              icon: Icon(Icons.camera),
                              label: Text('Camera'),
                              style: ElevatedButton.styleFrom(
                                primary: gColor,
                              ),
                            ),
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
                        txtName(),
                        txteName(),
                        txtdName(),
                        Center(
                          child: file == null
                              ? CircleAvatar(
                                  radius: 45,
                                  backgroundImage:
                                      NetworkImage(widget.readURL!),
                                  //backgroundColor: pColor,
                                )
                              : CircleAvatar(
                                  radius: 45,
                                  backgroundImage: Image.file(
                                    file,
                                    fit: BoxFit.cover,
                                  ).image,
                                ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        btnSubmit(),
                        SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: size.height * 0.27,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
          labelText: 'ชื่อสมุนไพร :',
          hintText: widget.readName,
        ),
        initialValue: widget.readName,
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

  Widget txteName() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 15, 10),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'ชื่อวิทยาศาสตร์ :',
          hintText: widget.readEName,
        ),
        initialValue: widget.readEName,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาป้อนข้อมูล';
          }
        },
        onSaved: (value) {
          Ename = value!.trim();
        },
      ),
    );
  }

  Widget txtdName() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 0, 15, 10),
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'รายละเอียด :',
          hintText: widget.readDName,
        ),
        initialValue: widget.readDName,
        validator: (value) {
          if (value!.isEmpty) {
            return 'กรุณาป้อนข้อมูล';
          }
        },
        onSaved: (value) {
          Dname = value!.trim();
        },
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
            file == null ? updateData2() : updateData();
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

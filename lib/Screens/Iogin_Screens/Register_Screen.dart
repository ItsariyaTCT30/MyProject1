import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_logout_app/Component/button.dart';

import '../../constants.dart';
import 'Login_Screen.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String name = '';
  String email = '';
  String password = '';
  String age = '';
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: gColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: yColor,
            size: 30,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body:
          /*isloading
          ? Center(
              child: CircularProgressIndicator(),
            )*/
          Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("asset/image/bg3.png"), fit: BoxFit.cover),
        ),
        child: Form(
          key: formkey,
          child: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle.light,
            child: Stack(
              children: [
                Container(
                  /*height: double.infinity,
                      width: double.infinity,
                      color: Colors.grey[200],*/
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Hero(
                          tag: '1',
                          child: Text(
                            "Sign up",
                            style: TextStyle(
                                fontSize: 50,
                                color: tColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
//---------------------------------------
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.account_circle,
                              size: 40,
                            ),
                            hintText: 'Please enter Name',
                            labelText: 'Name *',
                          ),
                          //onSaved: (String? value) {},
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            name = value.toString().trim();
                          },
                          validator: (value) =>
                              (value!.isEmpty) ? ' Please enter Name' : null,
                        ),
//--------------------------------------------

//---------------------------------------
                        SizedBox(
                          height: size.height * 0.045,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.email,
                              size: 40,
                            ),
                            hintText: 'Please enter Email',
                            labelText: 'Email *',
                          ),
                          //onSaved: (String? value) {},
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value.toString().trim();
                          },
                          validator: (value) =>
                              (value!.isEmpty) ? ' Please enter email' : null,
                        ),
//--------------------------------------------

//---------------------------------------
                        SizedBox(
                          height: size.height * 0.045,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              size: 40,
                            ),
                            hintText: 'Please enter Password',
                            labelText: 'Password *',
                          ),
                          //onSaved: (String? value) {},
                          obscureText: true,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Password";
                            }
                          },
                          onChanged: (value) {
                            password = value;
                          },
                        ),
//--------------------------------------------

//---------------------------------------
                        SizedBox(
                          height: size.height * 0.045,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            icon: Icon(
                              Icons.child_care_outlined,
                              size: 40,
                            ),
                            hintText: 'Please enter Age',
                            labelText: 'Age *',
                          ),
                          //onSaved: (String? value) {},
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            age = value.toString().trim();
                          },
                          validator: (value) =>
                              (value!.isEmpty) ? ' Please enter Age' : null,
                        ),
//--------------------------------------------
                        SizedBox(
                          height: size.height * 0.08,
                        ),
                        LoginSignupButton(
                          title: 'Register',
                          ontapp: () async {
                            if (formkey.currentState!.validate()) {
                              setState(() {
                                isloading = true;
                              });
                              try {
                                await _auth.createUserWithEmailAndPassword(
                                    email: email, password: password);

                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor: Colors.blueGrey,
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          'Sucessfully Register.You Can Login Now'),
                                    ),
                                    duration: Duration(seconds: 5),
                                  ),
                                );
                                Navigator.of(context).pop();

                                setState(() {
                                  isloading = false;
                                });
                              } on FirebaseAuthException catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (ctx) => AlertDialog(
                                    title: Text(' Ops! Registration Failed'),
                                    content: Text('${e.message}'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(ctx).pop();
                                        },
                                        child: Text('Okay'),
                                      )
                                    ],
                                  ),
                                );
                              }
                              setState(() {
                                isloading = false;
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

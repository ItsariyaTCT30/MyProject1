import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_logout_app/Component/button.dart';
import 'package:login_logout_app/Screens/Menu2.dart';
import 'package:login_logout_app/Screens/admin/admin_home.dart';
import 'package:login_logout_app/Screens/index_home.dart';
import 'package:login_logout_app/Screens/menu.dart';
import 'package:sign_button/sign_button.dart';
import '../../constants.dart';
import '../Home_Screen.dart';
import 'Register_Screen.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  String email = '';
  String password = '';
  bool isloading = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("asset/image/bg2.png"),
              fit: BoxFit.cover,
            ),
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
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: size.height * 0.045,
                          ),
                          Text(
                            "Sign In",
                            style: TextStyle(
                                fontSize: 60,
                                color: tColor,
                                fontWeight: FontWeight.bold),
                          ),
                          //---------------------------------------
                          SizedBox(
                            height: size.height * 0.045,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.email,
                                size: 30,
                              ),
                              hintText: ' What do people call you?',
                              labelText: 'Email *',
                            ),
                            //onSaved: (String? value) {},
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              email = value;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter Email";
                              }
                            },
                          ),

                          SizedBox(
                            height: size.height * 0.035,
                          ),

                          TextFormField(
                            decoration: const InputDecoration(
                              icon: Icon(
                                Icons.lock_rounded,
                                size: 30,
                              ),
                              hintText: 'What do people call you?',
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

                          SizedBox(
                            height: size.height * 0.06,
                          ),

                          //-----------------------------------------------------------
                          LoginSignupButton(
                            title: 'Login',
                            ontapp: () async {
                              if (formkey.currentState!.validate()) {
                                setState(() {
                                  isloading = true;
                                });
                                try {
                                  if (email == "admin@admin.com") {
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (contex) =>
                                            MainMenu(), //MainMenu(),
                                      ),
                                    );

                                    setState(() {
                                      isloading = false;
                                    });
                                  } else {
                                    await _auth.signInWithEmailAndPassword(
                                        email: email, password: password);

                                    await Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (contex) =>
                                            IndexHome(), //IndexHome(),
                                      ),
                                    );

                                    setState(() {
                                      isloading = false;
                                    });
                                  }
                                } on FirebaseAuthException catch (e) {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) => AlertDialog(
                                      title: Text("Ops! Login Failed"),
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
                                  print(e);
                                }
                                setState(() {
                                  isloading = false;
                                });
                              }
                            },
                          ),

                          //-----------------------------------------------------------

                          SizedBox(
                            height: size.height * 0.05,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignupScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Don't have an Account ?",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black87),
                                ),
                                SizedBox(
                                  width: size.width * 0.03,
                                ),
                                Hero(
                                  tag: '1',
                                  child: Text(
                                    'Sign up',
                                    style: TextStyle(
                                        fontSize: 21,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  ),
                                )
                              ],
                            ),
                          ),
                          /*--------ปุ่มล็อกอิน google facebook---------------------------------------------------------------*/
                          SizedBox(
                            height: size.height * 0.06,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 1,
                                  width: 130,
                                  color: sColor,
                                ),
                                Text(
                                  " Or ",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: sColor,
                                  ),
                                ),
                                Container(
                                  height: 1,
                                  width: 130,
                                  color: sColor,
                                ),
                              ]),
                          //SizedBox(height: 10),
                          /*-logingoogle_test-*/ /*LoginSignupButton(
                              title: 'Sign In Google',
                              ontapp: () async {
                                await signIn();
                              }),
                              */
                          //---------------------------------------------------------------------------
                          /*  ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: sColor,
                                fixedSize: const Size(290, 43),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Text(
                              "GO !",
                              style: TextStyle(
                                fontSize: 25,
                                color: gColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contex) => IndexHome(), //Menu2
                                ),
                              );
                            },
                          ),*/
                          //SizedBox(height: 10),
                          /*  ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: sColor,
                                fixedSize: const Size(290, 43),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50))),
                            child: Text(
                              "Admin !",
                              style: TextStyle(
                                fontSize: 25,
                                color: gColor,
                              ),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (contex) => MainMenu(),
                                ),
                              );
                            },
                          ),*/
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          /*--logingoogle---*/ SignInButton(
                            buttonType: ButtonType.google,
                            buttonSize: ButtonSize
                                .large, // small(default), medium, large
                            onPressed: () async {
                              signIn();
                            },
                          ),
                          SizedBox(
                            height: size.height * 0.04,
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
      ),
    );
  }

  void signOut() {
    _googleSignIn.disconnect();
  }

  Future<void> signIn() async {
    try {
      await _googleSignIn.signIn().then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => IndexHome()), //Menu2
            ),
          );
    } catch (e) {
      print('Error signing in $e');
    }
  }
}

// ignore_for_file: unused_field

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:starbhakpiket/pages/auth/forgotPass.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback onClickSignUp;
  const LoginPage({
    Key? key,
    required this.onClickSignUp,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late SharedPreferences _prefs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool passwordVisible = false;
  bool _isLoading = false;
  bool _isChecked = false;

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    setState(() {
      _isChecked = _prefs.getBool('rememberMe') ?? false;
      if (_isChecked) {
        emailController.text = _prefs.getString('email') ?? '';
        passwordController.text = _prefs.getString('password') ?? '';
      }
    });
  }

  Future<void> _savePrefs() async {
    await _prefs.setBool('rememberMe', _isChecked);
    if (_isChecked) {
      await _prefs.setString('email', emailController.text);
      await _prefs.setString('password', passwordController.text);
    } else {
      await _prefs.remove('email');
      await _prefs.remove('password');
    }
  }

  void _showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occurred!'),
        content: Text(errorMessage),
        actions: <Widget>[
          ElevatedButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(
                  child: Container(
                      margin: EdgeInsets.only(top: 40, bottom: 20),
                      width: 180,
                      height: 180,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border:
                              Border.all(color: Color(0xff7F669D), width: 3)),
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/logo.png'),
                      )),
                ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 15, 30, 40),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              child: Text(
                                "Starbhak Piket",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 30),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 3,
                            ),
                            Container(
                              width: double.maxFinite,
                              child: Text(
                                "HI, Welcome back",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                      color: Colors.black54,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 40),
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email Address",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    controller: emailController,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (email) => email != null &&
                                            !EmailValidator.validate(email)
                                        ? 'Enter a valid email'
                                        : null,
                                    decoration: InputDecoration(
                                        labelText: 'Enter Your Email',
                                        hintText: 'example@exmp.le',
                                        floatingLabelBehavior:
                                            FloatingLabelBehavior.never,
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                7.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade400)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              7.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade400),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              7.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.red.shade700),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              7.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.red.shade700),
                                        ),
                                        labelStyle: const TextStyle(
                                            color: Colors.black54)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              width: double.maxFinite,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Password",
                                    textAlign: TextAlign.start,
                                    style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  TextFormField(
                                    controller: passwordController,
                                    obscureText: !passwordVisible,
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        value != null && value.length < 6
                                            ? 'Enter min 6 characters'
                                            : null,
                                    decoration: InputDecoration(
                                      labelText: 'Enter Your Password',
                                      hintText: 'min 6 char',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(
                                              7.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade400)),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            7.0),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.grey.shade400),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            7.0),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red.shade700),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(
                                            7.0),
                                        borderSide: BorderSide(
                                            width: 1,
                                            color: Colors.red.shade700),
                                      ),
                                      labelStyle: const TextStyle(
                                          color: Colors.black54),
                                      suffixIcon: IconButton(
                                        onPressed: togglePasswordVisibility,
                                        icon: Icon(
                                          passwordVisible
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              width: double.maxFinite,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Checkbox(
                                          value: _isChecked,
                                          onChanged: (value) {
                                            setState(() {
                                              _isChecked = value!;
                                            });
                                          },
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.shrinkWrap,
                                          visualDensity: VisualDensity(
                                            horizontal:
                                                VisualDensity.minimumDensity,
                                            vertical:
                                                VisualDensity.minimumDensity,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          checkColor: Colors.black,
                                          activeColor: Colors.white,
                                        ),
                                        SizedBox(width: 5),
                                        Text(
                                          "Remember me",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgotPasswordPage()));
                                      },
                                      child: Text(
                                        "Forgot Password",
                                        textAlign: TextAlign.start,
                                        style: GoogleFonts.quicksand(
                                          textStyle: TextStyle(
                                            color:
                                                Color.fromARGB(255, 255, 3, 3),
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 18),
                            SizedBox(
                              width: double.maxFinite,
                              height: 45,
                              child: ElevatedButton(
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color(0xff7F669D)),
                                ),
                                onPressed: _login,
                                child: Text(
                                  "Login",
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // Container(
                            //   margin: EdgeInsets.only(top: 30),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       Container(
                            //         height: 1.5,
                            //         width: 100,
                            //         color: Colors.black26,
                            //       ),
                            //       Text(
                            //         "Or Login With",
                            //         textAlign: TextAlign.start,
                            //         style: GoogleFonts.quicksand(
                            //           textStyle: TextStyle(
                            //             color: Colors.black45,
                            //             fontWeight: FontWeight.w600,
                            //             fontSize: 15,
                            //           ),
                            //         ),
                            //       ),
                            //       Container(
                            //         height: 1.5,
                            //         width: 100,
                            //         color: Colors.black26,
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            // Container(
                            //   margin: EdgeInsets.only(top: 20),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Expanded(
                            //         child: Container(
                            //           height: 55,
                            //           child: ElevatedButton(
                            //             style: ButtonStyle(
                            //               shape: MaterialStateProperty.all<
                            //                   RoundedRectangleBorder>(
                            //                 RoundedRectangleBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(5.0),
                            //                   side: BorderSide(
                            //                       width: 1,
                            //                       color: Color.fromARGB(
                            //                           255, 136, 136, 136)),
                            //                 ),
                            //               ),
                            //               backgroundColor:
                            //                   MaterialStateProperty.all<Color>(
                            //                       Colors.white),
                            //             ),
                            //             onPressed: null,
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceEvenly,
                            //               children: [
                            //                 Icon(
                            //                   Icons.facebook,
                            //                   color: Colors.blue,
                            //                   size: 27,
                            //                 ),
                            //                 Text(
                            //                   "Facebook",
                            //                   textAlign: TextAlign.start,
                            //                   style: GoogleFonts.quicksand(
                            //                     textStyle: TextStyle(
                            //                       color: Color.fromARGB(
                            //                           221, 26, 26, 26),
                            //                       fontWeight: FontWeight.w800,
                            //                       fontSize: 17,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //       SizedBox(width: 10,),
                            //       Expanded(
                            //         child: Container(
                            //           height: 55,
                            //           child: ElevatedButton(
                            //             style: ButtonStyle(
                            //               shape: MaterialStateProperty.all<
                            //                   RoundedRectangleBorder>(
                            //                 RoundedRectangleBorder(
                            //                   borderRadius:
                            //                       BorderRadius.circular(5.0),
                            //                   side: BorderSide(
                            //                       width: 1,
                            //                       color: Color.fromARGB(
                            //                           255, 136, 136, 136)),
                            //                 ),
                            //               ),
                            //               backgroundColor:
                            //                   MaterialStateProperty.all<Color>(
                            //                       Colors.white),
                            //             ),
                            //             onPressed: signInWithGoogle,
                            //             child: Row(
                            //               mainAxisAlignment:
                            //                   MainAxisAlignment.spaceEvenly,
                            //               children: [
                            //                 Image.asset('assets/images/google.png', width: 25,),
                            //                 Text(
                            //                   "Google",
                            //                   textAlign: TextAlign.start,
                            //                   style: GoogleFonts.quicksand(
                            //                     textStyle: TextStyle(
                            //                       color: Color.fromARGB(
                            //                           221, 26, 26, 26),
                            //                       fontWeight: FontWeight.w800,
                            //                       fontSize: 17,
                            //                     ),
                            //                   ),
                            //                 ),
                            //               ],
                            //             ),
                            //           ),
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   padding: EdgeInsets.only(left: 10, top: 265),
                  //   child: RichText(
                  //     text: TextSpan(
                  //         text: 'No Acount?  ',
                  //         style: GoogleFonts.quicksand(
                  //           textStyle: TextStyle(
                  //             color: Colors.black54,
                  //             fontWeight: FontWeight.w500,
                  //             fontSize: 17,
                  //           ),
                  //         ),
                  //         children: [
                  //           TextSpan(
                  //             recognizer: TapGestureRecognizer()
                  //               ..onTap = widget.onClickSignUp,
                  //             text: 'Sign Up',
                  //             style: GoogleFonts.quicksand(
                  //               textStyle: TextStyle(
                  //                 color: Color(0xff7F669D),
                  //                 fontWeight: FontWeight.w800,
                  //                 fontSize: 16,
                  //               ),
                  //             ),
                  //           )
                  //         ]),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    print(userCredential.user?.displayName);
  }

  Future<void> _login() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    setState(() {
      _isLoading = true;
    });

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(color: Color(0xff7F669D)),
            ));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (_isChecked) {
        await _savePrefs();
      }
      Navigator.of(context).popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      _showErrorDialog(e.message ?? 'An error occurred');
    } catch (e) {
      _showErrorDialog('An error occurred');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}

// ignore_for_file: deprecated_member_use

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:starbhakpiket/main.dart';
import 'package:starbhakpiket/pages/auth/forgotPass.dart';
import 'package:starbhakpiket/pages/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  final Function() onClickSignin;

  const SignUpPage({
    Key? key,
    required this.onClickSignin,
  }) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final String defaultPhotoUrl =
      'https://cdn-icons-png.flaticon.com/512/149/149071.png';

  bool passwordVisible = false;
  bool _isChecked = false;

  void togglePasswordVisibility() {
    setState(() {
      passwordVisible = !passwordVisible;
    });
  }

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(30, 30, 30, 40),
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
                                  "Create Account",
                                  style: GoogleFonts.quicksand(
                                    textStyle: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w800,
                                        fontSize: 25),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Container(
                                width: double.maxFinite,
                                child: Text(
                                  "HI, Welcome User!",
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
                          margin: EdgeInsets.only(top: 20),
                          child: Column(
                            children: [
                              Container(
                                width: double.maxFinite,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Username",
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
                                      controller: usernameController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return 'Please enter your username.';
                                        }
                                        return null;
                                      },
                                      decoration: InputDecoration(
                                          labelText: 'Enter Your Username',
                                          hintText: 'Username',
                                          floatingLabelBehavior:
                                              FloatingLabelBehavior.never,
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade400)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade400),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.red.shade700),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
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
                                height: 12,
                              ),
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
                                              borderRadius:
                                                  BorderRadius.circular(7.0),
                                              borderSide: BorderSide(
                                                  width: 1,
                                                  color: Colors.grey.shade400)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade400),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.red.shade700),
                                          ),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(7.0),
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
                                height: 12,
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
                                            borderRadius:
                                                BorderRadius.circular(7.0),
                                            borderSide: BorderSide(
                                                width: 1,
                                                color: Colors.grey.shade400)),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide(
                                              width: 1,
                                              color: Colors.grey.shade400),
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
                                          borderSide: BorderSide(
                                              width: 2,
                                              color: Colors.red.shade700),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(7.0),
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
                                            onChanged: (value) async {
                                              setState(() {
                                                _isChecked = value!;
                                              });
                                              SharedPreferences prefs =
                                                  await SharedPreferences
                                                      .getInstance();
                                              prefs.setBool(
                                                  'rememberMe', _isChecked);
                                            },
                                            materialTapTargetSize:
                                                MaterialTapTargetSize
                                                    .shrinkWrap,
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
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ForgotPasswordPage()));
                                        },
                                        child: Text(
                                          "",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.quicksand(
                                            textStyle: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 3, 3),
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
                                  onPressed: signUp,
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
                              Container(
                                margin: EdgeInsets.only(top: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 1.5,
                                      width: 100,
                                      color: Colors.black26,
                                    ),
                                    Text(
                                      "Or Login With",
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.quicksand(
                                        textStyle: TextStyle(
                                          color: Colors.black45,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 1.5,
                                      width: 100,
                                      color: Colors.black26,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 55,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 136, 136, 136)),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                          onPressed: () {},
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Icon(
                                                Icons.facebook,
                                                color: Colors.blue,
                                                size: 27,
                                              ),
                                              Text(
                                                "Facebook",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        221, 26, 26, 26),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 55,
                                        child: ElevatedButton(
                                          style: ButtonStyle(
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                side: BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 136, 136, 136)),
                                              ),
                                            ),
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                    Color>(Colors.white),
                                          ),
                                          onPressed: signInWithGoogle,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Image.asset(
                                                'assets/images/google.png',
                                                width: 25,
                                              ),
                                              Text(
                                                "Google",
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.quicksand(
                                                  textStyle: TextStyle(
                                                    color: Color.fromARGB(
                                                        221, 26, 26, 26),
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 17,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10, top: 170),
                      child: RichText(
                        text: TextSpan(
                            text: 'Already have acount?  ',
                            style: GoogleFonts.quicksand(
                              textStyle: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                              ),
                            ),
                            children: [
                              TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = widget.onClickSignin,
                                text: 'Sign In',
                                style: GoogleFonts.quicksand(
                                  textStyle: TextStyle(
                                    color: Color(0xff7F669D),
                                    fontWeight: FontWeight.w800,
                                    fontSize: 16,
                                  ),
                                ),
                              )
                            ]),
                      ),
                    )
                  ],
                ),
              ))
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

  Future signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        builder: (context) => Center(
              child: CircularProgressIndicator(color: Color(0xff7F669D)),
            ));

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      final user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        await user.updateProfile(
            displayName: usernameController.text.trim(),
            photoURL: defaultPhotoUrl);
      }
    } on FirebaseAuthException catch (e) {
      print(e);

      Utils.showSnackBar(e.message);
    }

    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

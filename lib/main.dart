import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:starbhakpiket/components/loadingPage.dart';
import 'package:starbhakpiket/pages/auth/authPage.dart';
import 'package:starbhakpiket/pages/myControllerPage.dart';
import 'package:starbhakpiket/pages/utils/utils.dart';
import 'package:intl/date_symbol_data_local.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initializeDateFormatting('id_ID');
  
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
} 

class _MyAppState extends State<MyApp> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoadingPage(),
      );
    } else {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: Utils.messengerKey,
        navigatorKey: navigatorKey,
        home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(color: Colors.greenAccent),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text("Something went wrong"),
                );
              } else if (snapshot.hasData) {
                return const MyControllerPage();
              } else {
                return const AuthPage();
              }
            }),
      );
    }
  }
}

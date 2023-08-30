import 'package:fireabase_chatapp/helper/helper_function.dart';
import 'package:fireabase_chatapp/pages/auth/login_page.dart';
import 'package:fireabase_chatapp/pages/home_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:fireabase_chatapp/shared/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: Constants.apiKey,
        appId: Constants.appId,
        messagingSenderId: Constants.messagingSenderId,
        projectId: Constants.projectId,
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSignedIn = false;

  @override
  void initState() {
    super.initState();
    getUerLoggedInStatus();
  }

  getUerLoggedInStatus() async {
    await HelperFunction.getUserLoggedInStatus().then(
      (value) {
        if (value != null) {
          setState(() {
            _isSignedIn = value;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Constants().primaryColor,
          scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: _isSignedIn ? HomePage() : LoginPage(),
    );
  }
}

import 'dart:async';
import 'package:daily_recipes_final/pages/main_pages/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  StreamSubscription<User?>? _listener;

  @override
  void initState() {
    initSplash();
    super.initState();
  }

  void initSplash() async {
    await Future.delayed(const Duration(seconds: 1));
    _listener = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user == null) {
        Navigator.pushReplacement( context, MaterialPageRoute(builder: (_) => LogInPage()));
      } else {
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  void dispose() {
    _listener?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:[

                Container(

                  child: Image.asset('assets/images/Logo (1).png', height: 222, width: 424, fit: BoxFit.fill),
                ),

                SizedBox(height: 40,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Text("Cooking Done ", style: TextStyle(color: Colors.deepOrange, fontSize: 25.0, fontWeight: FontWeight.bold, fontFamily: 'Hellix'),),
                    ),

                    Container(
                      child: Text( "The Easy Way.", style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: 'Hellix'),),
                    ),

                  ],
                ),

              ]
          )
      ),
    );
  }
}

import 'package:daily_recipes_final/pages/main_pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgetPassMessage extends StatefulWidget {
  const ForgetPassMessage({super.key});

  @override
  State<ForgetPassMessage> createState() => _ForgetPassMessageState();
}

class _ForgetPassMessageState extends State<ForgetPassMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/frying-pan-empty-assorted-spices.jpg',), fit: BoxFit.cover)),
              child: Column(
                children: <Widget> [
                  Stack(
                    children: <Widget> [
                      Container(
                        padding: EdgeInsets.only(top: 70.0),
                        child: Image.asset('assets/images/Logo (1).png', height: 111, width: 212, fit: BoxFit.fill,),
                      ),

                      Container(
                        padding: EdgeInsets.only(top: 200),
                        child: Center(
                          child:Text( "Forget Password", style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal, color: Colors.white, fontFamily: 'Hellix'),),
                        ),
                      ),
                    ],
                  ),

                  Container(
                    padding: EdgeInsets.only(top: 35),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[

                        Center(child: Text("Hello,\nFollow this link to reset your Daily Recipe password for your Daily Recipe account.", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey.shade400, fontFamily: 'Hellix'))),
                        Container(
                          height: 50.0,
                          width: 315,
                          color: Colors.transparent,

                          child: InkWell(
                            onTap: () async {
                              await launchUrl(Uri.parse('https://recipe-app-final-721ba.firebaseapp.com/__/auth/action?mode=action&oobCode=code'));
                            },

                            child: Text("This Link", style: TextStyle(color: Colors.cyan, decoration: TextDecoration.underline, fontWeight: FontWeight.normal, fontSize: 16.0, fontFamily: 'Hellix')),

                          ),
                        ),

                        Center(child: Text("If you didn’t ask to reset your password, you can ignore this email.", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey.shade400, fontFamily: 'Hellix'))),
                        Center(child: Text("\nThanks,\nDaily Recipe team", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey.shade400, fontFamily: 'Hellix'))),

                        SizedBox(height: 40,),


                      ],
                    ),
                  ),

                  SizedBox(height: 35,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget> [
                      Text("If you still need help, check out", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey.shade400, fontFamily: 'Hellix'),),

                      SizedBox(width: 5.0,),

                      InkWell(
                        onTap: () async {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
                        },

                        child: Center(
                          child: Text("Support.", style: TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.normal, fontSize: 14.0, fontFamily: 'Hellix')),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

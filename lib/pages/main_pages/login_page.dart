import 'package:daily_recipes_final/pages/login_pages/register.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipes_final/pages/login_pages/sign_in.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        resizeToAvoidBottomInset: false,
        body: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/frying-pan-empty-assorted-spices.jpg', ), fit: BoxFit.cover)),
            child:SafeArea(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget> [
                      Stack(
                        children: <Widget> [
                          Container(
                            padding: EdgeInsets.only(top:200.0,),
                            child: Image.asset('assets/images/Logo (1).png', height: 111, width: 212, fit: BoxFit.fill),
                          ),

                          Container(
                            padding: EdgeInsets.only(top:320.0,),
                            child: Text( "Cooking Done The Easy Way", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey.shade400, fontFamily: 'Hellix'),),
                          ),

                        ],
                      ),

                      Container(
                        padding: EdgeInsets.only(top:228.0,),
                        child: Column(
                          children: <Widget> [

                            Container(
                              height: 50.0,
                              width: 315,
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(15.0)),

                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()));

                                  },

                                  child: Center(
                                    child: Text("Register", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.0, fontFamily: 'Hellix')),
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: 30.0,),

                            Container(
                              height: 40.0,
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignInPage()));

                                },

                                child: Center(
                                  child: Text("Sign In", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.0, fontFamily: 'Hellix' )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ))

    );
  }
}

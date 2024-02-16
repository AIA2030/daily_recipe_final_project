import 'package:daily_recipes_final/pages/main_pages/home_page.dart';
import 'package:daily_recipes_final/provider/app_auth.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ForgetPass extends StatefulWidget {
  const ForgetPass({super.key});

  @override
  State<ForgetPass> createState() => _ForgetPassState();
}

class _ForgetPassState extends State<ForgetPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Consumer<AppAuthProvider>(builder: (context, authProvider, _) => Form(
                key: authProvider.formKey ,
                child: Container(
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

                            Center(child: Text("Enter your username, or the email address that you used to register. We'll send you an email with your username and a link to reset your password.", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.normal, color: Colors.grey.shade400, fontFamily: 'Hellix'))),

                            SizedBox(height: 20.0,),

                            TextFormField(
                              style: TextStyle(color: Colors.white),
                              controller: authProvider.emailController,
                              decoration: InputDecoration(
                                label: Row(
                                  children: <Widget>[
                                    Icon(Icons.email_outlined, color: Colors.grey.shade400),
                                    SizedBox(width: 10,),
                                    Text("Email Address", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.0, fontFamily: 'Hellix'),),
                                  ],
                                ),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                              ),

                              validator: (value) {
                                if (value == null || (value?.isEmpty ?? false)) {
                                  return 'Email Is Required';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 40,),

                            Container(
                              height: 50.0,
                              width: 315,
                              color: Colors.transparent,

                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(15.0)),

                                child: InkWell(
                                  onTap: () async {
                                    authProvider.resetPass(context);
                                  },

                                  child: Center(
                                    child: Text("Send", style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal, fontSize: 16.0, fontFamily: 'Hellix')),
                                  ),
                                ),
                              ),
                            ),
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
            ),
            ),
          ],
        ),
      ),
    );



  }
}

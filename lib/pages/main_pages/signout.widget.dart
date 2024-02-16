import 'package:daily_recipes_final/provider/app_auth.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



class SignOutPage extends StatefulWidget {
  const SignOutPage({Key? key}) : super(key: key);


  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage> {

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () async {
      Provider.of<AppAuthProvider>(context, listen: false)
          .signOut(context);
    },

    child: Center(
      child: Text("Sign Out", style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.normal,
          fontSize: 16.0,
          fontFamily: 'Hellix')),
    ),
  );
}

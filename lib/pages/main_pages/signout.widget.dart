import 'package:daily_recipes_final/provider/app_auth.provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';



class SignOutPage extends StatefulWidget {
  const SignOutPage({super.key});

  @override
  State<SignOutPage> createState() => _SignOutPageState();
}

class _SignOutPageState extends State<SignOutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;


  @override
  void initState() {

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    _controller.forward();

    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _showSignOutDialog(context);
    });

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        color: Colors.white,
        child:  AlertDialog(),
      ),
    );

  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.black87,
        title: Center(
          child: Text(
            'Sign Out',
            style: TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              fontFamily: 'Hellix',
            ),
          ),
        ),
        content: Container(
          child: Text(
            'Are you sure you want to sign out?',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 20.0,
              fontFamily: 'Hellix',
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                fontFamily: 'Hellix',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Provider.of<AppAuthProvider>(context, listen: false)
                  .signOut(context);
            },
            child: Text(
              'Sign Out',
              style: TextStyle(
                color: Colors.deepOrange,
                fontWeight: FontWeight.w600,
                fontSize: 16.0,
                fontFamily: 'Hellix',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

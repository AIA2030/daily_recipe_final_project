import 'dart:io';

import 'package:daily_recipes_final/provider/app_auth.provider.dart';
import 'package:daily_recipes_final/widgets/zoom_drawer.widget/zoom_menu.widget.dart';
import 'package:provider/provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';


class SettingPage extends StatefulWidget {
  const SettingPage({Key? key});

  @override
  State<SettingPage> createState() => _SettingPageState();

}

class _SettingPageState extends State<SettingPage> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providrInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appAuthProvider = Provider.of<AppAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: ZoomMenuWidget(),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.notifications_none_outlined, size: 25, color: Colors.black87),
          ),
        ],
      ),
      body: SafeArea(
          child: LayoutBuilder(builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        "Setting",
                        style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.black87, fontFamily: 'Hellix'),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Colors.grey.shade50,
                      clipBehavior: Clip.antiAlias,
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Icon(Icons.language_outlined, color: Colors.black87, size: 20),
                                      SizedBox(width: 5),
                                      Text(
                                        "Language",
                                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: 'Hellix'),
                                      ),
                                    ],
                                  ),
                                  SizedBox(width: 20),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "English",
                                        style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              "Profile",
                              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w600, color: Colors.black87, fontFamily: 'Hellix'),
                            ),
                          ),
                          SizedBox(height: 5),
                          Column(
                            children: [
                              Card(
                                color: Colors.grey.shade50,
                                clipBehavior: Clip.antiAlias,
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
                                                  width: 80,
                                                  height: 80,
                                                  padding: EdgeInsets.all(5),
                                                  child: ClipRRect(
                                                    clipBehavior: Clip.antiAlias,
                                                    borderRadius: BorderRadius.all(Radius.circular(80)),
                                                    child: appAuthProvider.profileImageUrl != null
                                                        ? Image.network(
                                                      appAuthProvider.profileImageUrl!,
                                                      width: 60,
                                                      height: 60,
                                                      fit: BoxFit.cover,
                                                    )
                                                        : Placeholder(child: Image.network('https://cdn.pixabay.com/photo/2016/11/29/05/46/young-woman-1867618_1280.jpg', fit: BoxFit.cover, width: 80, height: 80,),
                                                    ),
                                                  ),
                                                ),


                                              ],
                                            ),
                                            SizedBox(width: 20),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      FilePickerResult? result = await FilePicker.platform.pickFiles();
                                                      if (result != null) {
                                                        File file = File(result.files.single.path!);
                                                        Provider.of<AppAuthProvider>(context, listen: false).uploadProfileImage(file, context);
                                                      }
                                                    },
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              SizedBox(height: 1),

                              Card(
                                color: Colors.grey.shade50,
                                clipBehavior: Clip.antiAlias,
                                child: Padding(
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Icon(Icons.perm_identity_outlined, color: Colors.black87, size: 20),
                                                SizedBox(width: 5),
                                                Text(
                                                  appAuthProvider.userName ?? "Emma Holmes",
                                                  style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: 'Hellix'),
                                                ),
                                              ],
                                            ),
                                            SizedBox(width: 20),
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                Container(
                                                  child: TextButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) => AnimatedContainer(
                                                        duration: Duration(milliseconds: 300),
                                                        child: AlertDialog(
                                                          backgroundColor: Colors.black87,
                                                          title: Center(
                                                            child: Text('Edit User Name',  style: TextStyle(
                                                              color: Colors.deepOrange,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 25.0,
                                                              fontFamily: 'Hellix',
                                                            ),),
                                                          ),
                                                          content: TextField(
                                                            style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.w500,
                                                              fontSize: 20.0,
                                                              fontFamily: 'Hellix',
                                                            ),
                                                            controller: nameController,
                                                            decoration: InputDecoration(
                                                              hintText: 'Enter new user name',
                                                            ),
                                                          ),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text('Cancel', style: TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Hellix',
                                                              ),),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                String newUserName = nameController.text;
                                                                Provider.of<AppAuthProvider>(context, listen: false).setUserName(newUserName);
                                                                Navigator.pop(context);
                                                              },
                                                              child: Text('Save', style: TextStyle(
                                                                color: Colors.deepOrange,
                                                                fontWeight: FontWeight.w600,
                                                                fontSize: 16.0,
                                                                fontFamily: 'Hellix',
                                                              ),),
                                                            ),
                                                          ],
                                                        ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Edit",
                                                      style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.deepOrange, fontFamily: 'Hellix'),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),


                              SizedBox(height: 1),
                              Card(
                                  color: Colors.grey.shade50,
                                  clipBehavior: Clip.antiAlias,
                                  child:Padding(
                                    padding: EdgeInsets.all(15),
                                    child:  Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child:Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,

                                            children:
                                            [
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: [
                                                  Icon(Icons.output_outlined, color: Colors.black87, size: 20,),
                                                  SizedBox(width: 5,),
                                                  Text( "Sign Out", style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: 'Hellix'),),

                                                ],
                                              ),

                                              SizedBox(width: 20,),

                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,

                                                children: [

                                                  Container(
                                                    child: TextButton(onPressed: () async {
                                                      Provider.of<AppAuthProvider>(context, listen: false).signOut(context);
                                                    },
                                                      child: Text("Sign Out", style: TextStyle(fontSize: 14.0,
                                                          fontWeight: FontWeight.w500,
                                                          color: Colors.deepOrange,
                                                          fontFamily: 'Hellix'),),),
                                                  ),

                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                      ],
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );

          })),
    );
  }
}


import 'package:daily_recipes_final/pages/main_pages/setting_page.dart';
import 'package:flutter/material.dart';
import 'package:daily_recipes_final/provider/app_auth.provider.dart';
import 'package:provider/provider.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({super.key});

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  TextEditingController nameController = TextEditingController();
  @override
  void initState() {
    Provider.of<AppAuthProvider>(context, listen: false).providrInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var appAuthProvider = Provider.of<AppAuthProvider>(context);
    return  Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget> [
        Container(
          padding: EdgeInsets.only(top:30.0),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
          child: Center(
            child:  ClipRRect(
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.all(Radius.circular(100)),
              child: appAuthProvider.profileImageUrl != null
                  ? Image.network(
                appAuthProvider.profileImageUrl!,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              )
                  : Placeholder(child: Image.network('https://cdn.pixabay.com/photo/2016/11/29/05/46/young-woman-1867618_1280.jpg', fit: BoxFit.cover, width: 80, height: 80,),
              ),
            ),
          ),
        ),

        SizedBox(width: 20,),

        Container(
          padding: EdgeInsets.only(top:40.0),
          child: Column(
            children: [
              Text( appAuthProvider.userName ?? 'Emma Holmes', style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500, color: Colors.black87, fontFamily: 'Hellix')),

              SizedBox(height: 5,),

              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> SettingPage()));
                },
                child: Text('View Profile', style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w500, color: Colors.grey.shade400, fontFamily: 'Hellix')),

              )


            ],
          ),
        ),
      ],

    );
  }
}
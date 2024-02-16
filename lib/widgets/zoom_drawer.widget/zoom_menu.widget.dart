
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class ZoomMenuWidget extends StatelessWidget {
  const ZoomMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => IconButton(
    onPressed: () => ZoomDrawer.of(context)!.toggle(),
    icon: Icon(Icons.menu_outlined, size: 30, color: Colors.black87,),
  );
}

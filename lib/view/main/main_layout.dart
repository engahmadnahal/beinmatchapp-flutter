import 'package:beinmatch/view/home/home_screen.dart';
import 'package:beinmatch/view/main/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: 
      [
        DrawerCustom(),
        Home(),
      ],
    );
  }
}
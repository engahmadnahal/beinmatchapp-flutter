import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:beinmatch/view/home/dawry/dawry_home.dart';
import 'package:beinmatch/view/home/match/match_home.dart';
import 'package:beinmatch/view/home/news/news_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Home extends StatelessWidget   {
  Home({Key? key}) : super(key: key);


  String? token = SheardHelper.getData('token');
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: Padding(
            padding:
                const EdgeInsets.only(right: 8, top: 8, bottom: 8, left: 0),
            child: Image.asset(
              'assets/imgs/logo.png',
              width: 30,
              height: 30,
            ),
          ),
          title: Text(
            'بين ماتش',
            style: TextStyle(
                color: Color(Config.primaryColor), fontWeight: FontWeight.bold),
          ),
          actions: Components.appBarActions(),
          bottom: TabBar(
            indicatorColor: Color(Config.primaryColor),
            tabs: [
              Tab(
                child: Text(
                  'أخر الأخبار',
                  style: TextStyle(
                    color: Color(Config.primaryColor),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Tab(
                child: Text(
                  'مباريات اليوم',
                  style: TextStyle(
                      color: Color(Config.primaryColor),
                      fontWeight: FontWeight.bold),
                ),
              ),
              Tab(
                child: Text(
                  'الدوريات',
                  style: TextStyle(
                      color: Color(Config.primaryColor),
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            NewsHome(),
            MatchHome(),
            DawryHome(),
          ],
        ),
      ),
    );
  }
}

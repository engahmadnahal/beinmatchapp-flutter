import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/view/home/clubshome/club_home.dart';
import 'package:beinmatch/view/home/match/match_home.dart';
import 'package:beinmatch/view/home/news/news_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatelessWidget   {
  Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // double xOff = -(MediaQuery.of(context).size.width / 3) * 2;
    
    return BlocProvider(
      create: (context) => AppCubit()..getSetting()..getNews()..getClub()..getMatch()..setStatUser(context),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (context,status){},
        builder: (context, status) {
          return DefaultTabController(
          length: 3,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 250),
            transform: Matrix4.translationValues(
              AppCubit.get(context).xOff,
              AppCubit.get(context).yOff,
              AppCubit.get(context).zOff,
            ),
            child: Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: AppCubit.get(context).isOpenDrawer
                  ? IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Color(Config.primaryColor),
                    ),
                    onPressed: () {
                      AppCubit.get(context).openDrawer(context);
                    },
                  )
                  : Padding(
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
                actions: Components.appBarActions(context: context),
                bottom: TabBar(
                  indicatorColor: Color(Config.primaryColor),
                  tabs: [
                    
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
                        'أخر الأخبار',
                        style: TextStyle(
                          color: Color(Config.primaryColor),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'الفرق الرياضية',
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
                  MatchHome(),
                  NewsHome(),
                  ClubHome(),
                ],
              ),
          
              // bottomNavigationBar : BottomNavigationBar(
              //   backgroundColor: Colors.white,
              //   items: [
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.home, color: Color(Config.unActiveColor)),
              //       label: 'الرئيسية',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.notifications,
              //           color: Color(Config.primaryColor)),
              //       label: 'الإشعارات',
              //     ),
              //     BottomNavigationBarItem(
              //       icon: Icon(Icons.account_circle,
              //           color: Color(Config.unActiveColor)),
              //       label: 'حسابي',
              //     ),
              //   ],
              //   currentIndex: 1,
              //   selectedItemColor: Color(Config.primaryColor),
              //   onTap: (index) {
              //     if (index == 2) {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //           builder: (context) => AuthLogin(),
              //         ),
              //       );
              //     }
              //   }
              // ),
            ),
          ),
        );
        },
        
      ),
    );
  }
}

import 'dart:convert';

import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/statemangment/myblocobserver.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/controller/home/main/cubit.dart';
import 'package:beinmatch/controller/home/news/single/cubit.dart';
import 'package:beinmatch/controller/setting/states.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:beinmatch/view/home/clubs/single/loader.dart';
import 'package:beinmatch/view/home/clubs/single/single_club.dart';
import 'package:beinmatch/view/home/home_screen.dart';
import 'package:beinmatch/view/home/match/match_home.dart';
import 'package:beinmatch/view/main/Drawer.dart';
import 'package:beinmatch/view/main/main_layout.dart';
import 'package:beinmatch/view/onbording/onbordingpage.dart';
import 'package:beinmatch/view/video_match/single_match.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'controller/setting/cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.instanc();
  await SheardHelper.init();
  bool? isSkip = SheardHelper.getBool("skipBord");
  String? userInfo = SheardHelper.getData("userInfo");
  Widget screen = OnBordingPage();
  if (isSkip == true || isSkip != null) {
    if (userInfo != null) {
      screen = MainLayout();
    } else {
      screen = AuthLogin();
    }
  } else {
    screen = OnBordingPage();
  }

  /// Change Statues User isOnline or not
  /// Check Setting for api , and store in sheard
  BlocOverrides.runZoned(() {
    runApp(MyApp(screen));
  }, blocObserver: myBlocObserver());
}

class MyApp extends StatelessWidget {
  Widget screen;
  MyApp(this.screen, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    /**
     * This is the root of your application.
     * Status bar color is set to white to make it look like the app is in the background.
     */
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    ));
    return BlocProvider(
      create: (context)=>SettingCubit()..startApp(),
      child: BlocConsumer<SettingCubit,SettingState>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            /**
             * Localizations are a way to make your app support multiple languages.
             * And Change Diraction to RTL to support RTL languages.
             */
            localizationsDelegates: const [
              GlobalCupertinoLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const  [
              Locale('ar', 'AE'),
            ],
            locale: const Locale('ar', 'AE'),
            title: 'Bein Match',
            debugShowCheckedModeBanner: true,
            theme: ThemeData(
                primarySwatch: Colors.blue, fontFamily: Config.primaryFont),
            home: Directionality(
              textDirection: TextDirection.rtl,
              child: screen,
            ),
          );
        },
      ),
    );
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider(create: (context) => AppCubit()..getNews()..getClub()..getMatch()),
    //     // BlocProvider(create: (context) => SingleNewsCubit()),
    //
    //     // BlocProvider(create: (context)=> MainLayoutCubit()..getNews()),
    //   ],
    //   child: BlocConsumer<AppCubit, AppState>(
    //     listener: (context, state) {},
    //     builder: (context, state) {
    //       return MaterialApp(
    //         /**
    //          * Localizations are a way to make your app support multiple languages.
    //          * And Change Diraction to RTL to support RTL languages.
    //          */
    //         localizationsDelegates: const [
    //           GlobalCupertinoLocalizations.delegate,
    //           GlobalMaterialLocalizations.delegate,
    //           GlobalWidgetsLocalizations.delegate,
    //         ],
    //         supportedLocales: const  [
    //           Locale('ar', 'AE'),
    //         ],
    //         locale: const Locale('ar', 'AE'),
    //         title: 'Bein Match',
    //         debugShowCheckedModeBanner: true,
    //         theme: ThemeData(
    //             primarySwatch: Colors.blue, fontFamily: Config.primaryFont),
    //         home: Directionality(
    //           textDirection: TextDirection.rtl,
    //           child: screen,
    //         ),
    //       );
    //
    //     },
    //   ),
    // );
  }
}

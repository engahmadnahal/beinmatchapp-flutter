import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/statemangment/myblocobserver.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/controller/auth/login/cubit.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:beinmatch/view/auth/auth_signup.dart';
import 'package:beinmatch/view/home/test.dart';
import 'package:beinmatch/view/onbording/onbordingpage.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.instanc();
  await SheardHelper.init();
  bool? isSkip = SheardHelper.getBool("skipBord");
  String? token = SheardHelper.getData("token");
  Widget screen = OnBordingPage();

  if (isSkip == true || isSkip != null) {
    if (token != null) {
      screen = Home();
    } else {
      screen = AuthLogin();
    }
  } else {
    screen = OnBordingPage();
  }
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

    return MaterialApp(
      title: 'Bein Match',
      debugShowCheckedModeBanner: true,
      theme:
          ThemeData(primarySwatch: Colors.blue, fontFamily: Config.primaryFont),
      home: Directionality(
        textDirection: TextDirection.rtl,
        child: AuthSignUp(),
      ),
    );
  }
}
import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/statemangment/myblocobserver.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:beinmatch/view/main/main_layout.dart';
import 'package:beinmatch/view/onbording/onbordingpage.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  
  /// Init helper
  DioHelper.instanc();
  await SheardHelper.init();

  /// Variables
  bool? isSkip = SheardHelper.getBool("skipBord");
  String? userInfo = SheardHelper.getData("userInfo");
  Widget screen = OnBordingPage();

  /// Logic
  if (isSkip == true || isSkip != null) {
    if (userInfo != null) {
      screen = MainLayout();
    } else {
      screen = AuthLogin();
    }
  } else {
    screen = OnBordingPage();
  }

  /// Logic
  FirebaseMessaging.instance.getToken().then((value) => print("${value}"));
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
      home: screen,
    );
  }
}



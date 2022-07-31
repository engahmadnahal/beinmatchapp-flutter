import 'package:beinmatch/Helpers/DioHelper.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/statemangment/myblocobserver.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:beinmatch/view/errors/block_screen.dart';
import 'package:beinmatch/view/main/main_layout.dart';
import 'package:beinmatch/view/onbording/onbordingpage.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:overlay_support/overlay_support.dart';
import 'firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
await Firebase.initializeApp();
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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

  /// Logic FCM
  bool? isSaveMobileToken = await SheardHelper.getBool('tokenMobiles');
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  bool isCond = isSaveMobileToken == null || isSaveMobileToken == false;
  // bool isCond = true;
  if(isCond){
    messaging.getToken().then((value) async {
      try{
        await DioHelper.postData(url: 'notification/token-mobile', data: {
          'token' : '$value'
        });
        await SheardHelper.setBool('tokenMobiles', true);
      }catch(e){
        await SheardHelper.setBool('tokenMobiles', false);
      }
    });
  }

   await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((event) {
    showSimpleNotification(
        Text(event.data['v1']),
        subtitle: Text(event.data['v2']),
        duration: Duration(seconds: 3),
        background: Color(Config.primaryColor));

  });

  // FirebaseMessaging.onMessageOpenedApp.listen((event) {
  //
  // });

FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


/// End FCM Logic

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
    return OverlaySupport.global(
      child: MaterialApp(
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue, fontFamily: Config.primaryFont),
        home: screen,
      ),
    );
  }
}



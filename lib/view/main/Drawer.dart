import 'dart:convert';

import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:beinmatch/view/favorite/favorite.dart';
import 'package:beinmatch/view/main/main_layout.dart';
import 'package:beinmatch/view/setting/setting.dart';
import 'package:beinmatch/view/support/support.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/link.dart';

import '../../Helpers/DioHelper.dart';
import '../../Helpers/end_point/api.dart';

class DrawerCustom extends StatefulWidget {
  DrawerCustom({Key? key}) : super(key: key);

  @override
  State<DrawerCustom> createState() => _DrawerCustomState();
}

class _DrawerCustomState extends State<DrawerCustom> {
  List<Map<String, dynamic>> dataDrawer = [
    {'title': "الرئيسية", 'icon': Icons.home,'screen':MainLayout()},
    {'title': "أخر الأخبار", 'icon': Icons.newspaper, 'screen': MainLayout()},
    {'title': "التفضيلات", 'icon': Icons.favorite_border, 'screen': FavoriteScreen()},
    {'title': "الاعدادات", 'icon': Icons.settings_outlined,'screen':SettingScreen()},
    {'title': "خروج", 'icon': Icons.exit_to_app,'screen':AuthLogin()},
    {'title': "فيس بوك", 'icon': Icons.facebook_outlined},
    {'title': "تويتر", 'icon': FontAwesomeIcons.twitter},
    {'title': "يوتيوب", 'icon': FontAwesomeIcons.youtube},
    {'title': "تواصل", 'icon': FontAwesomeIcons.share,'screen':SupportScreen()},

  ];

  Map<String,dynamic>? userInfo;
  late Map<String,dynamic> settingApp;
  @override
  void initState()  {
    // TODO: implement initState
    userInfo = jsonDecode(SheardHelper.getData('userInfo')!);
    settingApp =  jsonDecode(SheardHelper.getData('setting')!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(right: 30, left: 30),

          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                width: MediaQuery.of(context).size.width / 3 * 2,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          Image.asset('assets/imgs/default_avater.png').image,
                      backgroundColor: Color(Config.primaryColor),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Text(
                      '${userInfo?['fname']?? 'user'} ${userInfo?['lname']??'user'}',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Color(Config.primaryColor)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 1,
                      color: Colors.grey[300],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ListView.separated(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: dataDrawer.length,
                        itemBuilder: (context, index) {
                          if(index == 5){
                          // facebook
                            return LinkWidget(settingApp['facebook'],index);
                          }else if(index == 6){
                          // twitter
                            return LinkWidget(settingApp['twitter'],index);
                          }else if(index == 7){
                          // youtube
                            return LinkWidget(settingApp['youtube'],index);
                          }
                          return InkWell(
                            onTap: (){
                              if(index == 4){
                                Future(() async {
                                  await RequstApi.logout(context);
                                });
                              }else{
                                Components.navigator(context: context, screen: dataDrawer[index]['screen']);
                              }
                            },
                            child: Row(
                              children: [
                                Icon(
                                  dataDrawer[index]["icon"],
                                  color: Color(Config.primaryColor),
                                  size: 25,
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  '${dataDrawer[index]["title"]}',
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Color(Config.primaryColor)),
                                )
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          if(index == dataDrawer.length - 5){
                            return Container(
                              margin: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width / 3 * 2,
                              height: 1,
                              color: Colors.grey[300],
                            );
                          }
                          return SizedBox(
                            height: 15,
                          );
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget LinkWidget(String url , int index){
    return Link(
      uri: Uri.parse(url),
      target: LinkTarget.blank,
      builder: (context, followLink) => InkWell(
        onTap: followLink,
        child: Row(
          children: [
            Icon(
              dataDrawer[index]["icon"],
              color: Color(Config.primaryColor),
              size: 25,
            ),
            SizedBox(
              width: 15,
            ),
            Text(
              '${dataDrawer[index]["title"]}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color(Config.primaryColor)),
            )
          ],
        ),
      ),
    );
  }
}

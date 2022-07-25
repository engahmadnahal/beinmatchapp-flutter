import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/view/auth/auth_login.dart';
import 'package:beinmatch/view/favorite/favorite.dart';
import 'package:beinmatch/view/home/clubs/club.dart';
import 'package:beinmatch/view/main/main_layout.dart';
import 'package:beinmatch/view/setting/setting.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DrawerCustom extends StatelessWidget {
  DrawerCustom({Key? key}) : super(key: key);
  List<Map<String, dynamic>> dataDrawer = [
    {'title': "الرئيسية", 'icon': Icons.home,'screen':MainLayout()},
    {'title': "أخر الأخبار", 'icon': Icons.newspaper, 'screen': MainLayout()},
    {'title': "التفضيلات", 'icon': Icons.favorite_border, 'screen': FavoriteScreen()},
    // {'title': "البطولات", 'icon': Icons.sports_soccer_outlined,'screen':Home()},
    // {'title': "الفرق الرياضية", 'icon': Icons.sports_kabaddi_outlined,'screen':ClubScreen()},
    {'title': "الاعدادات", 'icon': Icons.settings_outlined,'screen':SettingScreen()},
    {'title': "خروج", 'icon': Icons.exit_to_app,'screen':AuthLogin()},
    {'title': "فيس بوك", 'icon': Icons.facebook_outlined},
    {'title': "تويتر", 'icon': FontAwesomeIcons.twitter},
    {'title': "يوتيوب", 'icon': FontAwesomeIcons.youtube},
    {'title': "تواصل", 'icon': FontAwesomeIcons.share},
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(right: 30, left: 30),
          color: Colors.white,
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
                      'أحمد عبدالله',
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
                          return InkWell(
                            onTap: (){
                              if(index == 6){
                                SheardHelper.removeData('userInfo');
                                Components.navigator(context: context, screen: dataDrawer[index]['screen']);
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
}

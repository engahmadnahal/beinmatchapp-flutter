import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/setting/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../controller/setting/cubit.dart';
import '../support/support.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> SettingCubit()..startApp(),
      child: BlocConsumer<SettingCubit,SettingState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Color(Config.primaryColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: Components.appBarActions(
                context: context,
                color: Color(Config.primaryColor),
              ),
              title: Text(
                ' الاعدادات',
                style: TextStyle(
                    color: Color(Config.secondaryColor), fontWeight: FontWeight.bold),
              ),
            ),
            body: LiquidPullToRefresh(
              color: Color(Config.primaryColor),
              springAnimationDurationInMilliseconds: 500,
              onRefresh: () {
                return Future(() => SettingCubit.get(context).startApp());
              },
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  padding: EdgeInsets.all(15),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'اعدادات التطبيق',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color(Config.primaryColor)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          'نأسف لعدم دعم تغير الصورة في الوقت الحالي',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Color(Config.secondaryColor)),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: FadeInImage(
                              placeholder: AssetImage(Config.placeholderImage),
                              image: AssetImage('assets/imgs/default_avater.png'),
                            ).image,
                            radius: 60,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${SettingCubit.get(context).userInfo['fname'] +" "+ SettingCubit.get(context).userInfo['lname']}',style:TextStyle(
                            color: Color(Config.primaryColor),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            height: 1,
                            color: Color(Config.unActiveColor),
                          ),

                          SizedBox(
                            height: 10,
                          ),

                          // Column(
                          //   crossAxisAlignment: CrossAxisAlignment.start,
                          //   children: [
                          //     // Row(
                          //     //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //     //   children: [
                          //     //     Text(
                          //     //       'الوضع الليلي',
                          //     //       style: TextStyle(
                          //     //         color: Color(Config.primaryColor),
                          //     //         fontSize: 20,
                          //     //         fontWeight: FontWeight.bold,
                          //     //       ),
                          //     //
                          //     //     ),
                          //     //     InkWell(
                          //     //       onTap: (){
                          //     //         print("Active Dark Mode");
                          //     //       },
                          //     //       child: Container(
                          //     //         padding: EdgeInsets.all(5),
                          //     //         decoration: BoxDecoration(
                          //     //           color: Color(Config.primaryColor),
                          //     //           borderRadius: BorderRadius.circular(5),
                          //     //         ),
                          //     //         child: Text(
                          //     //           'تفعيل',
                          //     //           style: TextStyle(
                          //     //             color: Colors.white,
                          //     //             fontSize: 15,
                          //     //             fontWeight: FontWeight.bold,
                          //     //           ),
                          //     //         ),
                          //     //       ),
                          //     //     ),
                          //     //   ],
                          //     // ),
                          //     // SizedBox(
                          //     //   height: 5,
                          //     // ),
                          //     // Text('عند تفعيل هذا الوضع يتحول التطبيق للوضع الداكن \nللمحافظة على صحة عيناك ننصح بتفعيله ',
                          //     //   style: TextStyle(
                          //     //     fontSize: 15,
                          //     //     color: Colors.grey,
                          //     //   ),),
                          //
                          //
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 25,
                          // ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'مسح التفضيلات',
                                    style: TextStyle(
                                      color: Color(Config.primaryColor),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      SettingCubit.get(context).removeAllFavorite(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color(Config.primaryColor),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'مسح',
                                        style: TextStyle(
                                          color: Color(Config.primaryColor),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'عند الضغط على مسح سيتم مسح جميع تفضيلاتك\nالتي قمت باختيارها من الفرق الرياضية والدوريات ',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),

                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'تواصل معنا',
                                    style: TextStyle(
                                      color: Color(Config.primaryColor),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Components.navigatorReplace(context: context, screen: SupportScreen());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Color(Config.primaryColor),
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text(
                                        'تواصل',
                                        style: TextStyle(
                                          color: Color(Config.primaryColor),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'حادث الدعم الفني عن أي مشكلة قابلتك في تصفح\nالتطبيق او أي ميزة ترغب ان تكون في التطبيق',
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          Container(
                            child: InkWell(
                              onTap: (){
                                SettingCubit.get(context).logOut(context);
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.exit_to_app_outlined,color: Color(Config.primaryColor),),
                                  SizedBox(width: 10,),
                                  Text('تسجيل الخروج',style: TextStyle(
                                      color: Color(Config.primaryColor),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15
                                  ),),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

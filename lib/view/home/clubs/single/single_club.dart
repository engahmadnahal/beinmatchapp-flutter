import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/club/cubit.dart';
import 'package:beinmatch/controller/club/states.dart';
import 'package:beinmatch/controller/home/news/single/cubit.dart';
import 'package:beinmatch/model/club/single_club_model.dart';
import 'package:beinmatch/view/box_message/box_message.dart';
import 'package:beinmatch/view/errors/get_data.dart';
import 'package:beinmatch/view/home/clubs/single/dawry/dawry.dart';
import 'package:beinmatch/view/home/clubs/single/loader.dart';
import 'package:beinmatch/view/home/clubs/single/match/match.dart';
import 'package:beinmatch/view/home/clubs/single/news/news.dart';
import 'package:beinmatch/view/main/Drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../search/search.dart';

class SingleClub extends StatelessWidget {
  int? clubId;
   SingleClub(this.clubId,{Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>ClubCubit()..getSingleClubData(clubId!)..checkFavorite(clubId!),
      child: BlocConsumer<ClubCubit,ClubState>(
        listener: (context,state){},
        builder: (context,state)  {
          if(state is SuccessClubState || ClubCubit.get(context).isSuccess == true){
            SingelClubModel clubData =  ClubCubit.get(context).clubModel!;
            return DefaultTabController(
            length: 3,
            child: Stack(
              children: [
                DrawerCustom(),
                AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  transform: Matrix4.translationValues(
                    ClubCubit.get(context).xOff,
                    ClubCubit.get(context).yOff,
                    ClubCubit.get(context).zOff,
                  ),
                  child: Scaffold(
                    body: NestedScrollView(
                      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                        return [
                          PreferredSize(
                            preferredSize:
                            Size.fromWidth(MediaQuery.of(context).size.width),
                            child: SliverAppBar(
                              expandedHeight: MediaQuery.of(context).size.height / 3 + 30,
                              backgroundColor: Colors.white,
                              elevation: 0,
                              leading: ClubCubit.get(context).isOpenDrawer
                                  ? IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(Config.primaryColor),
                                ),
                                onPressed: () {
                                  ClubCubit.get(context).openDrawer(context);
                                },
                              )
                                  :IconButton(
                                icon: Icon(
                                  Icons.arrow_back_ios,
                                  color: Color(Config.primaryColor),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              actions: [
                                IconButton(
                                  onPressed: () {
                                    Components.navigator(context: context, screen: Search());
                                  },
                                  icon: Icon(Icons.search),
                                  color: Color(Config.primaryColor),
                                ),
                                IconButton(
                                  onPressed: () {
                                    Components.navigator(context: context, screen: BoxMsg());
                                  },
                                  icon: Icon(Icons.notification_add_outlined),
                                  color: Color(Config.primaryColor),
                                ),
                                IconButton(
                                  onPressed: () {
                                    ClubCubit.get(context).openDrawer(context);
                                  },
                                  icon: Icon(Icons.menu),
                                  color: Color(Config.primaryColor),
                                ),
                              ],
                              title: Text(
                                '${clubData.name}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(Config.secondaryColor),
                                  fontSize: 20,
                                ),
                              ),
                              flexibleSpace: Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: IconButton(
                                                onPressed: () {
                                                  ClubCubit.get(context).sendFavorite(context, clubData.id!);
                                                },
                                                icon: Icon(
                                                  ClubCubit.get(context).isFavorite
                                                    ? Icons.favorite_sharp
                                                    : Icons.favorite_outline,
                                                  size: 30,
                                                  color: ClubCubit.get(context).isFavorite
                                                    ? Colors.red
                                                    :Color(Config.primaryColor),
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    backgroundImage: FadeInImage(
                                                      placeholder: AssetImage(Config.placeholderImage),
                                                      image: NetworkImage(
                                                          '${clubData.avater}'),
                                                    ).image,
                                                    radius: 80,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                              bottom: TabBar(
                                tabs: [
                                  Tab(
                                    child: Text(
                                      'الترتيب',
                                      style: TextStyle(
                                          color: Color(Config.primaryColor),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'المباريات',
                                      style: TextStyle(
                                          color: Color(Config.primaryColor),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Tab(
                                    child: Text(
                                      'الأخبار',
                                      style: TextStyle(
                                          color: Color(Config.primaryColor),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ];
                      },
                      body: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            Expanded(
                              child: TabBarView(
                                children: [
                                  DawryClub(clubData),
                                  MatchClub(clubData),
                                  ClubNews(clubData),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        }
          else if(state is ErrorClubState && ClubCubit.get(context).isSuccess == false){
            return ErrorGetData();
          }else{
            return SingleClubLoader();
          }
      },

      ),
    );
  }
}

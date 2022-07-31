import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/model/match/match_model.dart';
import 'package:beinmatch/model/news/news_model.dart';
import 'package:beinmatch/view/home/clubs/single/single_club.dart';
import 'package:beinmatch/view/home/news/news_single.dart';
import 'package:beinmatch/view/video_match/single_match.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../Helpers/convert_time_match.dart';
import '../../../Helpers/mangerads/factory_manger_ads.dart';
import '../../../Helpers/mangerads/interstitial.dart';

class MatchHome extends StatelessWidget {
  MatchHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (context,state){
        return LiquidPullToRefresh(
          color: Color(Config.primaryColor),
          springAnimationDurationInMilliseconds: 500,
          onRefresh: () => Future(() => AppCubit.get(context).getMatch()),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,

              child: Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Color(Config.primaryColor),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Icon(
                                Icons.calendar_month,
                                color: Colors.white,
                                size: 23,
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Text(
                                DateTime.now().toString().substring(0, 10),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      matchList(AppCubit.get(context).matches),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Text(
                          'الفرق الرياضية',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(Config.primaryColor),
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        height: 120,
                        padding: EdgeInsets.all(10),
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: (){
                                  Components.navigator(context: context, screen: SingleClub(AppCubit.get(context).clubs[index].id));
                                },
                                child: Container(
                                  height: 100,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Image.network(
                                          '${AppCubit.get(context).clubs[index].avater}',
                                          width: 60,
                                          height: 60,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        child: Center(
                                          child: Text(
                                            '${AppCubit.get(context).clubs[index].name}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 20,
                              );
                            },
                            itemCount: AppCubit.get(context).clubs.length),
                      ),
                      SizedBox(
                        height: 30,
                      ),

                      if(AppCubit.get(context).matches.isEmpty)
                      Container(
                        width: MediaQuery.of(context).size.width - 20,
                        child: newsList(AppCubit.get(context).getPosts),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }


  Widget matchList(List<MatchModel> matches){
    if(matches.isEmpty){
      return Container(

        child: Center(
          child: Text('يبدو انه لايوجد مباريات لليوم',style: TextStyle(
            color: Color(Config.primaryColor),
            fontSize: 15,
            fontWeight: FontWeight.bold
          ),),
        ),
      );
    }
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            // AdInterstitial adInterstitial = FactoryAds.instanc.createFactoryAd(FactoryAds.INTERSTITIAL_AD) as AdInterstitial;
            // adInterstitial.showInterstitialAd();
            Components.navigator(context: context, screen: SingleMatch(matches[index]));
          },
          child: Components.matchesComponent(
            context: context,
            logo1: matches[index].club_one!.logo,
            logo2: matches[index].club_two!.logo,
            name1: matches[index].club_one!.name,
            name2: matches[index].club_two!.name,
            statusMatch: ConvertTimeMatch.getDate(matches[index].timeStart!),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
    );
  }

  Widget newsList(List<Post> post){
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: post.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Components.navigator(context: context, screen: NewsSingle(
              post: post[index],
            ));
          },
          child: Components.post(
            context: context,
            image: "${post[index].thumnail}",
            title: "${post[index].title}",
            created_at: "${post[index].created_at}",
            tags: "${post[index].dawry!.name}",
          ),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 20,
        );
      },
    );
  }
}

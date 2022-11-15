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

class MatchHome extends StatefulWidget {
  MatchHome({Key? key}) : super(key: key);

  @override
  State<MatchHome> createState() => _MatchHomeState();
}

class _MatchHomeState extends State<MatchHome> {
  int _valueDrop = 1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
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
                      Row(
                        children: [
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
                          Spacer(),
                          DropdownButton<int>(
                            value: _valueDrop,
                            items: [
                              DropdownMenuItem(
                                child: Text('KSA'),
                                value: 1,
                              ),
                              DropdownMenuItem(
                                child: Text('EG'),
                                value: 2,
                              ),
                              DropdownMenuItem(
                                child: Text('MA'),
                                value: 3,
                              ),
                            ],
                            onChanged: ((value) {
                              if (value != null) {
                                setState(() {
                                  _valueDrop = value;
                                  _getMatchByTimeZone(value);
                                });
                              }
                            }),
                          ),
                        ],
                      ),
                     
                      SizedBox(
                        height: 30,
                      ),
                      FutureBuilder(
                        builder: ((context, snapshot) {
                          if (state is LoadingGetMatchState) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Color(Config.primaryColor),
                              ),
                            );
                          }
                          return matchList(AppCubit.get(context).matches);
                        }),
                      ),
                       SizedBox(
                      height: 30,
                    ),
                    FactoryAds.instanc.createFactoryAd(FactoryAds.BANER_AD),
                      SizedBox(
                        height: 30,
                      ),
                      
                      Container(
                        child: Text(
                          'المباراة القادمة',
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
                     
                      nextMatch(),

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
                                onTap: () {
                                  Components.navigator(
                                      context: context,
                                      screen: SingleClub(AppCubit.get(context)
                                          .clubs[index]
                                          .id));
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
                      if (AppCubit.get(context).matches.isEmpty && state is! LoadingGetMatchState)
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

  Widget nextMatch() {
    if(AppCubit.get(context).matches.isEmpty){
      return Container(
        child: Center(
          child: Text(
            'يبدو انه لايوجد مباريات قادمة',
            style: TextStyle(
                color: Color(Config.primaryColor),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
      List<MatchModel> matches = AppCubit.get(context).matches;
      MatchModel match = matches.firstWhere((e) => e.isStart == false);
    return InkWell(
      onTap: (){
        Components.navigator(
                context: context, screen: SingleMatch(match));
      },
      child: Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF07499F),
                Color(0xFF042550),
              ],
            )),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${match.club_one!.name} و ${match.club_two!.name}',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Row(
                              children: [
                                CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: FadeInImage.assetNetwork(
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                                placeholder: Config.placeholderImage,
                                image: '${match.club_one!.logo}',
                              ).image,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'VS',
                              style: TextStyle(
                                  fontSize: 35,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: FadeInImage.assetNetwork(
                                width: 30,
                                height: 30,
                                fit: BoxFit.cover,
                                placeholder: Config.placeholderImage,
                                image: '${match.club_two!.logo}',
                              ).image,
                              radius: 25,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                              ],
                            ),
                          ),
                          
                          Row(
                          children: [
                            Text(
                          '|',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                          ),
                          const SizedBox(
                          width: 10,
                          ),
                          Column(
                          children: [
                            Text(
                              '${match.timeStart!.split(" ")[0]}',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            Text(
                              '${match.timeStart!.split(" ")[1]}',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ],
                          ),
                        
                          ],
                          ),
                          ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ],
                  ),
                ),
              
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Container(
                        height: 80,
                        child: Image.asset(
                          'assets/imgs/logo.png',),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.mic,
                                color: Colors.white,
                                size: 17,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  '${match.voice}',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Expanded(
                        child: Container(
                          child: Row(
                            children: [
                              Icon(
                                Icons.tv,
                                color: Colors.white,
                                size: 17,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Flexible(
                                child: Text(
                                  '${match.channel} ',
                                  overflow: TextOverflow.clip,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 17,
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Icon(
                              Icons.stadium,
                              color: Colors.white,
                              size: 17,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Flexible(
                              child: Text(
                                '${match.stadium} ',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                
          ],
        ),
      ),
    );
  }

  Widget matchList(List<MatchModel> matches) {
    if (matches.isEmpty) {
      return Container(
        child: Center(
          child: Text(
            'يبدو انه لايوجد مباريات لليوم',
            style: TextStyle(
                color: Color(Config.primaryColor),
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: matches.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            AdInterstitial adInterstitial = FactoryAds.instanc.createFactoryAd(FactoryAds.INTERSTITIAL_AD) as AdInterstitial;
            adInterstitial.showInterstitialAd();
            Components.navigator(
                context: context, screen: SingleMatch(matches[index]));
          },
          child: Components.matchesComponent(
            context: context,
            logo1: matches[index].club_one!.logo,
            logo2: matches[index].club_two!.logo,
            name1: matches[index].club_one!.name,
            name2: matches[index].club_two!.name,
            statusMatch: matches[index].timeStart,
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

  void _getMatchByTimeZone(val) {
    AppCubit.get(context).getMatchByTimeZone(val);
  }

  Widget newsList(List<Post> post) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: post.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Components.navigator(
                context: context,
                screen: NewsSingle(
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

import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/home/main/cubit.dart';
import 'package:beinmatch/controller/home/main/stats.dart';
import 'package:beinmatch/controller/home/news/cubit.dart';
import 'package:beinmatch/controller/home/news/stats.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/view/errors/get_data.dart';
import 'package:beinmatch/view/home/news/load_data.dart';
import 'package:beinmatch/view/home/news/news_single.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsHome extends StatelessWidget {
  NewsHome({Key? key}) : super(key: key);

 
  List<Map<String, dynamic>> dawry = [
    {
      "id": 1,
      "dawry_id": "20",
      "name": "ريال مدريد",
      "avater": "https://www.yalla-shoot.com/images/upload/images/0011.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "26",
      "draw": "8",
      "game_over": "4",
      "difference": "49",
      "points": "86"
    },
    {
      "id": 2,
      "dawry_id": "20",
      "name": "برشلونة",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376868119.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "21",
      "draw": "10",
      "game_over": "7",
      "difference": "30",
      "points": "73"
    },
    {
      "id": 11,
      "dawry_id": "20",
      "name": "فالنسيا",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918203.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "11",
      "draw": "15",
      "game_over": "12",
      "difference": "-5",
      "points": "48"
    },
    {
      "id": 68,
      "dawry_id": "20",
      "name": "قادش",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1408045522.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "15",
      "game_over": "15",
      "difference": "-16",
      "points": "39"
    },
    {
      "id": 105,
      "dawry_id": "20",
      "name": "أوساسونا",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918041.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "12",
      "draw": "11",
      "game_over": "15",
      "difference": "-14",
      "points": "47"
    },
    {
      "id": 107,
      "dawry_id": "20",
      "name": "خيتافي",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918076.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "15",
      "game_over": "15",
      "difference": "-8",
      "points": "39"
    },
    {
      "id": 114,
      "dawry_id": "20",
      "name": "ريال بيتيس",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918123.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "19",
      "draw": "8",
      "game_over": "11",
      "difference": "22",
      "points": "65"
    },
    {
      "id": 121,
      "dawry_id": "20",
      "name": "سيلتا فيغو",
      "avater": "https://www.yalla-shoot.com/images/upload/images/98760.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "12",
      "draw": "10",
      "game_over": "16",
      "difference": "0",
      "points": "46"
    },
    {
      "id": 122,
      "dawry_id": "20",
      "name": "غرناطة",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918188.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "14",
      "game_over": "16",
      "difference": "-17",
      "points": "38"
    },
    {
      "id": 128,
      "dawry_id": "20",
      "name": "فياريال",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918216.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "16",
      "draw": "11",
      "game_over": "11",
      "difference": "26",
      "points": "59"
    },
    {
      "id": 130,
      "dawry_id": "20",
      "name": "ليفانتي",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1376918230.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "11",
      "game_over": "19",
      "difference": "-25",
      "points": "35"
    },
    {
      "id": 168,
      "dawry_id": "20",
      "name": "ديبورتيفو ألافيس",
      "avater":
          "https://www.yalla-shoot.com/images/upload/images/1598965308.png",
      "country": "إسبانيا",
      "playing": "38",
      "have_won": "8",
      "draw": "7",
      "game_over": "23",
      "difference": "-34",
      "points": "31"
    }
  ];


  ScrollController _sroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        print(state);
        /**
         *
         * Check if the state is loading
         *
         */
        
        if(state is SuccessNewsState || AppCubit.get(context).posts.isNotEmpty){
          return SingleChildScrollView(
            controller: _sroll,
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),

                  CarouselSlider(
                    items: AppCubit.get(context).getPosts.map((e) {
                      return InkWell(
                        onTap: (){
                          Components.navigator(
                              context: context,
                              screen: NewsSingle(
                                post: e,
                              ));
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.bottomCenter,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width - 20,
                                  height: 300,
                                  clipBehavior: Clip.antiAlias,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Components.customeImage(url: e.thumnail!),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.black38,
                                  ),
                                  width: MediaQuery.of(context).size.width - 20,
                                  height: 300,
                                  clipBehavior: Clip.antiAlias,
                                ),
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 15),
                              width: MediaQuery.of(context).size.width - 30,
                              padding: EdgeInsets.all(10),
                              child: Text(
                                e.title!,
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                    options: CarouselOptions(
                      height: 300,
                      viewportFraction: 1,
                      reverse: true,
                      autoPlay: true,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    height: 120,
                    padding: EdgeInsets.all(10),
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Container(
                            height: 100,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Image.network(
                                    dawry[index]['avater'],
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
                                      dawry[index]['name'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 20,
                          );
                        },
                        itemCount: dawry.length),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    width: MediaQuery.of(context).size.width - 20,
                    child: ListView.separated(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: AppCubit.get(context).getPosts.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            Components.navigator(context: context, screen: NewsSingle(
                              post: AppCubit.get(context).getPosts[index],
                            ));
                          },
                          child: Components.post(
                            context: context,
                            image: "${AppCubit.get(context).getPosts[index].thumnail}",
                            title: "${AppCubit.get(context).getPosts[index].title}",
                            created_at: "${AppCubit.get(context).getPosts[index].created_at}",
                            tags: "${AppCubit.get(context).getPosts[index].dawry!.name}",
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: 20,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  //  TextButton(
                  //   onPressed: () {
                  //     print(_sroll);
                  //   },
                  //   child: Text("جلب المزيد",style: TextStyle(
                  //     color: Color(Config.primaryColor),
                  //     fontWeight: FontWeight.bold
                  //   ),),
                  // ),
                ],
              ),
            ),
          );
        }
        else if(state is ErrorNewsState){
          return ErrorGetData();
        }else if(state is LoadingNewsState && AppCubit.get(context).posts.isEmpty){
         return LoadNews();
        }else{
          return LoadNews();
        }
      },
    );
  }
}

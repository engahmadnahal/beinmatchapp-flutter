import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/home/main/cubit.dart';
import 'package:beinmatch/controller/home/main/stats.dart';
import 'package:beinmatch/controller/home/news/cubit.dart';
import 'package:beinmatch/controller/home/news/stats.dart';
import 'package:beinmatch/main/States.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/model/club/club_model.dart';
import 'package:beinmatch/view/errors/get_data.dart';
import 'package:beinmatch/view/home/news/load_data.dart';
import 'package:beinmatch/view/home/news/news_single.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class NewsHome extends StatelessWidget {
  NewsHome({Key? key}) : super(key: key);
  ScrollController _sroll = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {

        /**
         *
         * Check if the state is loading
         *
         */
        
        if(state is SuccessNewsState || AppCubit.get(context).posts.isNotEmpty){
          return LiquidPullToRefresh(
            color: Color(Config.primaryColor),
            springAnimationDurationInMilliseconds: 500,
            onRefresh: () => Future(() => AppCubit.get(context).getNews()),
            child: SingleChildScrollView(
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

import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/favorite/cubit.dart';
import 'package:beinmatch/controller/favorite/states.dart';
import 'package:beinmatch/model/club/club_model.dart';
import 'package:beinmatch/view/box_message/box_message.dart';
import 'package:beinmatch/view/home/clubs/single/single_club.dart';
import 'package:beinmatch/view/main/Drawer.dart';
import 'package:beinmatch/view/search/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> FavoriteCubit()..getAllClubs(),
      child: BlocConsumer<FavoriteCubit,FavoriteState>(
        listener: (context,state){},
        builder: (context,state){

          return Stack(
            children: [
              DrawerCustom(),
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                transform: Matrix4.translationValues(
                  FavoriteCubit.get(context).xOff,
                  FavoriteCubit.get(context).yOff,
                  FavoriteCubit.get(context).zOff,
                ),
                child: Scaffold(
                  appBar: AppBar(
                    elevation: 0,
                    backgroundColor: Colors.white,
                    leading: FavoriteCubit.get(context).isOpenDrawer
                        ? IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Color(Config.primaryColor),
                      ),
                      onPressed: () {
                        FavoriteCubit.get(context).openDrawer(context);
                      },
                    )
                        :IconButton(
                      color: Color(Config.primaryColor),
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    title: Text(
                      'المفضلة',
                      style: TextStyle(
                        color: Color(Config.secondaryColor),
                        fontWeight: FontWeight.bold,
                      ),
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
                          FavoriteCubit.get(context).openDrawer(context);
                        },
                        icon: Icon(Icons.menu),
                        color: Color(Config.primaryColor),
                      ),
                    ],
                  ),
                  body: Container(
                    color: Colors.white,
                    height: MediaQuery.of(context).size.height,
                    child: LiquidPullToRefresh(
                      color: Color(Config.primaryColor),
                      springAnimationDurationInMilliseconds: 500,
                      onRefresh: () {
                        return Future( () => FavoriteCubit.get(context).getAllClubs());
                      },
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
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
                                  child: Text(
                                    'جميع التفضيلات',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color(Config.primaryColor),
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Builder(
                                  builder: (context){
                                    if(state is SuccessClubFavoriteState || FavoriteCubit.get(context).clubs.length > 0){
                                      return favoritList(context,FavoriteCubit.get(context).clubs);
                                    }
                                    else {
                                      return Center(child: CircularProgressIndicator(color: Color(Config.primaryColor),),);
                                    }

                                  },
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ) ,
                    ),
                  ),
                ),
              ),
            ],
          );

        },
      ),
    );
  }

  Widget favoritList(context,List<ClubModel> clubs){
    if(clubs.isEmpty){
      return Center(
        child: Text('لايوجد تفضيلات !',style: TextStyle(
            color: Color(Config.primaryColor),
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),),
      );
    }
    return ListView.separated(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              Components.navigator(context: context,
                  screen: SingleClub(clubs[index].id));
            },
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage:
                          FadeInImage.assetNetwork(
                            placeholder: Config.placeholderImage,
                            image: "${clubs[index].avater}",
                          ).image,
                          radius: 25,
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Text(
                          "${clubs[index].name}",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () {
                              FavoriteCubit.get(context).sendFavorite(context, FavoriteCubit.get(context).clubs[index].id!);
                            },
                            icon: Icon(
                              Icons.favorite_sharp,
                              color: Color(Config.primaryColor),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: Color(Config.primaryColor),
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 20,
          );
        });
  }



}

import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/search/cubit.dart';
import 'package:beinmatch/controller/search/states.dart';
import 'package:beinmatch/view/home/clubs/single/single_club.dart';
import 'package:beinmatch/view/home/news/news_single.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/club/club_model.dart';
import '../../model/news/news_model.dart';


class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);

  var formKeySearch = GlobalKey<FormState>();
  TextEditingController serchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=>SearchCubit()..startApp(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                color: Color(Config.primaryColor),
                icon: const Icon(Icons.arrow_back_ios),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              title: Form(
                key: formKeySearch,
                child: TextFormField(
                  controller: serchController,
                  validator: (value){
                    if(value!.isEmpty){
                      return "";
                    }
                  },
                  onChanged: (value){
                    if(value.isEmpty){
                      SearchCubit.get(context).getSearch("empty");
                    }
                    if(formKeySearch.currentState!.validate()){
                      SearchCubit.get(context).getSearch(value);
                    }
                  },
                  decoration: InputDecoration(
                    hintText: 'ابحث',
                    hintStyle: const TextStyle(
                      color: Colors.black38,
                    ),
                    suffixIcon : IconButton(
                      onPressed: () {
                        if(formKeySearch.currentState!.validate()){
                          SearchCubit.get(context).getSearch(serchController.value.text);
                        }
                      },
                      icon: Icon(
                        Icons.search,
                        color: Color(Config.primaryColor),
                      ),
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'الفرق الرياضية',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(Config.primaryColor),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Builder(builder: (context){
                      if(state is LoadingSearchState){
                        return Center(child: CircularProgressIndicator(color: Color(Config.primaryColor),),);
                      }
                      return clubList(SearchCubit.get(context).clubs,context);
                    }),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'أخر الأخبار',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(Config.primaryColor),
                          fontSize: 20,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Builder(builder: (context){
                      if(state is LoadingSearchState){
                        return Center(child: CircularProgressIndicator(color: Color(Config.primaryColor),),);
                      }
                      return postList(SearchCubit.get(context).posts,context);
                    }),


                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }


  Widget clubList(List<ClubModel> clubs,context){
    if(clubs.isEmpty){
      return Center(
        child: Text('لايوجد نتائج !',style: TextStyle(
            color: Color(Config.primaryColor),
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),),
      );
    }
    return Container(
      width: MediaQuery.of(context).size.width - 20,
      height: 120,
      padding: EdgeInsets.all(10),
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Components.navigator(context: context, screen: SingleClub(clubs[index].id));
              },
              child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.network(
                        '${clubs[index].avater}',
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
                          '${clubs[index].name}',
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
          itemCount: clubs.length),
    );
  }

  Widget postList(List<Post> posts,context){
    if(posts.isEmpty){
      return Center(
        child: Text('لايوجد نتائج !',style: TextStyle(
            color: Color(Config.primaryColor),
            fontSize: 15,
            fontWeight: FontWeight.bold
        ),),
      );
    }
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: (){
            Components.navigator(context: context, screen: NewsSingle(post: posts[index],));
          },
          child: Components.post(
              context: context,
              image: '${posts[index].thumnail}',
              title: '${posts[index].title}',
              created_at: '${posts[index].created_at}',
              tags: '${posts[index].dawry!.name}'),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15,
        );
      },
    );
  }
}
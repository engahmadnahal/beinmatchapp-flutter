import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/video/cubit.dart';
import 'package:beinmatch/controller/video/states.dart';
import 'package:beinmatch/model/match/match_model.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleMatch extends StatelessWidget {
  MatchModel match;
   SingleMatch(this.match ,{Key? key}) : super(key: key);

  var scafullKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    // match.channel!.channel_url!.urls;
    print("*************************** Urls ******************");
    print(match.channel!.channel_url!.urls![0]);
    print("*************************** Urls ******************");
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ));
    return BlocProvider(

      create: (context) => VideoCubit()
        ..getAllComment(match.id!)
        ..getStatusLikeUser(match.user_like_check!)
        ..getVideo('https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'),
      child: BlocConsumer<VideoCubit,VideoState>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
            key: scafullKey,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  print("Arrow Play Video");
                },
                icon: Icon(
                  Icons.arrow_back_ios,
                  size: 25,
                  color: Color(Config.primaryColor),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    print("Seting Play Video");
                    scafullKey.currentState!.showBottomSheet((context) => customButtomSheet(context));
                  },
                  icon: Icon(
                    Icons.settings,
                    size: 25,
                    color: Color(Config.primaryColor),
                  ),
                ),
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          Builder(builder: (context){
                            if(VideoCubit.get(context).isReady){
                              return Container(
                                color: Colors.black,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 3,
                                child: VideoCubit.get(context).playerWidget,
                              );
                            }
                            return Container(
                              color: Colors.amber,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 3,
                              child: Center(
                                child: Text("Video"),
                              ),
                            );
                          }),

                          // Container(
                          //   color: Colors.amber,
                          //   width: MediaQuery.of(context).size.width,
                          //   height: MediaQuery.of(context).size.height / 3,
                          //   child: Center(
                          //     child: Text("Video"),
                          //   ),
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     IconButton(
                          //       onPressed: () {
                          //         print("Arrow Play Video");
                          //       },
                          //       icon: Icon(
                          //         Icons.arrow_back_ios,
                          //         size: 25,
                          //         color: Color(Config.primaryColor),
                          //       ),
                          //     ),
                          //     IconButton(
                          //       onPressed: () {
                          //         print("Seting Play Video");
                          //         scafullKey.currentState!.showBottomSheet((context) => customButtomSheet(context));
                          //       },
                          //       icon: Icon(
                          //         Icons.settings,
                          //         size: 25,
                          //         color: Color(Config.primaryColor),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        height: MediaQuery.of(context).size.height / 10,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: NetworkImage('https://www.yalla-shoot.com/images/upload/images/1376918123.png'),
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Container(
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.all(4),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    Color(Config.primaryColor),
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      right: 20,
                                                      top: 6,
                                                      bottom: 6,
                                                      left: 20),
                                                  child: Text(
                                                    "فوز",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "30%",
                                                  style: TextStyle(
                                                      color:
                                                      Color(Config.primaryColor)),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    Color(Config.unActiveColor),
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      right: 15,
                                                      top: 6,
                                                      bottom: 6,
                                                      left: 15),
                                                  child: Text(
                                                    "تعادل",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: Color(
                                                            Config.primaryColor),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "40%",
                                                  style: TextStyle(
                                                      color: Colors.green[500]),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Container(
                                                  clipBehavior: Clip.antiAlias,
                                                  decoration: BoxDecoration(
                                                    color:
                                                    Color(Config.unActiveColor),
                                                    borderRadius:
                                                    BorderRadius.circular(25),
                                                  ),
                                                  padding: EdgeInsets.only(
                                                      right: 20,
                                                      top: 6,
                                                      bottom: 6,
                                                      left: 20),
                                                  child: Text(
                                                    textAlign: TextAlign.center,
                                                    "فوز",
                                                    style: TextStyle(
                                                        color: Color(
                                                            Config.primaryColor),
                                                        fontSize: 14,
                                                        fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "30%",
                                                  style: TextStyle(
                                                      color: Color(
                                                          Config.secondaryColor)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundColor: Colors.grey[300],
                                backgroundImage: NetworkImage('https://www.yalla-shoot.com/images/upload/images/98760.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 1,
                        width: MediaQuery.of(context).size.width - 50,
                        color: Colors.grey[400],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("التعليقات",style: TextStyle(
                                color: Color(Config.primaryColor),
                                fontWeight: FontWeight.bold,
                                fontSize: 17
                            ),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    VideoCubit.get(context)
                                        .sendLike(match.id, 1);
                                  },
                                  icon: Icon(
                                    Icons.thumb_up,
                                    color: VideoCubit.get(
                                        context)
                                        .isActive('like') ??
                                        VideoCubit.get(context)
                                            .colorBtn,
                                    size: 30,
                                  ),
                                ),
                                SizedBox(
                                  width: 3,
                                ),
                                IconButton(
                                  onPressed: () {
                                    VideoCubit.get(context)
                                        .sendLike(match.id, 0);
                                  },
                                  icon: Icon(
                                    Icons.thumb_down,
                                    color: VideoCubit.get(
                                        context)
                                        .isActive(
                                        'dislike') ??
                                        VideoCubit.get(
                                            context)
                                            .colorBtn,
                                    size: 30,
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      Container(
                        child: Expanded(
                          flex: 2,
                          child: Container (
                            width: MediaQuery.of(context).size.width - 50,
                            child: commentList(VideoCubit.get(context).commentMatch!,VideoCubit()),
                          ),
                        ),
                      ),
                      Container(
                        child: Expanded(
                          flex : 1,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Form(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  suffixIcon: IconButton( onPressed: (){
                                    print("Send");
                                  },icon: Icon(Icons.send_outlined,color: Color(Config.primaryColor))),
                                  hintText: 'علق الأن',
                                ),
                              ),
                            ),
                          ),
                        ),
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

  Widget customButtomSheet(context){
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Text("Seting"),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Close"),
          ),
        ],
      ),
    );
  }

  Widget commentList(Comments coment,VideoCubit state){

    if(
    state is LoadingSendCommentMatchState ||
        state is LoadingUpdateCommentMatchState ||
        state is LoadingGetCommentMatchState ||
        state is LoadingDeleteCommentMatchState
    ){
      return Center(child: CircularProgressIndicator(color: Color(Config.primaryColor),),);
    }
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: coment.data.length,
      itemBuilder: (context, index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
              child: FadeInImage(
                image: NetworkImage(
                    coment.data[index].user!.avater ?? 'http://app.ahmadnahal.com/assets/img/upload/media/login.png'),
                fit: BoxFit.cover,
                placeholder: AssetImage(
                    'assets/imgs/default_avater.png'),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    Text(
                      "${coment.data[index].user!.name}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    // Text(
                    //   "${coment.data[index].}",
                    //   style: TextStyle(
                    //     fontSize: 11,
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '${coment.data[index].content}',
                    style: TextStyle(
                        fontSize: 15, color: Colors.black)),
              ],
            ),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
    );
  }
}


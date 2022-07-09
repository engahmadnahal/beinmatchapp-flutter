import 'dart:convert';

import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
import 'package:beinmatch/controller/home/news/single/cubit.dart';
import 'package:beinmatch/controller/home/news/single/stats.dart';
import 'package:beinmatch/main/cubit.dart';
import 'package:beinmatch/model/news/news_model.dart';
import 'package:beinmatch/view/box_message/box_message.dart';
import 'package:beinmatch/view/main/Drawer.dart';
import 'package:beinmatch/view/search/search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSingle extends StatelessWidget {
  Post? post;

  NewsSingle({this.post, Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  TextEditingController updateCommentController = TextEditingController();
  Map<String, dynamic> userInfo =
      json.decode(SheardHelper.getData('userInfo')!);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingleNewsCubit()
        ..getStatusLikeUser(post!.isLikes)
        ..getRecommendedPost()..getAllComment(post!.id!),
      child: BlocConsumer<SingleNewsCubit, SingleNewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            children: [
              DrawerCustom(),
              AnimatedContainer(
                duration: Duration(milliseconds: 250),
                transform: Matrix4.translationValues(
                  SingleNewsCubit.get(context).xOff,
                  SingleNewsCubit.get(context).yOff,
                  SingleNewsCubit.get(context).zOff,
                ),
                child: Scaffold(
                  body: NestedScrollView(
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        PreferredSize(
                          preferredSize:
                              Size.fromWidth(MediaQuery.of(context).size.width),
                          child: SliverAppBar(
                            expandedHeight:
                                MediaQuery.of(context).size.height / 3,
                            backgroundColor: Colors.white,
                            elevation: 0,
                            leading: IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                SingleNewsCubit.get(context).isOpenDrawer
                                    ? SingleNewsCubit.get(context)
                                        .openDrawer(context)
                                    : Navigator.pop(context);
                              },
                            ),
                            actions: [
                              IconButton(
                                onPressed: () {
                                  Components.navigator(
                                      context: context, screen: Search());
                                },
                                icon: Icon(Icons.search),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  Components.navigator(
                                      context: context, screen: BoxMsg());
                                },
                                icon: Icon(Icons.notification_add_outlined),
                                color: Colors.white,
                              ),
                              IconButton(
                                onPressed: () {
                                  SingleNewsCubit.get(context)
                                      .openDrawer(context);
                                },
                                icon: Icon(Icons.menu),
                                color: Colors.white,
                              ),
                            ],
                            flexibleSpace: Stack(
                              children: [
                                Container(
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                    height: double.infinity,
                                    placeholder:
                                        AssetImage(Config.placeholderImage),
                                    image: NetworkImage(
                                      '${post!.thumnail}',
                                    ),
                                  ),
                                ),
                                Container(
                                  color: Colors.black26,
                                ),
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              ),
                            ),
                          ),
                        ),
                      ];
                    },
                    body: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(7),
                                child: Text(
                                  '${post!.title}',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(Config.primaryColor),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${post!.created_at}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Text(
                                          '${post!.dawry!.name}',
                                          style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Row(
                                          children: [
                                            // LikeButton(
                                            //   isLiked: false,
                                            //   likeCount: post!.likes,
                                            //   padding:
                                            //       EdgeInsets.only(left: 10, right: 10),
                                            //   likeBuilder: (bool isLiked) {
                                            //     return IconButton(
                                            //       onPressed: () {
                                            //         MainLayoutCubit.get(context)
                                            //             .sendLike(post!.id, true);
                                            //       },
                                            //       icon: Icon(Icons.thumb_up,
                                            //           color:
                                            //               Color(Config.unActiveColor),
                                            //           size: 30),
                                            //     );
                                            //   },
                                            //   countBuilder: (count, cond, text) {
                                            //     return Text(
                                            //       '${count}',
                                            //       style: TextStyle(
                                            //           fontSize: 15,
                                            //           fontWeight: FontWeight.bold,
                                            //           color:
                                            //               Color(Config.primaryColor)),
                                            //     );
                                            //   },
                                            // ),
                                            IconButton(
                                              onPressed: () {
                                                SingleNewsCubit.get(context)
                                                    .sendLike(post!.id, 1);
                                              },
                                              icon: Icon(
                                                Icons.thumb_up,
                                                color: SingleNewsCubit.get(
                                                            context)
                                                        .isActive('like') ??
                                                    SingleNewsCubit.get(context)
                                                        .colorBtn,
                                                size: 30,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            /**
                                             *
                                             * Stop Counter Like And DisLike
                                             * Run This When Sum User Useing App 2k
                                             */
                                            // Text(
                                            //   '${MainLayoutCubit.get(context).countLike ?? post!.likes}',
                                            //   style: TextStyle(
                                            //       fontSize: 15,
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Color(Config.primaryColor)),
                                            // ),
                                          ],
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Row(
                                          children: [
                                            // LikeButton(
                                            //   isLiked: false,
                                            //   likeCount: post!.likes,
                                            //   padding: EdgeInsets.only(left: 10,right: 10),
                                            //   likeBuilder: (bool isLiked) {
                                            //     return IconButton(
                                            //       onPressed: () {
                                            //         MainLayoutCubit.get(context)
                                            //             .sendLike(post!.id, false);
                                            //       },
                                            //       icon: Icon(Icons.thumb_down,
                                            //           color:
                                            //               Color(Config.unActiveColor),
                                            //           size: 30),
                                            //     );
                                            //   },
                                            //   countBuilder: (count, cond, text) {
                                            //     return Text(
                                            //       '${count}',
                                            //       style: TextStyle(
                                            //           fontSize: 15,
                                            //           fontWeight: FontWeight.bold,
                                            //           color:
                                            //               Color(Config.primaryColor)),
                                            //     );
                                            //   },
                                            // ),
                                            IconButton(
                                              onPressed: () {
                                                SingleNewsCubit.get(context)
                                                    .sendLike(post!.id, 0);
                                              },
                                              icon: Icon(Icons.thumb_down,
                                                  color: SingleNewsCubit.get(
                                                              context)
                                                          .isActive(
                                                              'dislike') ??
                                                      SingleNewsCubit.get(
                                                              context)
                                                          .colorBtn,
                                                  size: 30),
                                            ),
                                            SizedBox(
                                              width: 3,
                                            ),
                                            /**
                                             *
                                             * Stop Counter Like And DisLike
                                             * Run This When Sum User Useing App 2k
                                             */
                                            // Text(
                                            //   '${MainLayoutCubit.get(context).countDisLike ?? post!.dislikes}',
                                            //   style: TextStyle(
                                            //       fontSize: 15,
                                            //       fontWeight: FontWeight.bold,
                                            //       color: Color(Config.primaryColor)),
                                            // ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Container(
                                width: double.infinity,
                                child: Text("${post!.body}",
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black)),
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Container(
                                child: Text(
                                  'مقترحة لك',
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color(Config.primaryColor),
                                  ),
                                ),
                              ),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: SingleNewsCubit.get(context)
                                    .getRecomPost
                                    .length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      Components.navigator(
                                        context: context,
                                        screen: NewsSingle(post: SingleNewsCubit.get(context)
                                            .getRecomPost[index],),
                                      );
                                    },
                                    child: Components.post(
                                        context: context,
                                        image:
                                            '${SingleNewsCubit.get(context).getRecomPost[index].thumnail}',
                                        title:
                                            '${SingleNewsCubit.get(context).getRecomPost[index].title}',
                                        created_at:
                                            '${SingleNewsCubit.get(context).getRecomPost[index].created_at}',
                                        tags:
                                            '${SingleNewsCubit.get(context).getRecomPost[index].dawry!.name}'),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(
                                    height: 15,
                                  );
                                },
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Stack(
                                alignment: AlignmentDirectional.centerEnd,
                                children: [
                                  Form(
                                    key: formKey,
                                    child: TextFormField(
                                      controller: comment,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "الرجاء إدخال التعليق";
                                        }
                                      },
                                      style: TextStyle(fontSize: 15),
                                      decoration: InputDecoration(
                                        fillColor: Colors.grey[300],
                                        filled: true,
                                        labelText: 'اكتب تعليقاً',
                                        labelStyle: TextStyle(
                                          fontSize: 15,
                                          color: Colors.grey[600],
                                        ),
                                        // border: OutlineInputBorder(
                                        //   borderRadius: BorderRadius.circular(10),
                                        //   borderSide: BorderSide(
                                        //     width: 0,
                                        //   ),

                                        // ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                    splashRadius: 1,
                                    onPressed: () {
                                      print("Hello Comments");
                                      if (formKey.currentState!.validate()) {
                                        formKey.currentState!.save();
                                        SingleNewsCubit.get(context).sendComment(post!.id!,comment.value.text);
                                      }
                                    },
                                    icon: Icon(
                                      Icons.send,
                                      color: Color(Config.primaryColor),
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              if(SingleNewsCubit.get(context).commentPost != null)
                                commentList(SingleNewsCubit.get(context).commentPost!),
                              SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
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

  Widget commentList(Comment coment){
    print("Comment Count : ${coment.data.length}");
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
                    '${coment.data[index].user!.avater ?? "http://app.ahmadnahal.com/assets/img/upload/media/login.png"}'),
                fit: BoxFit.cover,
                placeholder: AssetImage(
                    'assets/imgs/default_avater.png'),
              ),
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.start,
                  children: [
                    Text(
                      "${coment.data[index].user!.name}",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight:
                          FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "${coment.data[index].created_at}",
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                    '${coment.data[index].content}',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black)),
              ],
            ),
            Spacer(
              flex: 1,
            ),
            if(userInfo['id'] == coment.data[index].user!.id)
              PopupMenuButton(
                  tooltip: 'خصائص',
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                        child: Text('تعديل'),
                        onTap: () {
                          updateCommentBotoomSheet(context,
                              postId: post!.id,
                              commendId: coment.data[index].idComment,
                              commentUser: updateCommentController.value.text
                          );
                        },
                      ),
                      PopupMenuItem(
                        child: Text('حذف'),
                        onTap: (){
                          SingleNewsCubit.get(context).deleteComment(
                            context: context,
                            postId: post!.id,
                            commentId: coment.data[index].idComment
                          );
                        },
                      ),
                    ];
                  }),
          ],
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 15,
        );
      },
    );
  }
  Future<String> isLikedPost() async {
    String? userInfo = await SheardHelper.getData('userInfo');
    Map<String, dynamic> userData = json.decode(userInfo!);

    return userInfo;
  }

  void updateCommentBotoomSheet(context,{
    required postId,
    required commendId,
    required commentUser
  }) {
    Scaffold.of(context).showBottomSheet(
      (context) => Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.2),
                offset: Offset(0, 0.4),
                blurRadius: 25,
                spreadRadius: 25,
              )
            ],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25))),
        height: MediaQuery.of(context).size.height / 3 + 80,
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.all(25),
          child: Column(
            children: [
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 20),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(25)),
                  width: MediaQuery.of(context).size.width / 9,
                  height: 5,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "تعديل التعليق",
                    style: TextStyle(
                        color: Color(Config.secondaryColor),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Container(
                child: Form(
                  child: TextFormField(
                    controller: updateCommentController,
                    decoration: InputDecoration(
                      label: Text('تحديث التعليق'),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  child: Components.textButton(
                      text: 'تحديث',
                      onPressed: () async {
                         SingleNewsCubit.get(context).updateComment(postId,commendId,commentUser);
                         Scaffold.of(context).showBottomSheet((context) => Container(height: 0,width: 0,));
                      }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

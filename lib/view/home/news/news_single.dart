import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/controller/home/news/cubit.dart';
import 'package:beinmatch/controller/home/news/single/cubit.dart';
import 'package:beinmatch/controller/home/news/single/stats.dart';
import 'package:beinmatch/controller/home/news/stats.dart';
import 'package:beinmatch/model/news/news_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

class NewsSingle extends StatelessWidget {
  Post? post;
  NewsSingle({this.post, Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  TextEditingController comment = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SingleNewsCubit()..getStatusLikeUser(post!.id),
      child: BlocConsumer<SingleNewsCubit, SingleNewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          // NewsCubit.get(context).getStatusLikeUser(post!.id);
          return Scaffold(
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  PreferredSize(
                    preferredSize:
                        Size.fromWidth(MediaQuery.of(context).size.width),
                    child: SliverAppBar(
                      expandedHeight: MediaQuery.of(context).size.height / 3,
                      backgroundColor: Colors.white,
                      elevation: 0,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      actions: Components.appBarActions(
                        color: Colors.white,
                      ),
                      flexibleSpace: Stack(
                        children: [
                          Container(
                            child: FadeInImage(
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              placeholder: AssetImage(Config.placeholderImage),
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
                                      //         NewsCubit.get(context)
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
                                              .sendLike(post!.id, true);
                                        },
                                        icon: Icon(
                                          Icons.thumb_up,
                                          color: SingleNewsCubit.get(context).isActive('like')?? SingleNewsCubit.get(context).colorBtn,
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
                                      //   '${SingleNewsCubit.get(context).countLike ?? post!.likes}',
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
                                      //         NewsCubit.get(context)
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
                                              .sendLike(post!.id, false);
                                        },
                                        icon: Icon(Icons.thumb_down,
                                            color: SingleNewsCubit.get(context)
                                                    .isActive('dislike') ??
                                                SingleNewsCubit.get(context)
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
                                      //   '${SingleNewsCubit.get(context).countDisLike ?? post!.dislikes}',
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
                              style:
                                  TextStyle(fontSize: 18, color: Colors.black)),
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
                        SizedBox(
                          height: 10,
                        ),
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return Components.post(
                                context: context,
                                image: '${post!.thumnail}',
                                title: '${post!.title}',
                                created_at: '${post!.created_at}',
                                tags: '${post!.dawry!.name}');
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
                        ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: post!.comments!.data.length,
                          itemBuilder: (context, index) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  radius: 30,
                                  child: FadeInImage(
                                    image: NetworkImage(
                                        '${post!.comments!.data[index].user!.avater ?? "http://app.ahmadnahal.com/assets/img/upload/media/login.png"}'),
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
                                          "${post!.comments!.data[index].user!.name}",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "${post!.comments!.data[index].created_at}",
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
                                        '${post!.comments!.data[index].content}',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black)),
                                  ],
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (context, index) {
                            return SizedBox(
                              height: 15,
                            );
                          },
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
      ),
    );
  }
}

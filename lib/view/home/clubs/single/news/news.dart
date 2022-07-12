import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:beinmatch/view/home/news/news_single.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class ClubNews extends StatelessWidget {
   ClubNews({Key? key}) : super(key: key);
  List<Map<String,dynamic>> posts = [
        {
            "id": 4,
            "title": "مفاجأة.. سبورتينج لشبونة يريد إعادة رونالدو",
            "thumnail": "http://app.ahmadnahal.com/storage/upload/1656272180.jpg",
            "body": "قال تقرير صحفي بريطاني، إن نادي سبورتينج لشبونة يرغب في التعاقد مع النجم البرتغالي كريستيانو رونالدو، خلال سوق الإنتقالات هذا الصيف.\r\n\r\n\r\nووفقاً للمعلومات الواردة من صحيفة \" صن سورت \" البريطانية، فإن سبورتينج لشبونة يرى بأن يستطيع إقناع كريستيانو رونالدو بالعودة إليهم.\r\n\r\n\r\nوكانت العديد من التقارير قد أكدت بأن رونالدو يفكر في الرحيل عن الشياطين الحمر، لأنه غير مقتنع بعمل الفريق في سوق الإنتقالات.\r\n\r\n\r\nوارتبط الدون بالعديد من الأندية أبرزها تشيلسي وبايرن ميونيخ وروما.",
            "created_at": "منذ 4 أيام",
            "employee": {
                "id": 1,
                "name": "Admin Admin"
            },
            "clubshome": {
                "id": 2,
                "name": "دوري أبطال أوروبا"
            },
            "likes": 0,
            "dislikes": 2,
            "views": 0,
            "comments": {
                "count": 0,
                "data": []
            }
        },
        {
            "id": 3,
            "title": "تشاكا مطلوب في ألمانيا",
            "thumnail": "http://app.ahmadnahal.com/storage/upload/1655105561.jpg",
            "body": "قال تقرير إعلامي إسباني، إن لاعب خط وسط فريق آرسنال الدولي السويسري جرانيت تشاكا، مطلوب في الدوري الألماني هذا الصيف.\r\n\r\n\r\nووفقاً للمعلومات الواردة من شبكة \"fichajes net\"، فإن باير ليفركوزن يستعد للتعاقد مع تشاكا على سبيل الإعارة مع خيار الإنتقال الدائم.\r\n\r\n\r\nويملك تشاكا عقداً مع النادي الإنجليزي يمتد حتى صيف عام 2024، وغير معروف ما إذا كان اللاعب سيوافق على الإنضمام الى ليفركوزن أم لا.\r\n\r\n\r\nتشاكا صاحب الـ29 عاماً، خاض مع آرسنال 250 مباراة بكل المسابقات وسجل 14 هدفاً وصنع 22.",
            "created_at": "منذ أسبوعين",
            "employee": {
                "id": 1,
                "name": "Admin Admin"
            },
            "clubshome": {
                "id": 2,
                "name": "دوري أبطال أوروبا"
            },
            "likes": 3,
            "dislikes": 0,
            "views": 1,
            "comments": {
                "count": 3,
                "data": [
                    {
                        "id": 1,
                        "content": "خبر كاذب وعاري عن الصحة",
                        "created_at": "منذ أسبوعين",
                        "user": {
                            "id": 2,
                            "fname": "Ahmad",
                            "lname": "Nahal",
                            "username": "AhmadNahal",
                            "avater": null,
                            "email": "ahmad@nahal.com",
                            "os_mobile": null,
                            "ip_address": null,
                            "is_online": "0",
                            "status": "active",
                            "created_at": "2022/06/13",
                            "updated_at": "2022/06/27"
                        }
                    },
                    {
                        "id": 2,
                        "content": "ليذهب لالمانيا لانحتاجه",
                        "created_at": "منذ أسبوعين",
                        "user": {
                            "id": 2,
                            "fname": "Ahmad",
                            "lname": "Nahal",
                            "username": "AhmadNahal",
                            "avater": null,
                            "email": "ahmad@nahal.com",
                            "os_mobile": null,
                            "ip_address": null,
                            "is_online": "0",
                            "status": "active",
                            "created_at": "2022/06/13",
                            "updated_at": "2022/06/27"
                        }
                    },
                    {
                        "id": 4,
                        "content": "لا اوافق على هذا التقرير غير صحيح ابداً",
                        "created_at": "منذ 3 أيام",
                        "user": {
                            "id": 16,
                            "fname": "amena",
                            "lname": "nahal",
                            "username": "amenanahal_30",
                            "avater": null,
                            "email": "amenanahal1@gmail.com",
                            "os_mobile": null,
                            "ip_address": null,
                            "is_online": "0",
                            "status": "active",
                            "created_at": "2022/06/27",
                            "updated_at": "2022/06/27"
                        }
                    }
                ]
            }
        },
        {
            "id": 2,
            "title": "بوسكيتس يحدد موعد رحيله عن برشلونة",
            "thumnail": "http://app.ahmadnahal.com/storage/upload/1655105513.jpeg",
            "body": "حدد النجم الإسباني المخضرم (سيرجيو بوسكيتس) موعد رحيله عن نادي برشلونة، الذي يلعب لفريقه الأول منذ عام 2008.\r\n\r\n\r\nوحسب صحيفة (موندو ديبورتيفو) فإن بوسكيتس صاحب الـ 33 عاماً، سيرحل عن البارسا، مع نهاية عقده، في الصيف القادم.\r\n\r\n \r\n\r\n\r\n\r\nوذلك حتى لو حاول النادي الكاتالوني توقيع عقد جديد معه، حيث يرغب اللاعب في التغيير، بعد مشوار حافل مع البلاوجرانا.\r\n\r\n \r\n\r\n\r\n\r\nوتجدر الإشارة إلى أن بوسكيتس لا زال يعتبر واحد من أهم الركائز الأساسية في برشلونة، وهو قائد الفريق.",
            "created_at": "منذ أسبوعين",
            "employee": {
                "id": 1,
                "name": "Admin Admin"
            },
            "clubshome": {
                "id": 20,
                "name": "الدوري الإسباني"
            },
            "likes": 0,
            "dislikes": 0,
            "views": 1,
            "comments": {
                "count": 1,
                "data": [
                    {
                        "id": 3,
                        "content": "لا اوافق على هذا التقرير غير صحيح ابداً",
                        "created_at": "منذ 3 أيام",
                        "user": {
                            "id": 16,
                            "fname": "amena",
                            "lname": "nahal",
                            "username": "amenanahal_30",
                            "avater": null,
                            "email": "amenanahal1@gmail.com",
                            "os_mobile": null,
                            "ip_address": null,
                            "is_online": "0",
                            "status": "active",
                            "created_at": "2022/06/27",
                            "updated_at": "2022/06/27"
                        }
                    }
                ]
            }
        },
        {
            "id": 1,
            "title": "رسمياً.. بنفيكا يعلن رحيل نونيز الى ليفربول",
            "thumnail": "http://app.ahmadnahal.com/storage/upload/1655105455.jpg",
            "body": "أعلن نادي بنفيكا البرتغالي، في بيان رسمي، صباح اليوم الإثنين، عن توصله لإتفاق على انتقال المهاجم الأوروجواياني داروين نونيز الى ليفربول.\r\n\r\n\r\nوقال النادي:\" توصل نادي بنفيكا إلى اتفاق مع نادي ليفربول لبيع داروين نونيز بمبلغ 75 مليون يورو، ويمكن أن تصل الصفقة الى 100 مليون يورو وفقاً للمتغيرات\".\r\n\r\n\r\nوأضاف النادي:\" الاتفاقية المذكورة تعتمد على توقيع عقد العمل الرياضي للاعب مع نادي ليفربول\" .\r\n\r\n\r\nنونيز صاحب الـ22 عاماً، لعب مع بنفيكا 84 مباراة بكل المسابقات وسجل 47 هدفاً وصنع 16، وسيوقع على عقد لمدة 6 سنوات مع الريدز.",
            "created_at": "منذ أسبوعين",
            "employee": {
                "id": 1,
                "name": "Admin Admin"
            },
            "clubshome": {
                "id": 2,
                "name": "دوري أبطال أوروبا"
            },
            "likes": 1,
            "dislikes": 0,
            "views": 0,
            "comments": {
                "count": 0,
                "data": []
            }
        }
    ];
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width - 20,
              child: LiquidPullToRefresh(
                color: Color(Config.primaryColor),
                springAnimationDurationInMilliseconds: 500,
                onRefresh: () {
                  return Future.delayed(
                      Duration(seconds: 2), () => print("Hello"));
                },
                child: ListView.separated(
                  physics: BouncingScrollPhysics(),
              
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        // Components.navigator(
                        //     context: context,
                        //     screen: NewsSingle(
                        //       post: NewsCubit.get(context).getPosts[index],
                        //     ));
                      },
                      child: Components.post(
                        context: context,
                        image:
                            "${posts[index]['thumnail']}",
                        title: "${posts[index]["title"]}",
                        created_at:
                            "${posts[index]["created_at"]}",
                        tags:
                            "${posts[index]["clubshome"]["name"]}",
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
    );
  }
}
import 'package:beinmatch/Helpers/components/components.dart';
import 'package:beinmatch/Helpers/config.dart';
import 'package:flutter/material.dart';


class Search extends StatelessWidget {
  Search({Key? key}) : super(key: key);
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
            "likes": 1,
            "dislikes": 1,
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
                        "created_at": "منذ يومين",
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Color(Config.primaryColor),
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: TextFormField(
          decoration: InputDecoration(
            hintText: 'ابحث',
            hintStyle: TextStyle(
              color: Colors.black38,
            ),
            suffixIcon : IconButton(
              onPressed: () {
                
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
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
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
              SizedBox(
                height: 20,
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return Components.post(
                      context: context,
                      image: '${posts[index]["thumnail"]}',
                      title: '${posts[index]["title"]}',
                      created_at: '${posts[index]["created_at"]}',
                      tags: '${posts[index]["clubshome"]["name"]}');
                },
                separatorBuilder: (context, index) {
                  return SizedBox(
                    height: 15,
                  );
                },
              ),
                        

            ],
          ),
        ),
      ),
    );
  }
}
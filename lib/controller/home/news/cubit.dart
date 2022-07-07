// import 'package:beinmatch/Helpers/DioHelper.dart';
// import 'package:beinmatch/Helpers/components/components.dart';
// import 'package:beinmatch/Helpers/config.dart';
// import 'package:beinmatch/Helpers/sheard_prefrancess.dart';
// import 'package:beinmatch/controller/home/news/stats.dart';
// import 'package:beinmatch/model/news/news_model.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class NewsCubit extends Cubit<NewsState> {
//   NewsCubit() : super(InitNewsState());
//   static NewsCubit get(context) => BlocProvider.of(context);
//   List<Post> posts = [];

//   List<Post> get getPosts {
//     return this.posts;
//   }


//   /**
//    * Number of trying get data in api
//    */
//   int counterErrorGetNews = 0;

//   void getNews() async {
//     counterErrorGetNews++;
//     emit(LoadingNewsState());
//     try {
//       var response = await DioHelper.getData(url: 'posts');
//       response!.data['data'].forEach((e) => {
//             posts.add(Post.fromJson(e)),
//             print("Data Var posts is  : ${posts.length}")
//           });
//       emit(SuccessNewsState());
//     } catch (e) {
//       print(e.toString());

//       if (counterErrorGetNews < 3) {
//         getNews();
//       } else {
//         emit(ErrorNewsState());
//       }
//       // getNews();
//     }
//   }


// }

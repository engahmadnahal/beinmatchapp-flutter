/// This Model is beta and not ready for use.
import 'package:beinmatch/model/match/match_model.dart';
import 'package:beinmatch/model/news/news_model.dart';

class SingelClubModel {
  int? id;
  String? name;
  String? avater;
  String? country;
  int? playing;
  int? have_won;
  int? draw;
  int? game_over;
  int? difference;
  int? points;
  List<SingelClubModel>? clubs;
  List<MatchModel>? matches;
  List<Post>? posts;

  SingelClubModel(
      {this.id,
      this.name,
      this.avater,
      this.country,
      this.playing,
      this.have_won,
      this.draw,
      this.game_over,
      this.difference,
      this.points,
      this.clubs,
      this.matches,
      this.posts
      });

  SingelClubModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    avater = json['avater'];
    country = json['country'];
    playing = json['playing'];
    have_won = json['have_won'];
    draw = json['draw'];
    game_over = json['game_over'];
    difference = json['difference'];
    points = json['points'];
    if(json['clubs'] != null){
      clubs = (json['clubs'] as List)
        .map((i) => SingelClubModel.fromJson(i))
        .toList();
    }
    if(json['matches'] != null){
      matches = (json['matches'] as List)
        .map((i) => MatchModel.fromJson(i))
        .toList();
    }
    if(json['posts'] != null){
      posts = (json['posts'] as List)
        .map((i) => Post.fromJson(i))
        .toList();
    }
  }
}

// class PostClubModel {
//   int? id;
//   String? employee_id;
//   String? dawry_id;
//   String? title;
//   String? thumnail;
//   String? content;
//   String? status;
//   String? created_at;
//   String? updated_at;

//   PostClubModel(
//       {this.id,
//       this.employee_id,
//       this.dawry_id,
//       this.title,
//       this.thumnail,
//       this.content,
//       this.status,
//       this.created_at,
//       this.updated_at,
// });
//   factory PostClubModel.fromJson(Map<String, dynamic> json) => PostClubModel(
//     id: json['id'],
//     employee_id: json['employee_id'],
//     dawry_id: json['dawry_id'],
//     title: json['title'],
//     thumnail: json['thumnail'],
//     content: json['content'],
//     status: json['status'],
//     created_at: json['created_at'],
//     updated_at: json['updated_at'],
//   );
// }

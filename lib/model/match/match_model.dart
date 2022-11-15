class MatchModel{
  int? id;
  int? botola;
  bool? isStart;
  String? timeStart;
  String? voice;
  String? stadium;
  int? likes;
  int? dislikes;
  int? poll_to_club_one;
  int? poll_to_darw;
  int? poll_to_club_two;
  int? user_like_check;
  int? poll_user_check;
  Club? club_one;
  Club? club_two;
  Dawry? dawry;
  Channel? channel;
  // Comments? comments;
  MatchModel({this.stadium,this.voice,this.isStart,this.id, this.botola, this.timeStart, this.likes, this.dislikes, this.poll_to_club_one, this.poll_to_darw, this.poll_to_club_two, this.user_like_check, this.poll_user_check, this.club_one, this.club_two, this.dawry, this.channel,
    // this.comments
  });
  factory MatchModel.fromJson(Map<String, dynamic> json){

    return MatchModel(
      id: json['id'],
      botola: json['botola'],
      isStart: json['isStart'],
      voice: json['voice'],
      stadium: json['stadium'],
      timeStart: json['timeStart'],
      likes: json['likes'],
      dislikes: json['dislikes'],
      poll_to_club_one: json['poll_to_club_one'],
      poll_to_darw: json['poll_to_darw'],
      poll_to_club_two: json['poll_to_club_two'],
      user_like_check: json['user_like_check'],
      poll_user_check: json['poll_user_check'],
      club_one: Club.fromJson(json['club_one']),
      club_two: Club.fromJson(json['club_two']),
      dawry: Dawry.fromJson(json['dawry']),
      channel: Channel.fromJson(json['channel']),
      // comments: Comments.fromJson(json['comments']),
    );
  }



}
class Club{
  int? id;
  String? name;
  String? logo;
  Club({this.id, this.name, this.logo});
  factory Club.fromJson(Map<String, dynamic> json){
    return Club(
      id: json['id'],
      name: json['name'],
      logo: json['logo'],
    );
  }
}
class Dawry{
  int? id;
  String? name;
  String? avater;
  Dawry({this.id, this.name, this.avater});
  factory Dawry.fromJson(Map<String, dynamic> json){
    return Dawry(
      id: json['id'],
      name: json['name'],
      avater: json['avater'],
    );
  }
}
class Channel{
  int? id;
  String? channel_name;
  ChannelUrl? channel_url;
  Channel({this.id, this.channel_name, this.channel_url});
  factory Channel.fromJson(Map<String, dynamic> json){
    return Channel(
      id: json['id'],
      channel_name: json['channel_name'],
      channel_url: ChannelUrl.fromJson(json['channel_url']),
    );
  }
}
class ChannelUrl{
  // String? urls1;
  // String? urls2;
  // String? urls3;
  List<String>? urls = [];
  ChannelUrl({
    // this.urls1,
    // this.urls2,
    // this.urls3,
    this.urls
});
   ChannelUrl.fromJson(Map<String, dynamic> json) {
     urls!.add(json['one']);
     urls!.add(json['two']);
     urls!.add(json['three']);
    }
}
// class Comments{
//   int? count;
//   List<Comments>? data;
//   Comments({this.count, this.data});
//   factory Comments.fromJson(Map<String, dynamic> json){
//     return Comments(
//       count: json['count'],
//       data: List<Comments>.from(json['data'].map((x) => Comments.fromJson(x))),
//     );
//   }
// }

class Comments{
  // int? count;
  int? idComment;
  String? content;
  User? user;
  // String? created_at;

  List<Comments> data = [];
  Comments({
    this.idComment,
    this.content,
    this.user,
    // this.created_at
  });

  Comments.fromJson(Map<String, dynamic> json) {
    if (json['data'].isNotEmpty) {
      json['data'].forEach((element) {
        data.add(Comments(
            idComment: element['id'],
            content: element['comment'],
            user: User.fromJson(element['user']),
            // created_at: element['created_at']
        ));
      });
    }
  }
}

class User {
  int? id;
  String? name;
  String? avater;
  // String? created_at;
  User({
    this.id,
    this.name,
    this.avater,
    // this.created_at
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["fname"] + " " + json["lname"],
    avater: json["avater"],
    // created_at : json["created_at"]
  );
}




class Post{
  int? id;
  String? title;
  String? thumnail;
  String? body;
  String? created_at;
  Employee? employee;
  Dawry? dawry;
  int? likes;
  int? dislikes;
  int? views;
  Comment? comments;
  Like Likes;
  Post({
   required this.id,
   required this.title,
   required this.thumnail,
   required this.body,
   required this.created_at,
   required this.employee,
   required this.dawry,
   required this.likes,
   required this.dislikes,
   required this.views,
   required this.comments,
    required this.Likes
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      thumnail: json['thumnail'],
      body: json['body'],
      created_at: json['created_at'],
      employee: Employee.fromJson(json['employee']),
      dawry: Dawry.fromJson(json['dawry']),
      likes: json['likes'],
      dislikes: json['dislikes'],
      views: json['views'],
      comments: Comment.fromJson(json['comments']),
      Likes : Like.fromJson(json['user_likes'])
    );
  }
}

class Employee{
  int? id;
  String? name;
  Employee({
    this.id,
    this.name
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
    id: json["id"],
    name: json["name"],
  );
}

class Dawry{
  int? id;
  String? name;
  Dawry({
    this.id,
    this.name
  });

  factory Dawry.fromJson(Map<String, dynamic> json) => Dawry(
    id: json["id"],
    name: json["name"],
  );
}

class Comment{
  int? count;
  int? idComment;
  String? content;
  User? user;
  String? created_at;

  // List<Map<String, dynamic>> dataJson = [];
  List<Comment> data = [];
  Comment({
    this.idComment,
    this.content,
    this.user,
    this.created_at
  });

   Comment.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    if (!json['data'].isEmpty) {
      json['data'].forEach((element) {
        data.add(Comment(
          idComment: element['id'],
          content: element['content'],
          user: User.fromJson(element['user']),
          created_at: element['created_at']
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

class Like {
  late int user_id;
  late bool isLike;
  List<Like> likes = [];

  Like({
     required this.user_id,
      required this.isLike
  });
  /// Reseved A List Of Map
  Like.fromJson(List<dynamic> json){
    /// For loop in all List and init instanc variable
    if(json.isNotEmpty){
      json.forEach((element) {
        likes.add(Like(
            user_id : element['user_id'],
            isLike : element['is_like']
        ));
      });
    }
  }
}
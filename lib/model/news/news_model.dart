
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
  Post({
    this.id,
    this.title,
    this.thumnail,
    this.body,
    this.created_at,
    this.employee,
    this.dawry,
    this.likes,
    this.dislikes,
    this.views,
    this.comments
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
      comments: Comment.fromJson(json['comments'])
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
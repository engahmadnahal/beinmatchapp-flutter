class NotifictionModel {
  int? count_unread;
  String? title;
  String? content;
  List<NotifictionModel> data = [];

  NotifictionModel({this.title, this.content});

   NotifictionModel.formJson(Map<String,dynamic> json){
     this.count_unread = json['count_unread'];
     json['notifications'].forEach((e){
        data.add(NotifictionModel(
          title: e['title'],
          content: e['content'],
        ));
     });

  }
}
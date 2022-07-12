class ClubModel {
  int? id;
  String? name;
  String? avater;
  ClubModel(
      {this.id,
        this.name,
        this.avater,
      });

  factory ClubModel.fromJson(Map<String, dynamic> json) => ClubModel(
      id : json['id'],
      name : json['name'],
      avater : json['avater'],
  );
}
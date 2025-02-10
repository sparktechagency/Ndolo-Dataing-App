class IdealMatchModel {
  final String? title;
  final String? subTitle;
  final String? icon;
  final bool? isDeleted;
  final DateTime? createdAt;
  final String? id;

  IdealMatchModel({
    this.title,
    this.subTitle,
    this.icon,
    this.isDeleted,
    this.createdAt,
    this.id,
  });

  factory IdealMatchModel.fromJson(Map<String, dynamic> json) => IdealMatchModel(
    title: json["title"],
    subTitle: json["subTitle"],
    icon: json["icon"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "subTitle": subTitle,
    "icon": icon,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

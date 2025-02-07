class InterestsModel {
  final String? name;
  final String? icon;
  final bool? isDeleted;
  final DateTime? createdAt;
  final String? id;

  InterestsModel({
    this.name,
    this.icon,
    this.isDeleted,
    this.createdAt,
    this.id,
  });

  factory InterestsModel.fromJson(Map<String, dynamic> json) => InterestsModel(
    name: json["name"],
    icon: json["icon"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "icon": icon,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

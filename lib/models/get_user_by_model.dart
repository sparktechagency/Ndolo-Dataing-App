class GetUserByIdModel {
  final String? fullName;
  final String? email;
  final String? image;
  final String? id;

  GetUserByIdModel({
    this.fullName,
    this.email,
    this.image,
    this.id,
  });

  factory GetUserByIdModel.fromJson(Map<String, dynamic> json) => GetUserByIdModel(
    fullName: json["fullName"],
    email: json["email"],
    image: json["image"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "email": email,
    "image": image,
    "id": id,
  };
}

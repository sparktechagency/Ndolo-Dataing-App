class HomeUserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? coverImage;
  final List<String>? gallery;
  final String? gender;
  final String? role;
  final DateTime? dateOfBirth;
  final dynamic country;
  final dynamic state;
  final dynamic city;
  final List<String>? interests;
  final List<dynamic>? lickList;
  final dynamic idealMatch;
  final List<dynamic>? language;
  final String? address;
  final Location? location;
  final String? bio;
  final dynamic oneTimeCode;
  final bool? isEmailVerified;
  final bool? isResetPassword;
  final int? credits;
  final bool? isProfileCompleted;
  final String? fcmToken;
  final bool? isBlocked;
  final bool? isDeleted;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final double? distance;
  final int? age;

  HomeUserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.profileImage,
    this.coverImage,
    this.gallery,
    this.gender,
    this.role,
    this.dateOfBirth,
    this.country,
    this.state,
    this.city,
    this.interests,
    this.lickList,
    this.idealMatch,
    this.language,
    this.address,
    this.location,
    this.bio,
    this.oneTimeCode,
    this.isEmailVerified,
    this.isResetPassword,
    this.credits,
    this.isProfileCompleted,
    this.fcmToken,
    this.isBlocked,
    this.isDeleted,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.distance,
    this.age,
  });

  factory HomeUserModel.fromJson(Map<String, dynamic> json) => HomeUserModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"],
    coverImage: json["coverImage"],
    gallery: json["gallery"] == null ? [] : List<String>.from(json["gallery"]!.map((x) => x)),
    gender: json["gender"],
    role: json["role"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    country: json["country"],
    state: json["state"],
    city: json["city"],
    interests: json["interests"] == null ? [] : List<String>.from(json["interests"]!.map((x) => x)),
    lickList: json["lickList"] == null ? [] : List<dynamic>.from(json["lickList"]!.map((x) => x)),
    idealMatch: json["idealMatch"],
    language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
    address: json["address"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    bio: json["bio"],
    oneTimeCode: json["oneTimeCode"],
    isEmailVerified: json["isEmailVerified"],
    isResetPassword: json["isResetPassword"],
    credits: json["credits"],
    isProfileCompleted: json["isProfileCompleted"],
    fcmToken: json["fcmToken"],
    isBlocked: json["isBlocked"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
    distance: json["distance"]?.toDouble(),
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "fullName": fullName,
    "email": email,
    "profileImage": profileImage,
    "coverImage": coverImage,
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
    "gender": gender,
    "role": role,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "country": country,
    "state": state,
    "city": city,
    "interests": interests == null ? [] : List<dynamic>.from(interests!.map((x) => x)),
    "lickList": lickList == null ? [] : List<dynamic>.from(lickList!.map((x) => x)),
    "idealMatch": idealMatch,
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "address": address,
    "location": location?.toJson(),
    "bio": bio,
    "oneTimeCode": oneTimeCode,
    "isEmailVerified": isEmailVerified,
    "isResetPassword": isResetPassword,
    "credits": credits,
    "isProfileCompleted": isProfileCompleted,
    "fcmToken": fcmToken,
    "isBlocked": isBlocked,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "distance": distance,
    "age": age,
  };
}

class Location {
  final String? type;
  final List<double>? coordinates;
  final String? locationName;

  Location({
    this.type,
    this.coordinates,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<double>.from(json["coordinates"]!.map((x) => x?.toDouble())),
    locationName: json["locationName"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "locationName": locationName,
  };
}

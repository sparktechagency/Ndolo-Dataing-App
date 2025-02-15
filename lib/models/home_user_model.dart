class HomeUserModel {
  final String? id;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final ProfileImage? profileImage;
  final CoverImage? coverImage;
  final List<dynamic>? gallery;
  final Role? role;
  final int? phoneNumber;
  final String? country;
  final String? state;
  final String? city;
  final List<String>? interests;
  final dynamic idealMatch;
  final List<dynamic>? language;
  final Location? location;
  final String? bio;
  final bool? isEmailVerified;
  final bool? isResetPassword;
  final int? credits;
  final bool? isProfileCompleted;
  final bool? isDeleted;
  final int? v;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? oneTimeCode;
  final List<dynamic>? lickList;
  final bool? isBlocked;
  final Address? address;
  final String? callingCode;
  final int? distance;
  final int? age;
  final dynamic fcmToken;
  final String? gender;
  final DateTime? dateOfBirth;

  HomeUserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.profileImage,
    this.coverImage,
    this.gallery,
    this.role,
    this.phoneNumber,
    this.country,
    this.state,
    this.city,
    this.interests,
    this.idealMatch,
    this.language,
    this.location,
    this.bio,
    this.isEmailVerified,
    this.isResetPassword,
    this.credits,
    this.isProfileCompleted,
    this.isDeleted,
    this.v,
    this.createdAt,
    this.updatedAt,
    this.oneTimeCode,
    this.lickList,
    this.isBlocked,
    this.address,
    this.callingCode,
    this.distance,
    this.age,
    this.fcmToken,
    this.gender,
    this.dateOfBirth,
  });

  factory HomeUserModel.fromJson(Map<String, dynamic> json) => HomeUserModel(
    id: json["_id"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"] != null ? profileImageValues.map[json["profileImage"]] : null,
    coverImage: json["coverImage"] != null ? coverImageValues.map[json["coverImage"]] : null,
    gallery: json["gallery"] == null ? [] : List<dynamic>.from(json["gallery"]!.map((x) => x)),
    role: json["role"] != null ? roleValues.map[json["role"]] : null,
    phoneNumber: json["phoneNumber"],
    country: json["country"],
    state: json["state"],
    city: json["city"],
    interests: json["interests"] == null ? [] : List<String>.from(json["interests"]!.map((x) => x)),
    idealMatch: json["idealMatch"],
    language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
    location: json["location"] != null ? Location.fromJson(json["location"]) : null,
    bio: json["bio"],
    isEmailVerified: json["isEmailVerified"],
    isResetPassword: json["isResetPassword"],
    credits: json["credits"],
    isProfileCompleted: json["isProfileCompleted"],
    isDeleted: json["isDeleted"],
    v: json["__v"],
    createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
    updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
    oneTimeCode: json["oneTimeCode"],
    lickList: json["lickList"] == null ? [] : List<dynamic>.from(json["lickList"]!.map((x) => x)),
    isBlocked: json["isBlocked"],
    address: json["address"] != null ? addressValues.map[json["address"]] : null,
    callingCode: json["callingCode"],
    distance: json["distance"],
    age: json["age"],
    fcmToken: json["fcmToken"],
    gender: json["gender"],
    dateOfBirth: json["dateOfBirth"] != null ? DateTime.parse(json["dateOfBirth"]) : null,
  );


  Map<String, dynamic> toJson() => {
    "_id": id,
    "firstName": firstName,
    "lastName": lastName,
    "fullName": fullName,
    "email": email,
    "profileImage": profileImageValues.reverse[profileImage],
    "coverImage": coverImageValues.reverse[coverImage],
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
    "role": roleValues.reverse[role],
    "phoneNumber": phoneNumber,
    "country": country,
    "state": state,
    "city": city,
    "interests": interests == null ? [] : List<dynamic>.from(interests!.map((x) => x)),
    "idealMatch": idealMatch,
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "location": location?.toJson(),
    "bio": bio,
    "isEmailVerified": isEmailVerified,
    "isResetPassword": isResetPassword,
    "credits": credits,
    "isProfileCompleted": isProfileCompleted,
    "isDeleted": isDeleted,
    "__v": v,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "oneTimeCode": oneTimeCode,
    "lickList": lickList == null ? [] : List<dynamic>.from(lickList!.map((x) => x)),
    "isBlocked": isBlocked,
    "address": addressValues.reverse[address],
    "callingCode": callingCode,
    "distance": distance,
    "age": age,
    "fcmToken": fcmToken,
    "gender": gender,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
  };
}

enum Address {
  ADDRESS_DHAKA_BANGLADESH,
  DHAKA_BANGLADESH,
  THAKURGAON_SADOR_THAKURGAON_DHAKA_BANGLADESH
}

final addressValues = EnumValues({
  "Dhaka, Bangladesh": Address.ADDRESS_DHAKA_BANGLADESH,
  "dhaka, Bangladesh": Address.DHAKA_BANGLADESH,
  "thakurgaon sador , thakurgaon, Dhaka, Bangladesh": Address.THAKURGAON_SADOR_THAKURGAON_DHAKA_BANGLADESH
});

enum CoverImage {
  UPLOADS_USERS_COVER_IMAGE_PNG
}

final coverImageValues = EnumValues({
  "/uploads/users/cover-image.png": CoverImage.UPLOADS_USERS_COVER_IMAGE_PNG
});

class Location {
  final Type? type;
  final List<int>? coordinates;
  final LocationName? locationName;

  Location({
    this.type,
    this.coordinates,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: typeValues.map[json["type"]]!,
    coordinates: json["coordinates"] == null ? [] : List<int>.from(json["coordinates"]!.map((x) => x)),
    locationName: locationNameValues.map[json["locationName"]]!,
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "locationName": locationNameValues.reverse[locationName],
  };
}

enum LocationName {
  DEFAULT_LOCATION
}

final locationNameValues = EnumValues({
  "Default Location": LocationName.DEFAULT_LOCATION
});

enum Type {
  POINT
}

final typeValues = EnumValues({
  "Point": Type.POINT
});

enum ProfileImage {
  UPLOADS_USERS_USER_PNG
}

final profileImageValues = EnumValues({
  "/uploads/users/user.png": ProfileImage.UPLOADS_USERS_USER_PNG
});

enum Role {
  ADMIN,
  SUPER_ADMIN,
  USER
}

final roleValues = EnumValues({
  "admin": Role.ADMIN,
  "superAdmin": Role.SUPER_ADMIN,
  "user": Role.USER
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}

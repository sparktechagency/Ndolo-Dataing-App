class SingleUserModel {
  final Location? location;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? coverImage;
  final List<dynamic>? gallery;
  final String? role;
  final int? phoneNumber;
  final DateTime? dateOfBirth;
  final String? country;
  final String? state;
  final String? city;
  final List<dynamic>? interests;
  final IdealMatch? idealMatch;
  final List<dynamic>? language;
  final String? bio;
  final int? credits;
  final bool? isProfileCompleted;
  final String? fcmToken;
  final bool? isDeleted;
  final DateTime? createdAt;
  final String? address;
  final String? callingCode;
  final bool? isBlocked;
  final List<dynamic>? lickList;
  final String? id;

  SingleUserModel({
    this.location,
    this.firstName,
    this.lastName,
    this.fullName,
    this.email,
    this.profileImage,
    this.coverImage,
    this.gallery,
    this.role,
    this.phoneNumber,
    this.dateOfBirth,
    this.country,
    this.state,
    this.city,
    this.interests,
    this.idealMatch,
    this.language,
    this.bio,
    this.credits,
    this.isProfileCompleted,
    this.fcmToken,
    this.isDeleted,
    this.createdAt,
    this.address,
    this.callingCode,
    this.isBlocked,
    this.lickList,
    this.id,
  });

  factory SingleUserModel.fromJson(Map<String, dynamic> json) => SingleUserModel(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"],
    coverImage: json["coverImage"],
    gallery: json["gallery"] == null ? [] : List<dynamic>.from(json["gallery"]!.map((x) => x)),
    role: json["role"],
    phoneNumber: json["phoneNumber"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    country: json["country"],
    state: json["state"],
    city: json["city"],
    interests: json["interests"] == null ? [] : List<dynamic>.from(json["interests"]!.map((x) => x)),
    idealMatch: json["idealMatch"] == null ? null : IdealMatch.fromJson(json["idealMatch"]),
    language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
    bio: json["bio"],
    credits: json["credits"],
    isProfileCompleted: json["isProfileCompleted"],
    fcmToken: json["fcmToken"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    address: json["address"],
    callingCode: json["callingCode"],
    isBlocked: json["isBlocked"],
    lickList: json["lickList"] == null ? [] : List<dynamic>.from(json["lickList"]!.map((x) => x)),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "firstName": firstName,
    "lastName": lastName,
    "fullName": fullName,
    "email": email,
    "profileImage": profileImage,
    "coverImage": coverImage,
    "gallery": gallery == null ? [] : List<dynamic>.from(gallery!.map((x) => x)),
    "role": role,
    "phoneNumber": phoneNumber,
    "dateOfBirth": dateOfBirth?.toIso8601String(),
    "country": country,
    "state": state,
    "city": city,
    "interests": interests == null ? [] : List<dynamic>.from(interests!.map((x) => x)),
    "idealMatch": idealMatch?.toJson(),
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "bio": bio,
    "credits": credits,
    "isProfileCompleted": isProfileCompleted,
    "fcmToken": fcmToken,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "address": address,
    "callingCode": callingCode,
    "isBlocked": isBlocked,
    "lickList": lickList == null ? [] : List<dynamic>.from(lickList!.map((x) => x)),
    "id": id,
  };
}

class IdealMatch {
  final String? title;
  final String? subTitle;
  final String? icon;
  final bool? isDeleted;
  final DateTime? createdAt;
  final String? id;

  IdealMatch({
    this.title,
    this.subTitle,
    this.icon,
    this.isDeleted,
    this.createdAt,
    this.id,
  });

  factory IdealMatch.fromJson(Map<String, dynamic> json) => IdealMatch(
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

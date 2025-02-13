class ProfileModel {
  final Location? location;
  final dynamic fcmToken;
  final String? firstName;
  final String? lastName;
  final String? fullName;
  final String? email;
  final String? profileImage;
  final String? coverImage;
  final List<dynamic>? gallery;
  final String? gender;
  final String? role;
  final DateTime? dateOfBirth;
  final String? country;
  final String? state;
  final String? city;
  final List<dynamic>? interests;
  final dynamic idealMatch;
  final List<dynamic>? language;
  final String? address;
  final String? bio;
  final int? credits;
  final bool? isProfileCompleted;
  final bool? isDeleted;
  final DateTime? createdAt;
  final bool? isBlocked;
  final List<dynamic>? lickList;
  final String? callingCode;
  final int? phoneNumber;
  final String? id;

  ProfileModel({
    this.location,
    this.fcmToken,
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
    this.idealMatch,
    this.language,
    this.address,
    this.bio,
    this.credits,
    this.isProfileCompleted,
    this.isDeleted,
    this.createdAt,
    this.isBlocked,
    this.lickList,
    this.callingCode,
    this.phoneNumber,
    this.id,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    fcmToken: json["fcmToken"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    fullName: json["fullName"],
    email: json["email"],
    profileImage: json["profileImage"],
    coverImage: json["coverImage"],
    gallery: json["gallery"] == null ? [] : List<dynamic>.from(json["gallery"]!.map((x) => x)),
    gender: json["gender"],
    role: json["role"],
    dateOfBirth: json["dateOfBirth"] == null ? null : DateTime.parse(json["dateOfBirth"]),
    country: json["country"],
    state: json["state"],
    city: json["city"],
    interests: json["interests"] == null ? [] : List<dynamic>.from(json["interests"]!.map((x) => x)),
    idealMatch: json["idealMatch"],
    language: json["language"] == null ? [] : List<dynamic>.from(json["language"]!.map((x) => x)),
    address: json["address"],
    bio: json["bio"],
    credits: json["credits"],
    isProfileCompleted: json["isProfileCompleted"],
    isDeleted: json["isDeleted"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    isBlocked: json["isBlocked"],
    lickList: json["lickList"] == null ? [] : List<dynamic>.from(json["lickList"]!.map((x) => x)),
    callingCode: json["callingCode"],
    phoneNumber: json["phoneNumber"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "location": location?.toJson(),
    "fcmToken": fcmToken,
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
    "idealMatch": idealMatch,
    "language": language == null ? [] : List<dynamic>.from(language!.map((x) => x)),
    "address": address,
    "bio": bio,
    "credits": credits,
    "isProfileCompleted": isProfileCompleted,
    "isDeleted": isDeleted,
    "createdAt": createdAt?.toIso8601String(),
    "isBlocked": isBlocked,
    "lickList": lickList == null ? [] : List<dynamic>.from(lickList!.map((x) => x)),
    "callingCode": callingCode,
    "phoneNumber": phoneNumber,
    "id": id,
  };
}

class Location {
  final String? type;
  final List<int>? coordinates;
  final String? locationName;

  Location({
    this.type,
    this.coordinates,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    type: json["type"],
    coordinates: json["coordinates"] == null ? [] : List<int>.from(json["coordinates"]!.map((x) => x)),
    locationName: json["locationName"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": coordinates == null ? [] : List<dynamic>.from(coordinates!.map((x) => x)),
    "locationName": locationName,
  };
}

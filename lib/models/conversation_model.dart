class ConversationModel {
  final String id;
  final Sender sender;
  final Receiver receiver;
  final int unseenMsg;
  final String blockStatus;
  final dynamic blockedBy;
  final LastMsg lastMsg;

  const ConversationModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.unseenMsg,
    required this.blockStatus,
    required this.blockedBy,
    required this.lastMsg,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      sender: Sender.fromJson(json['sender'] ?? {}),
      receiver: Receiver.fromJson(json['receiver'] ?? {}),
      unseenMsg: json['unseenMsg'] ?? 0,
      blockStatus: json['blockStatus'] ?? '',
      blockedBy: json['blockedBy'] ?? '',
      lastMsg: LastMsg.fromJson(json['lastMsg'] ?? {}),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'unseenMsg': unseenMsg,
      'blockStatus': blockStatus,
      'blockedBy': blockedBy,
      'lastMsg': lastMsg.toJson(),
    };
  }
}

class Sender {
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String profileImage;
  final String coverImage;
  final List<String> gallery;
  final String role;
  final String phoneNumber;
  final String country;
  final String state;
  final String city;
  final String address;
  final String fcmToken;
  final String id;
  final String gender;
  final String dateOfBirth;
  final String bio;
  final int credits;
  final bool isProfileCompleted;
  final bool isBlocked;
  final bool isDeleted;
  final DateTime createdAt;

  const Sender({
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.coverImage,
    required this.gallery,
    required this.role,
    required this.phoneNumber,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.fcmToken,
    required this.id,
    required this.gender,
    required this.dateOfBirth,
    required this.bio,
    required this.credits,
    required this.isProfileCompleted,
    required this.isBlocked,
    required this.isDeleted,
    required this.createdAt,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      coverImage: json['coverImage'] ?? '',
      gallery: List<String>.from(json['gallery'] ?? []), // Ensuring it's a List<String>
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      fcmToken: json['fcmToken'] ?? '',
      id: json['id'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: json['dateOfBirth'] ?? '',
      bio: json['bio'] ?? '',
      credits: json['credits'] ?? 0,
      isProfileCompleted: json['isProfileCompleted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'gallery': gallery,
      'role': role,
      'phoneNumber': phoneNumber,
      'country': country,
      'state': state,
      'city': city,
      'address': address,
      'fcmToken': fcmToken,
      'id': id,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'bio': bio,
      'credits': credits,
      'isProfileCompleted': isProfileCompleted,
      'isBlocked': isBlocked,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

class Receiver {
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String profileImage;
  final String coverImage;
  final List<String> gallery;
  final String role;
  final String phoneNumber;
  final String country;
  final String state;
  final String city;
  final String address;
  final String fcmToken;
  final String id;
  final String gender;
  final String dateOfBirth; // This should be a String or DateTime, not int
  final String bio;
  final int credits;
  final bool isProfileCompleted;
  final bool isBlocked;
  final bool isDeleted;
  final DateTime createdAt;

  const Receiver({
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.coverImage,
    required this.gallery,
    required this.role,
    required this.phoneNumber,
    required this.country,
    required this.state,
    required this.city,
    required this.address,
    required this.fcmToken,
    required this.id,
    required this.gender,
    required this.dateOfBirth,
    required this.bio,
    required this.credits,
    required this.isProfileCompleted,
    required this.isBlocked,
    required this.isDeleted,
    required this.createdAt,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      fullName: json['fullName'] ?? '',
      email: json['email'] ?? '',
      profileImage: json['profileImage'] ?? '',
      coverImage: json['coverImage'] ?? '',
      gallery: List<String>.from(json['gallery'] ?? []), // Ensure it's a List<String>
      role: json['role'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      country: json['country'] ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      address: json['address'] ?? '',
      fcmToken: json['fcmToken'] ?? '',
      id: json['id'] ?? '',
      gender: json['gender'] ?? '',
      dateOfBirth: _convertDateOfBirth(json['dateOfBirth']),
      bio: json['bio'] ?? '',
      credits: json['credits'] ?? 0,
      isProfileCompleted: json['isProfileCompleted'] ?? false,
      isBlocked: json['isBlocked'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'fullName': fullName,
      'email': email,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'gallery': gallery,
      'role': role,
      'phoneNumber': phoneNumber,
      'country': country,
      'state': state,
      'city': city,
      'address': address,
      'fcmToken': fcmToken,
      'id': id,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'bio': bio,
      'credits': credits,
      'isProfileCompleted': isProfileCompleted,
      'isBlocked': isBlocked,
      'isDeleted': isDeleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Handle the type conversion for dateOfBirth
  static String _convertDateOfBirth(dynamic dateOfBirth) {
    if (dateOfBirth == null) return ''; // Return empty string if null
    if (dateOfBirth is int) {
      // If it's an integer (timestamp), convert it to a DateTime string
      return DateTime.fromMillisecondsSinceEpoch(dateOfBirth).toIso8601String();
    }
    if (dateOfBirth is String) {
      // If it's already a string, return as is
      return dateOfBirth;
    }
    return ''; // Default fallback
  }
}

class LastMsg {
  final String conversationId;
  final String text;
  final String imageUrl;
  final String videoUrl;
  final String fileUrl;
  final String type;
  final bool seen;
  final String msgByUserId;
  final DateTime createdAt;

  const LastMsg({
    required this.conversationId,
    required this.text,
    required this.imageUrl,
    required this.videoUrl,
    required this.fileUrl,
    required this.type,
    required this.seen,
    required this.msgByUserId,
    required this.createdAt,
  });

  factory LastMsg.fromJson(Map<String, dynamic> json) {
    return LastMsg(
      conversationId: json['conversationId'] ?? '',
      text: json['text'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      videoUrl: json['videoUrl'] ?? '',
      fileUrl: json['fileUrl'] ?? '',
      type: json['type'] ?? '',
      seen: json['seen'] ?? false,
      msgByUserId: json['msgByUserId'] ?? '',
      createdAt: json['createdAt'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'text': text,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'fileUrl': fileUrl,
      'type': type,
      'seen': seen,
      'msgByUserId': msgByUserId,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}

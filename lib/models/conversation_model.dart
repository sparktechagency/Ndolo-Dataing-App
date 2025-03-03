class ConversationModel {
  final String? id;
  final Resiver? resiver;
  final LastMessage? lastMessage;
  final DateTime? updatedAt;

  ConversationModel({
    this.id,
    this.resiver,
    this.lastMessage,
    this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    id: json["_id"],
    resiver: json["resiver"] == null ? null : Resiver.fromJson(json["resiver"]),
    lastMessage: json["lastMessage"] == null ? null : LastMessage.fromJson(json["lastMessage"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "resiver": resiver?.toJson(),
    "lastMessage": lastMessage?.toJson(),
    "updatedAt": updatedAt?.toIso8601String(),
  };
}

class LastMessage {
  final String? conversationId;
  final String? text;
  final String? imageUrl;
  final String? videoUrl;
  final String? fileUrl;
  final String? type;
  final bool? seen;
  final String? msgByUserId;
  final DateTime? createdAt;
  final String? id;

  LastMessage({
    this.conversationId,
    this.text,
    this.imageUrl,
    this.videoUrl,
    this.fileUrl,
    this.type,
    this.seen,
    this.msgByUserId,
    this.createdAt,
    this.id,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) => LastMessage(
    conversationId: json["conversationId"],
    text: json["text"],
    imageUrl: json["imageUrl"],
    videoUrl: json["videoUrl"],
    fileUrl: json["fileUrl"],
    type: json["type"],
    seen: json["seen"],
    msgByUserId: json["msgByUserId"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "conversationId": conversationId,
    "text": text,
    "imageUrl": imageUrl,
    "videoUrl": videoUrl,
    "fileUrl": fileUrl,
    "type": type,
    "seen": seen,
    "msgByUserId": msgByUserId,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

class Resiver {
  final String? id;
  final String? fullName;
  final String? role;
  final String? profileImage;

  Resiver({
    this.id,
    this.fullName,
    this.role,
    this.profileImage,
  });

  factory Resiver.fromJson(Map<String, dynamic> json) => Resiver(
    id: json["_id"],
    fullName: json["fullName"],
    role: json["role"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullName": fullName,
    "role": role,
    "profileImage": profileImage,
  };
}

class MessageModel {
  final String? conversationId;
  final String? text;
  final String? imageUrl;
  final String? videoUrl;
  final String? fileUrl;
  final String? type;
  final bool? seen;
  final MsgByUserId? msgByUserId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? id;

  MessageModel({
    this.conversationId,
    this.text,
    this.imageUrl,
    this.videoUrl,
    this.fileUrl,
    this.type,
    this.seen,
    this.msgByUserId,
    this.createdAt,
    this.updatedAt,
    this.id,
  });

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
    conversationId: json["conversationId"],
    text: json["text"],
    imageUrl: json["imageUrl"],
    videoUrl: json["videoUrl"],
    fileUrl: json["fileUrl"],
    type: json["type"],
    seen: json["seen"],
    msgByUserId: json["msgByUserId"] == null ? null : MsgByUserId.fromJson(json["msgByUserId"]),
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
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
    "msgByUserId": msgByUserId?.toJson(),
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "id": id,
  };
}

class MsgByUserId {
  final String? fullName;
  final String? email;
  final String? image;
  final String? id;

  MsgByUserId({
    this.fullName,
    this.email,
    this.image,
    this.id,
  });

  factory MsgByUserId.fromJson(Map<String, dynamic> json) => MsgByUserId(
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

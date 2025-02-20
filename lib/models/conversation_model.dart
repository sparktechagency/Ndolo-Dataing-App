class ConversationModel {
  final Receiver? sender;
  final Receiver? receiver;
  final dynamic lastMessage;
  final List<dynamic>? messages;
  final dynamic blockedBy;
  final String? blockStatus;
  final DateTime? createdAt;
  final String? id;

  ConversationModel({
    this.sender,
    this.receiver,
    this.lastMessage,
    this.messages,
    this.blockedBy,
    this.blockStatus,
    this.createdAt,
    this.id,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) => ConversationModel(
    sender: json["sender"] == null ? null : Receiver.fromJson(json["sender"]),
    receiver: json["receiver"] == null ? null : Receiver.fromJson(json["receiver"]),
    lastMessage: json["lastMessage"],
    messages: json["messages"] == null ? [] : List<dynamic>.from(json["messages"]!.map((x) => x)),
    blockedBy: json["blockedBy"],
    blockStatus: json["blockStatus"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "sender": sender?.toJson(),
    "receiver": receiver?.toJson(),
    "lastMessage": lastMessage,
    "messages": messages == null ? [] : List<dynamic>.from(messages!.map((x) => x)),
    "blockedBy": blockedBy,
    "blockStatus": blockStatus,
    "createdAt": createdAt?.toIso8601String(),
    "id": id,
  };
}

class Receiver {
  final String? fullName;
  final String? role;
  final String? id;
  final String? profileImage;

  Receiver({
    this.fullName,
    this.role,
    this.id,
    this.profileImage,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) => Receiver(
    fullName: json["fullName"],
    role: json["role"],
    id: json["id"],
    profileImage: json["profileImage"],
  );

  Map<String, dynamic> toJson() => {
    "fullName": fullName,
    "role": role,
    "id": id,
    "profileImage": profileImage,
  };
}

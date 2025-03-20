class NotificationModel {
  final String? id;
  final String? userId;
  final String? sendBy;
  final dynamic conversationId;
  final String? role;
  final String? title;
  final String? content;
  final String? icon;
  final String? devStatus;
  final String? image;
  final String? status;
  final String? type;
  final String? priority;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;

  NotificationModel({
    this.id,
    this.userId,
    this.sendBy,
    this.conversationId,
    this.role,
    this.title,
    this.content,
    this.icon,
    this.devStatus,
    this.image,
    this.status,
    this.type,
    this.priority,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) => NotificationModel(
    id: json["_id"],
    userId: json["userId"],
    sendBy: json["sendBy"],
    conversationId: json["conversationId"],
    role: json["role"],
    title: json["title"],
    content: json["content"],
    icon: json["icon"],
    devStatus: json["devStatus"],
    image: json["image"],
    status: json["status"],
    type: json["type"],
    priority: json["priority"],
    createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
    updatedAt: json["updatedAt"] == null ? null : DateTime.parse(json["updatedAt"]),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "sendBy": sendBy,
    "conversationId": conversationId,
    "role": role,
    "title": title,
    "content": content,
    "icon": icon,
    "devStatus": devStatus,
    "image": image,
    "status": status,
    "type": type,
    "priority": priority,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
  };
}

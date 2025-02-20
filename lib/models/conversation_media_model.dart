class ConversationMediaModel {
  final String? url;
  final String? type;

  ConversationMediaModel({
    this.url,
    this.type,
  });

  factory ConversationMediaModel.fromJson(Map<String, dynamic> json) => ConversationMediaModel(
    url: json["url"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "type": type,
  };
}
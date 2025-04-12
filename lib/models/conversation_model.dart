class Sender {
  final String id;
  final String firstName;
  final String lastName;
  final String fullName;
  final String email;
  final String profileImage;
  final String coverImage;
  final String address;
  final String bio;

  Sender({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.fullName,
    required this.email,
    required this.profileImage,
    required this.coverImage,
    required this.address,
    required this.bio,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      fullName: json['fullName'],
      email: json['email'],
      profileImage: json['profileImage'],
      coverImage: json['coverImage'],
      address: json['address'],
      bio: json['bio'],
    );
  }
}

class Receiver {
  final String id;
  final String fullName;
  final String email;
  final String profileImage;

  Receiver({
    required this.id,
    required this.fullName,
    required this.email,
    required this.profileImage,
  });

  factory Receiver.fromJson(Map<String, dynamic> json) {
    return Receiver(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      profileImage: json['profileImage'],
    );
  }
}

class LastMessage {
  final String conversationId;
  final String text;
  final String type;
  final bool seen;
  final String createdAt;

  LastMessage({
    required this.conversationId,
    required this.text,
    required this.type,
    required this.seen,
    required this.createdAt,
  });

  factory LastMessage.fromJson(Map<String, dynamic> json) {
    return LastMessage(
      conversationId: json['conversationId'],
      text: json['text'],
      type: json['type'],
      seen: json['seen'],
      createdAt: json['createdAt'],
    );
  }
}

class ConversationModel {
  final String id;
  final Sender sender;
  final Receiver receiver;
  final int unseenMsg;
  final LastMessage lastMessage;

  ConversationModel({
    required this.id,
    required this.sender,
    required this.receiver,
    required this.unseenMsg,
    required this.lastMessage,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      id: json['_id'],
      sender: Sender.fromJson(json['sender']),
      receiver: Receiver.fromJson(json['receiver']),
      unseenMsg: json['unseenMsg'],
      lastMessage: LastMessage.fromJson(json['lastMsg']),
    );
  }
}

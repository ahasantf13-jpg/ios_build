import 'package:beautygm/features/notifications/domain/entities/post_notificaiton_entity.dart';

class PostNotificationModel extends PostNotificaitonEntity {
  final String recipientId;
  final String content;
  final String createdById;
  final DateTime createdAt;

  PostNotificationModel({
    required this.recipientId,
    required this.content,
    required this.createdById,
    required this.createdAt,
  });

  factory PostNotificationModel.fromJson(Map<String, dynamic> json) {
    return PostNotificationModel(
      recipientId: json['recipient'] ?? "",
      content: json['content'] ?? "",
      createdById: json['created_by'] ?? "",
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipient': recipientId,
      'content': content,
      'created_by': createdById,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class PostCommentModel {
  String id;
  int likes;
  String sentToPostId;
  String sentByUserId;
  String sentByUserName;
  String content;
  bool isSolved;
  List<String> likedByUsers;
  bool isCommentSenderModerator;
  Timestamp createdAt;

  PostCommentModel({
    required this.id,
    required this.likes,
    required this.sentToPostId,
    required this.sentByUserId,
    required this.sentByUserName,
    required this.content,
    required this.isSolved,
    required this.likedByUsers,
    required this.isCommentSenderModerator,
    required this.createdAt,
  });

  factory PostCommentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PostCommentModel(
      id: doc.id,
      likes: data['likes'] ?? 0,
      sentToPostId: data['sentToPostId'] ?? '',
      sentByUserId: data['sentByUserId'] ?? '',
      sentByUserName: data['sentByUserName'] ?? '',
      content: data['content'] ?? '',
      isSolved: data['isSolved'] ?? false,
      likedByUsers: List<String>.from(data['likedByUsers'] ?? []),
      isCommentSenderModerator: data['isCommentSenderModerator'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'likes': likes,
      'sentToPostId': sentToPostId,
      'sentByUserId': sentByUserId,
      'sentByUserName': sentByUserName,
      'content':content,
      'isSolved': isSolved,
      'likedByUsers': likedByUsers,
      'isCommentSenderModerator': isCommentSenderModerator,
      'createdAt': createdAt,
    };
  }

  void toggleLike(String userId) {
    if (likedByUsers.contains(userId)) {
      likedByUsers.remove(userId);
      likes--;
    } else {
      likedByUsers.add(userId);
      likes++;
    }
  }

}
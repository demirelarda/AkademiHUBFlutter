import 'package:cloud_firestore/cloud_firestore.dart';

class PostCommentModel {
  String id;
  int likes;
  String sentToPostId;
  String sentByUserId;
  String sentByUserName;

  PostCommentModel({
    required this.id,
    required this.likes,
    required this.sentToPostId,
    required this.sentByUserId,
    required this.sentByUserName,
  });

  factory PostCommentModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return PostCommentModel(
      id: doc.id,
      likes: data['likes'] ?? 0,
      sentToPostId: data['sentToPostId'] ?? '',
      sentByUserId: data['sentByUserId'] ?? '',
      sentByUserName: data['sentByUserName'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'likes': likes,
      'sentToPostId': sentToPostId,
      'sentByUserId': sentByUserId,
      'sentByUserName': sentByUserName,
    };
  }
}

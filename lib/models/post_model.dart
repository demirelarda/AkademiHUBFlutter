import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String title;
  final String content;
  final String category;
  final Timestamp createdAt;
  final int likes;
  final int postScore;
  final String sentByUserId;
  final String sentByUserName;
  final int commentCount;

  Post({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    required this.likes,
    required this.postScore,
    required this.sentByUserId,
    required this.sentByUserName,
    required this.commentCount,
  });

  factory Post.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return Post(
      id: snapshot.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      category: data['category'] ?? '',
      createdAt: data['createdAt'] ?? Timestamp.now(),
      likes: data['likes'] ?? 0,
      postScore: data['postScore'] ?? 0,
      sentByUserId: data['sentByUserId'] ?? '',
      sentByUserName: data['sentByUserName'] ?? '',
      commentCount: data['commentCount'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      'category': category,
      'createdAt': createdAt,
      'likes': likes,
      'postScore': postScore,
      'sentByUserId': sentByUserId,
      'sentByUserName': sentByUserName,
      'commentCount': commentCount,
    };
  }
}
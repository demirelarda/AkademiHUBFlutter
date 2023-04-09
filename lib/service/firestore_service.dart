import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_comment_model.dart';
import '../models/post_model.dart';
import '../models/user_model.dart';

class FirestoreService {



  final CollectionReference _postsCollection =
  FirebaseFirestore.instance.collection('posts');

  Future<void> addPost(Post post) async {
    try {
      await _postsCollection.add(post.toMap());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }


  Future<List<Post>> getPosts() async {
    try {
      QuerySnapshot querySnapshot = await _postsCollection
          .orderBy('createdAt', descending: true)
          .get();
      return querySnapshot.docs
          .map((doc) => Post.fromSnapshot(doc))
          .toList();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  final CollectionReference _commentsCollection = FirebaseFirestore.instance.collection('comments');

  Future<void> addComment(PostCommentModel comment) async {
    try {
      await _commentsCollection.add(comment.toFirestore());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<List<PostCommentModel>> getCommentsForPost(String postId) async {
    try {
      QuerySnapshot querySnapshot = await _commentsCollection
          .where('sentToPostId', isEqualTo: postId)
          .get();

      return querySnapshot.docs
          .map((doc) => PostCommentModel.fromFirestore(doc))
          .toList();
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  final CollectionReference _usersCollection = FirebaseFirestore.instance.collection('users');

  Future<void> addUser(UserModel user) async {
    try {
      await _usersCollection.doc(user.userId).set(user.toMap());
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  final CollectionReference _postsCollectionRef = FirebaseFirestore.instance.collection('posts');

  Future<void> updatePostLikeStatus(Post post, String userId) async {
    try {
      post.toggleLike(userId);
      await _postsCollectionRef.doc(post.id).update({'likes': post.likes, 'likedByUsers': post.likedByUsers});
    } catch (e) {
      print('Error updating post like status: $e');
      rethrow;
    }
  }

  Future<void> updateCommentCount(Post post) async {
    final postRef = _postsCollection.doc(post.id);
    final commentsQuery = _commentsCollection.where('sentToPostId', isEqualTo: post.id);
    final comments = await commentsQuery.get();
    final commentCount = comments.docs.length;
    await postRef.update({'commentCount': commentCount});
  }

  Future<void> updateCommentIsSolved(String commentId, bool isSolved) async {
    try {
      await _commentsCollection.doc(commentId).update({'isSolved': isSolved});
    } catch (e) {
      print('Error updating comment isSolved: $e');
      rethrow;
    }
  }

  Future<void> updateUserPoints(String userId, int points) async {
    try {
      final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
      await userRef.update({'userPoint': FieldValue.increment(points)});
    } catch (e) {
      print('Error updating user points: $e');
      rethrow;
    }
  }

  Future<UserModel> getUser(String userId) async {
    try {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
      return UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print(e);
      throw Exception("Kullanıcı bilgisi alınamadı.");
    }
  }

  Future<void> updateCommentLikes(PostCommentModel comment) async {
    try {
      await _commentsCollection
          .doc(comment.id)
          .update({'likes': comment.likes, 'likedByUsers': comment.likedByUsers});
    } catch (e) {
      print('Error updating comment likes: $e');
      throw e;
    }
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserData(String userId) async {
    return await FirebaseFirestore.instance.collection('users')
        .doc(userId)
        .get();
  }







}
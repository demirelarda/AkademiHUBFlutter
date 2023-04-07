import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/post_model.dart';


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
}

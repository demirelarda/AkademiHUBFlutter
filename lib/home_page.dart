import 'package:akademi_hub_flutter/post_details_page.dart';
import 'package:akademi_hub_flutter/service/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'models/post_model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirestoreService _firestoreService = FirestoreService();
  final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

  void _toggleLike(Post post, ValueNotifier<int> likes) async {
    bool wasLiked = _isPostLiked(post);
    await _firestoreService.updatePostLikeStatus(post, currentUserId!);
    int points = wasLiked ? -10 : 10;
    await _firestoreService.updateUserPoints(post.sentByUserId, points);
    likes.value = wasLiked ? likes.value - 1 : likes.value + 1;
  }

  bool _isPostLiked(Post post) {
    return post.likedByUsers.contains(currentUserId);
  }

  Future<void> _refreshPosts() async {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Post>>(
        future: _firestoreService.getPosts(),
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Bir hata oluştu'));
          } else {
            List<Post> posts = snapshot.data!;
            return RefreshIndicator(
              onRefresh: _refreshPosts,
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  final likes = ValueNotifier<int>(posts[index].likes);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                PostDetailsPage(post: posts[index]),
                          ),
                        );
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                posts[index].sentByUserName,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                posts[index].title,
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () =>
                                        _toggleLike(posts[index], likes),
                                    child: ValueListenableBuilder(
                                      valueListenable: likes,
                                      builder: (context, value, child) {
                                        return Icon(
                                          Icons.favorite,
                                          color: _isPostLiked(posts[index])
                                              ? Colors.red
                                              : Colors.grey,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 5),
                                  ValueListenableBuilder<int>(
                                    valueListenable: likes,
                                    builder: (context, value, child) {
                                      return Text('$value');
                                    },
                                  ),
                                  SizedBox(width: 15),
                                  Icon(Icons.comment, color: Colors.grey),
                                  SizedBox(width: 5),
                                  Text('${posts[index].commentCount}'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

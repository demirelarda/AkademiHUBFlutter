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
  String? _selectedCategory;

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

  //listedkei tüm Post'lardaki mevcut kategorileri al
  List<String> _getCategories(List<Post> posts) {
    Set<String> categories = {};
    for (Post post in posts) {
      categories.add(post.category);
    }
    return categories.toList();
  }

  void _filterByCategory(String? category) {
    setState(() {
      _selectedCategory = category;
    });
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
            List<String> categories = _getCategories(posts);
            List<Post> filteredPosts = _selectedCategory == null
                ? posts
                : posts
                    .where((post) => post.category == _selectedCategory)
                    .toList();

            return RefreshIndicator(
              onRefresh: _refreshPosts,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    backgroundColor: Colors.white,
                    title: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: categories.map((category) {
                          return Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 4.0),
                            child: FilterChip(
                              label: Text(category),
                              selected: _selectedCategory == category,
                              selectedColor: Colors.lightBlue,
                              onSelected: (bool selected) {
                                _filterByCategory(selected ? category : null);
                              },
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final likes =
                            ValueNotifier<int>(filteredPosts[index].likes);
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PostDetailsPage(
                                      post: filteredPosts[index]),
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
                                    Row(
                                      children: [
                                        Text(
                                          filteredPosts[index].sentByUserName,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        if (filteredPosts[index]
                                            .isPostSenderModerator)
                                          Icon(Icons.verified,
                                              color: Colors.blue, size: 18),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      filteredPosts[index].title,
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        InkWell(
                                          onTap: () => _toggleLike(
                                              filteredPosts[index], likes),
                                          child: ValueListenableBuilder(
                                            valueListenable: likes,
                                            builder: (context, value, child) {
                                              return Icon(
                                                Icons.favorite,
                                                color: _isPostLiked(
                                                        filteredPosts[index])
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
                                        Text(
                                            '${filteredPosts[index].commentCount}'),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: filteredPosts.length,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}

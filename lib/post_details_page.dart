import 'package:akademi_hub_flutter/service/firestore_service.dart';
import 'package:flutter/material.dart';


import 'models/post_comment_model.dart';
import 'models/post_model.dart';

class PostDetailsPage extends StatefulWidget {
  final Post post;

  PostDetailsPage({required this.post});

  @override
  _PostDetailsPageState createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  TextEditingController _commentController = TextEditingController();
  final FirestoreService _firestoreService = FirestoreService();

  void _submitComment() async {
    if (_commentController.text.isNotEmpty) {
      print(_commentController.text);
      PostCommentModel newComment = PostCommentModel(
        id: '',
        content: _commentController.text,
        likes: 0,
        sentToPostId: widget.post.id,
        sentByUserId: 'currentUser',
        sentByUserName: 'currentUserName',
      );

      try {
        await _firestoreService.addComment(newComment);
        _commentController.clear();
      } catch (e) {
        print('Yorum gönderme hatası: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gönderi Detayları'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.post.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Text(widget.post.content),
                SizedBox(height: 16),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    'by ${widget.post.sentByUserName}',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<List<PostCommentModel>>(
              future: _firestoreService.getCommentsForPost(widget.post.id),
              builder: (BuildContext context, AsyncSnapshot<List<PostCommentModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Bir hata oluştu'));
                } else {
                  List<PostCommentModel> comments = snapshot.data!;
                  return ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _buildCommentCard(comments[index]);
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4.0,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _commentController,
                decoration: InputDecoration(
                  hintText: 'Yorum ekle...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.send),
              onPressed: _submitComment,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCommentCard(PostCommentModel comment) {
    print(comment.content);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              comment.sentByUserName,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(comment.content),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.favorite, color: Colors.grey),
                SizedBox(width: 5),
                Text('${comment.likes}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


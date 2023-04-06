import 'package:flutter/material.dart';

class RankPage extends StatelessWidget {
  final List<UserScore> users = [
    UserScore(username: 'User1', score: 100),
    UserScore(username: 'User2', score: 200),
    UserScore(username: 'User3', score: 300),
    UserScore(username: 'User4', score: 400),
    UserScore(username: 'User5', score: 500),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar'ı kaldır
      appBar: null,
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(users[index].username),
            trailing: Text(users[index].score.toString()),
          );
        },
      ),
    );
  }
}

class UserScore {
  final String username;
  final int score;

  UserScore({required this.username, required this.score});
}

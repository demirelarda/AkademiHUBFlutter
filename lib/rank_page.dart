import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/user_model.dart';

class RankPage extends StatefulWidget {
  RankPage({Key? key}) : super(key: key);

  @override
  State<RankPage> createState() => _RankPageState();
}

class _RankPageState extends State<RankPage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection('users')
      .orderBy('userPoint', descending: true)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Bir hata oluştu');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final users = snapshot.data!.docs
              .map((doc) =>
                  UserModel.fromMap(doc.data() as Map<String, dynamic>))
              .toList();

          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height / 3.5,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 34, 38, 62),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 40,
                          child: Text("3"),
                        ),
                        Text(
                          "${users[2].firstName} ${users[2].lastName}",
                          style: TextStyle(color: Colors.white),
                        ),
                        Text(
                          "${users[2].userPoint}",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 60,
                            child: Text("1"),
                          ),
                          Text(
                            "${users[0].firstName} ${users[0].lastName}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${users[0].userPoint}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40,
                            child: Text("2"),
                          ),
                          Text(
                            "${users[1].firstName} ${users[1].lastName}",
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            "${users[1].userPoint}",
                            style: TextStyle(color: Colors.white),
                          )
                        ])
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (BuildContext context, int index) {
                      UserModel user = users[index];
                      return ListTile(
                        leading: Icon(
                          Icons.brightness_1,
                          size: 20.0,
                          color: Color.fromARGB(255, 34, 38, 62),
                        ),
                        trailing: user.selectedCourse == "Flutter"
                            ? ImageIcon(AssetImage("images/flutter-icon.png"))
                            : ImageIcon(AssetImage("images/unity-icon.png")),
                        title: Text(
                            "${user.userPoint} ${user.firstName} ${user.lastName}"),
                      );
                    }),
              ),
            ],
          );
        },
      ),
    );
  }
}

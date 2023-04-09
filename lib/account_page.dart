import 'package:akademi_hub_flutter/models/user_model.dart';
import 'package:akademi_hub_flutter/service/authentication_service.dart';
import 'package:akademi_hub_flutter/service/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    final AuthenticationService _authService = AuthenticationService();
    final FirestoreService _firestoreService = FirestoreService();
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: Scaffold(
        body: FutureBuilder<UserModel>(
          future: _firestoreService.getUser(currentUserId!),
          builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Hata: ${snapshot.error}'));
            } else {
              UserModel user = snapshot.data!;

              if (user.isModerator) {
                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user.firstName+" "+user.lastName),
                        Icon(Icons.verified, color: Colors.blue),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              _authService.signOut();
                            },
                            child: Text('Çıkış Yap'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              primary: Color.fromARGB(255, 34, 38, 62),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                String courseImage = user.selectedCourse == "Flutter"
                    ? "images/flutter-icon.png"
                    : "images/unity-icon.png";

                List<String> progressPercentages = [
                  user.mainCourseCompletion.toString(),
                  user.entCompletion.toString(),
                  user.englishCompletion.toString()
                ];

                return Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2.0, left: 20.0, bottom: 20.0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 34, 38, 62),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 50),
                                            child: Text(
                                              "${user.firstName} ${user.lastName}",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  CircleAvatar(
                                    backgroundColor: Colors.white,
                                    radius: 60,
                                    child: ClipOval(
                                      child: Image.asset(courseImage),
                                    ),
                                  )
                                ],
                              ),
                              Padding(
                                  padding: EdgeInsets.only(left: 275, top: 50),
                                  child: FloatingActionButton(
                                    backgroundColor:
                                        Color.fromARGB(255, 34, 38, 62),
                                    onPressed: () {},
                                    child: Icon(
                                      Icons.refresh,
                                      size: 45,
                                    ),
                                  )),
                              SizedBox(
                                height: 50,
                              ),
                              Text("EĞİTİMLERİM",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 34, 38, 62),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                        _buildProgressRow(courseImage, progressPercentages[0]),
                        SizedBox(height: 20),
                        _buildProgressRow(
                            "images/ucak.png", progressPercentages[1]),
                        SizedBox(height: 20),
                        _buildProgressRow(
                            "images/book.png", progressPercentages[2]),
                        SizedBox(height: 50),
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              _authService.signOut();
                            },
                            child: Text('Çıkış Yap'),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              primary: Color.fromARGB(255, 34, 38, 62),
                            ),
                          ),
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                );
              }
            }
          },
        ),
      ),
    );
  }

  Widget _buildProgressRow(String courseImage, String progressPercentage) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: Container(
            width: 30,
            height: 30,
            child: Image.asset(
              courseImage,
              scale: 20,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Container(
            width: 200,
            height: 40,
            child: LinearProgressIndicator(
              value: double.parse("0.$progressPercentage"),
              backgroundColor: Colors.grey,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ),
        Text(
          " %$progressPercentage",
          style: TextStyle(fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}



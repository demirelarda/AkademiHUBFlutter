import 'dart:math';

import 'package:akademi_hub_flutter/service/authentication_service.dart';
import 'package:akademi_hub_flutter/service/firestore_service.dart';
import 'package:akademi_hub_flutter/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'models/user_model.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  String _selectedCourse = 'Unity';
  int? _randomNumber1;
  int? _randomNumber2;
  int? _randomNumber3;

  var themeColor = Color.fromARGB(255, 34, 38, 62);

  final AuthenticationService _authService = AuthenticationService();
  final FirestoreService _firestoreService = FirestoreService();

  void _signUp() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty) {
      UserCredential? userCredential = await _authService.signUpWithEmail(
          _emailController.text, _passwordController.text,_firstNameController.text,_lastNameController.text);

      //Kullanıcının kursları tamamlama yüzdesi rastgele olarak belirleniyor.

      _randomNumber1 = Random().nextInt(100);
      _randomNumber2 = Random().nextInt(100);
      _randomNumber3 = Random().nextInt(100);

      if (userCredential != null) {
        UserModel newUser = UserModel(
          userId: userCredential.user!.uid,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          userPoint: 0,
          selectedCourse: _selectedCourse,
          mainCourseCompletion: _randomNumber1!,
          entCompletion: _randomNumber2!,
          englishCompletion: _randomNumber3!,
          isModerator: false,
        );

        try {
          await _firestoreService.addUser(newUser);
          Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Wrapper()));
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Kayıt başarılı! Lütfen Giriş Yapın.")));
        } catch (e) {
          print('Error adding user to Firestore: $e');
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Kayıt yapılırken bir hata oluştu, tekrar deneyin!")));
        }
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 34, 38, 62),
        title: Text('Üye Ol'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left:16.0,right: 16,top: 40),
            child: Column(
              children: [
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: 'Adınızı Giriniz',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: 'Soyadınızı Giriniz',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email Adresinizi Giriniz',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 16),

                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Şifrenizi Giriniz',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 75),
                Text("Seçilen Alan:",style: TextStyle(
                    fontWeight: FontWeight.bold
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ImageIcon(AssetImage("images/unity-icon.png")),
                    Radio<String>(
                      value: 'Unity',
                      groupValue: _selectedCourse,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCourse = value!;
                        });
                      },
                    ),
                    SizedBox(width: 50),
                    ImageIcon(AssetImage("images/flutter-icon.png")),
                    Radio<String>(
                      value: 'Flutter',
                      groupValue: _selectedCourse,
                      onChanged: (String? value) {
                        setState(() {
                          _selectedCourse = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 50),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton(

                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                      backgroundColor: Color.fromARGB(255, 34, 38, 62),
                    ),
                    onPressed: _signUp,
                    child: Text('Üye Ol'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
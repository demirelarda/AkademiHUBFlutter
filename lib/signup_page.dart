import 'package:akademi_hub_flutter/service/authentication_service.dart';
import 'package:akademi_hub_flutter/service/firestore_service.dart';
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

  final AuthenticationService _authService = AuthenticationService();
  final FirestoreService _firestoreService = FirestoreService();

  void _signUp() async {
    if (_emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty) {
      UserCredential? userCredential = await _authService.signUpWithEmail(
          _emailController.text, _passwordController.text,_firstNameController.text,_lastNameController.text);

      if (userCredential != null) {
        UserModel newUser = UserModel(
          userId: userCredential.user!.uid,
          firstName: _firstNameController.text,
          lastName: _lastNameController.text,
          userPoint: 0,
          selectedCourse: _selectedCourse,
        );

        try {
          await _firestoreService.addUser(newUser);
          // Navigate to the next page or home page
          Navigator.of(context).pushReplacementNamed('/home');
        } catch (e) {
          print('Error adding user to Firestore: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  labelText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  labelText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Unity'),
                  Radio<String>(
                    value: 'Unity',
                    groupValue: _selectedCourse,
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCourse = value!;
                      });
                    },
                  ),
                  SizedBox(width: 16),
                  Text('Flutter'),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: _signUp,
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

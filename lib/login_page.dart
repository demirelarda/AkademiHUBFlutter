import 'package:akademi_hub_flutter/signup_page.dart';
import 'package:akademi_hub_flutter/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:akademi_hub_flutter/service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthenticationService _authService = AuthenticationService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SafeArea(
          child: Stack(fit: StackFit.loose, children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: SizedBox(child: Image.asset("images/logo.png")),
            ),


            SizedBox(
              height: 570,
              child: Align(
                alignment: Alignment.center,
                child: Text("AkademiHUB",
                  style: TextStyle(
                      color: Color.fromARGB(255, 34, 38, 62),
                      fontSize: 30,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    height: height / 1.8,
                    width: width,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 34, 38, 62),
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50),
                            topLeft: Radius.circular(50))),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 35),
                            child: Text(
                              "GİRİŞ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 60, bottom: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "EMAİL",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Container(
                            width: width / 1.25,
                            child: TextFormField(
                              controller: _emailController,
                              style: TextStyle(
                                color: Color.fromARGB(255, 34, 38, 62),
                              ),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 60, top: 10, bottom: 10),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "ŞİFRE",
                                  style: TextStyle(color: Colors.white),
                                )),
                          ),
                          Container(
                            width: width / 1.25,
                            child: TextFormField(
                              controller: _passwordController,
                              style: TextStyle(
                                color: Color.fromARGB(255, 34, 38, 62),
                              ),
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(50.0),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                focusColor: Colors.white,
                              ),
                              obscureText: true,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: ElevatedButton(
                              onPressed: () {
                                signIn();
                              },
                              child: Text(
                                "GİRİŞ YAP",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 34, 38, 62),
                                    fontSize: 18),
                              ),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60, vertical: 15),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                            child: Text(
                              "Üye Ol",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ]),
        ));
  }

  void signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        await _authService.signInWithEmailAndPassword(
            _emailController.text, _passwordController.text);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Wrapper()));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.message!)));
      }
    }
  }
}

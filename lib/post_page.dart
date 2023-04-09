import 'package:akademi_hub_flutter/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'models/post_model.dart';

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  String? _selectedCategory;
  final _formKey = GlobalKey<FormState>();

  final FirestoreService _firestoreService = FirestoreService();

  // Kullanıcının moderatör olup olmadığını kontrol eden fonksiyon
  Future<bool> _isUserModerator(String userId) async {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
        await _firestoreService.getUserData(userId);
    return userDoc.data()?['isModerator'] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                      labelText: 'Başlık',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen başlık girin';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: _contentController,
                    decoration: InputDecoration(
                      labelText: 'İçerik',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 10,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Lütfen içerik girin';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  DropdownButtonFormField(
                    hint: Text('Kategori Seçin'),
                    onChanged: (String? value) {
                      setState(() {
                        _selectedCategory = value!;
                      });
                    },
                    value: _selectedCategory,
                    validator: (value) {
                      if (value == null) {
                        return 'Lütfen kategori seçin';
                      }
                      return null;
                    },
                    items: [
                      'Teknik Sorun',
                      'Özel Soru',
                      'Yazılımsal sorun',
                      'Proje',
                      'Tavsiye',
                      'Diğer',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 200),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color.fromARGB(255, 34, 38, 62),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        bool isModerator = false;
                        if (user != null) {
                          isModerator = await _isUserModerator(user.uid);
                        }
                        Post newPost = Post(
                          id: '',
                          title: _titleController.text,
                          content: _contentController.text,
                          category: _selectedCategory!,
                          createdAt: Timestamp.now(),
                          likes: 0,
                          postScore: 0,
                          sentByUserId: user!.uid,
                          sentByUserName: user.displayName ?? 'User',
                          commentCount: 0,
                          isSolved: false,
                          likedByUsers: <String>[],
                          isPostSenderModerator: isModerator,
                        );

                        // gönderi eklenirken progress bar göster
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );

                        try {
                          await _firestoreService.addPost(newPost);

                          // progress barı gizle
                          Navigator.pop(context);

                          // başarılı snackbar'ı göster
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Gönderi başarıyla eklendi')),
                          );
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/', (_) => false);
                        } catch (e) {
                          // progress barı gizle
                          Navigator.pop(context);

                          print(e.toString());
                          // hata snackbar'ı göster
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gönderi eklenemedi')),
                          );
                        }
                      }
                    },
                    child: Text('Gönderiyi Yolla'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

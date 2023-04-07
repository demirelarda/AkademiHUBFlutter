import 'package:akademi_hub_flutter/service/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
                  'Diğer',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    Post newPost = Post(
                      id: '',
                      title: _titleController.text,
                      content: _contentController.text,
                      category: _selectedCategory!,
                      createdAt: Timestamp.now(),
                      likes: 0,
                      postScore: 0,
                      sentByUserId: 'someUserId',
                      sentByUserName: 'someUserName',
                    );

                    try {
                      await _firestoreService.addPost(newPost);
                      SnackBar(content: Text('Gönderi Başarıyla Yollandı!'));
                    } catch (e) {
                      print(e.toString());
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
    );
  }
}

import 'package:akademi_hub_flutter/service/authentication_service.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  final AuthenticationService _authService = AuthenticationService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Account Page',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _authService.signOut();
              },
              child: Text('Çıkış Yap'),
            ),
          ],
        ),
      ),
    );
  }
}
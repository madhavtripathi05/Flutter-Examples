import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_app/services/cf_service.dart';
import 'package:material_app/services/firebase_auth_service.dart';

class UserInfo extends StatelessWidget {
  static const routeName = '/user-info';
  final authService = FirebaseAuthService();
  @override
  Widget build(BuildContext context) {
    final user = authService.getUser;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Info'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
                child: user.photoURL != null
                    ? Image.network('${user.photoURL}')
                    : Icon(Icons.verified_user)),
            ListTile(
              title: Text('Email'),
              subtitle: Text('${user.email}'),
            ),
            ListTile(
              title: Text('Name'),
              subtitle: Text('${user.displayName}'),
            ),
            ListTile(
              title: Text('Id'),
              subtitle: Text('${user.uid}'),
            ),
            FutureBuilder(
                future: CfService.addEntry(user.uid),
                builder: (ctx, snapshot) {
                  if (snapshot.data == null) return CircularProgressIndicator();

                  return ListTile(
                    title: Text('Recent activity'),
                    subtitle: Text('${snapshot.data}'),
                  );
                }),
            FlatButton.icon(
              label: Text('sign out'),
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await authService.signOut();
                Get.offNamed('/scaffold-widget');
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:material_app/services/analytics_service.dart';
import 'package:material_app/services/firebase_auth_service.dart';

class FirebaseAuthScreen extends StatefulWidget {
  static const routeName = '/firebase-auth-screen';
  @override
  _FirebaseAuthScreenState createState() => _FirebaseAuthScreenState();
}

class _FirebaseAuthScreenState extends State<FirebaseAuthScreen> {
  bool loading = false;
  final authService = FirebaseAuthService();
  final analytics = AnalyticsService();

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    authService.getUser.isNull
        ? print('authentication required ')
        : Get.toNamed('/user-info');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Auth'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            loading
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text(' signing in...')
                    ],
                  )
                : Text(''),
            FlatButton.icon(
              onPressed: () async {
                loading = true;
                setState(() {});
                if (GetPlatform.isWeb)
                  await authService.signInWithGoogleWeb();
                else
                  await authService.signInWithGoogle();

                await analytics.setUser(
                    'user.uid', 'username', 'user.displayName');

                await analytics.logLogin('Google sign-in');

                loading = false;
                setState(() {});

                Get.toNamed('/user-info');
              },
              icon: Icon(FlutterIcons.google__ent),
              label: Text('Google sign in'),
            ),
            FlatButton.icon(
              onPressed: () => getDialog('sign up'),
              icon: Icon(Icons.person_add),
              label: Text('Register a user'),
            ),
            FlatButton.icon(
              onPressed: () => getDialog('login'),
              icon: Icon(FlutterIcons.email_ent),
              label: Text('Sign in using Email'),
            ),
            FlatButton.icon(
              onPressed: () async {
                await analytics.logLogin('Anonymous');
                loading = true;
                setState(() {});
                await authService.signInAnonymously();
                loading = false;
                setState(() {});
                Get.toNamed('/user-info');
              },
              icon: Icon(FlutterIcons.guest_zoc),
              label: Text('Anonymous sign in'),
            ),
          ],
        ),
      ),
    );
  }

  getDialog(String method) {
    final emailController = TextEditingController();
    final passController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    Get.defaultDialog(
        title: 'Enter your details to continue',
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Text('Enter your Email'),
                TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) =>
                        GetUtils.isEmail(val) ? null : 'enter a valid email'),
                SizedBox(height: 20),
                Text('Enter a password'),
                TextFormField(
                    obscureText: true,
                    controller: passController,
                    validator: (val) =>
                        val.length > 6 ? null : 'enter a valid pass'),
                loading
                    ? CircularProgressIndicator()
                    : FlatButton.icon(
                        label: Text('$method'),
                        icon: Icon(Icons.check),
                        onPressed: () async {
                          if (formKey.currentState.validate()) {
                            loading = true;
                            setState(() {});
                            method == 'login'
                                ? await authService.signInWithEmail(
                                    emailController.text, passController.text)
                                : await authService.signUpWithEmail(
                                    emailController.text, passController.text);

                            loading = false;
                            setState(() {});

                            await analytics.logSignUp('email');
                            Get.back();
                            Get.toNamed('/user-info');
                          }
                        })
              ],
            ),
          ),
        ));
  }
}

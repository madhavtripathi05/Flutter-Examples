import 'package:local_auth/local_auth.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/auth_strings.dart';
import 'dart:io';

class AuthScreen extends StatefulWidget {
  static const routeName = '/local-auth-screen';

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //* helper variables and methods
  LocalAuthentication localAuth = LocalAuthentication();
  List<BiometricType> availableBiometrics = [];
  bool isAuthenticated = false;
  bool fingerprint = false;
  bool faceId = false;
  bool checked = false;

  static const kErrorTextStyle = TextStyle(color: Colors.red, fontSize: 16);
  static const kGeneralTextStyle = TextStyle(color: Colors.blue, fontSize: 16);
  static const kSuccessTextStyle =
      TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    //* checking if a Fingerprint Scanner or FaceId is available on your device
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    //* get the list of available biometric options
    availableBiometrics = await localAuth.getAvailableBiometrics();

    if (canCheckBiometrics) {
      availableBiometrics.forEach((element) {
        setState(() {
          switch (element) {
            case BiometricType.fingerprint:
              fingerprint = true;
              break;
            case BiometricType.face:
              faceId = true;
              break;
            //! Iris is not implemented yet.
            case BiometricType.iris:
              print('Iris is not available!');
              break;
          }
        });
      });
    } else
      print('no biometrics available');
  }

  authenticate() async {
    try {
      bool success = false;
      if (Platform.isIOS) {
        success = await localAuth.authenticateWithBiometrics(
            localizedReason: 'Please authenticate to continue',
            useErrorDialogs: false,
            //* you can also set platform specific messages
            iOSAuthStrings: IOSAuthMessages(
                cancelButton: 'Cancel Authentication',
                goToSettingsButton: 'Settings',
                goToSettingsDescription: 'Please set up your Touch ID.',
                //* if you run out of tries
                lockOut: 'Please Re-enable your Touch ID'));
      } else {
        success = await localAuth.authenticateWithBiometrics(
          //* reason to authenticate
          localizedReason: 'Please authenticate to continue',
          //* turn this true if you want to run app in background
          stickyAuth: true,
        );
      }
      setState(() {
        isAuthenticated = success;
        checked = true;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Auth Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //* if FP Scanner is available show this Widget
            fingerprint
                ? FlatButton.icon(
                    icon: Icon(
                      Icons.fingerprint,
                      color: !checked
                          ? Colors.blue
                          : isAuthenticated ? Colors.green : Colors.red,
                    ),
                    label: !checked
                        ? Text('Authenticate with Fingerprint',
                            style: kGeneralTextStyle)
                        : isAuthenticated
                            ? Text('Successfully Authenticated',
                                style: kSuccessTextStyle)
                            : Text('Authentication Error',
                                style: kErrorTextStyle),
                    onPressed: authenticate,
                  )
                : Text(''),
            SizedBox(
              height: 20,
            ),
            faceId
                ? FlatButton.icon(
                    icon: Icon(
                      Icons.face,
                      color: isAuthenticated ? Colors.green : Colors.blue,
                    ),
                    label: Text('Authenticate with Face'),
                    onPressed: authenticate,
                  )
                : Text(''),
          ],
        ),
      ),
    );
  }
}

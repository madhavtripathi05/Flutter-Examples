import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//* get instance of Firebase Auth
FirebaseAuth auth = FirebaseAuth.instance;

class FirebaseAuthService {
  //* get realtime changes for the current logged in user
  final getUserStream = auth.authStateChanges();

  //* get current user
  final getUser = auth.currentUser;

  //* simplest Auth: Anonymous Sign-in
  Future<void> signInAnonymously() async {
    //* after signing in, get user credentials
    final userCred = await auth.signInAnonymously();
    //* a unique id is assigned to every user
    print(userCred.user.uid);
  }

  //* create a user with email
  Future<void> signUpWithEmail(String email, String pass) async {
    try {
      UserCredential userCred = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);

      print(userCred.user.uid);
    } on FirebaseAuthException catch (e) {
      //* also you can handle some exceptions
      if (e.code == 'weak-password')
        print('The password provided is too weak.');
      else if (e.code == 'email-already-in-use')
        print('The account already exists for that email.');
    } catch (e) {
      print(e.toString());
    }
  }

  //* sign in user with email
  Future<void> signInWithEmail(String email, String pass) async {
    try {
      UserCredential userCred =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      print(userCred.user.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found')
        print('No user found for that email.');
      else if (e.code == 'wrong-password')
        print('Wrong password provided for that user.');
    } catch (e) {
      print(e.toString());
    }
  }

  //* deleting a user
  Future<void> deleteUser(User user) async {
    try {
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login')
        print('The user must re-authenticate before.');
    }
  }

  //* sign out current logged in user
  Future<void> signOut() async => await FirebaseAuth.instance.signOut();

  //* Google sign in
  //* don't forget to add google_sign_in dependency in pubspec
  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, get UserCredential
    final userCred = await auth.signInWithCredential(credential);
    print(userCred.user.uid);
  }

  Future<void> signInWithGoogleWeb() async {
    // Create a new provider
    GoogleAuthProvider googleProvider = GoogleAuthProvider();

    googleProvider
        .addScope('https://www.googleapis.com/auth/contacts.readonly');
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

    // Once signed in, get UserCredential
    final userCred = await auth.signInWithPopup(googleProvider);
    print(userCred.user.uid);
  }
}

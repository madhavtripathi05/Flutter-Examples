import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

final FirebaseAnalytics analytics = FirebaseAnalytics();

class AnalyticsService {
  final FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  // log a custom event
  Future<void> logEvent(String name, Map<String, dynamic> params) async {
    await analytics.logEvent(name: name, parameters: params);
  }

  // log app open event
  Future<void> appOpen() async {
    await analytics.logAppOpen();
  }

  // There are lots of ready-made events:

  Future<void> setUser(String id, String name, String value) async {
    await analytics.setUserId(id);
    await analytics.setUserProperty(name: name, value: value);
  }

  Future<void> logSearch(String data) async {
    await analytics.logSearch(searchTerm: data);
  }

  Future<void> logSignUp(String method) async {
    await analytics.logSignUp(signUpMethod: method);
  }

  Future<void> logLogin(String method) async {
    await analytics.logLogin(loginMethod: method);
  }
  /*
   * Command to log all the events from your phone
   * adb shell setprop debug.firebase.analytics.app com.example.material_app
   */
}

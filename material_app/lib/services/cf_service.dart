import 'package:cloud_functions/cloud_functions.dart';

class CfService {
  static Future<String> addEntry(String uid) async {
    final HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'logCurrentUser');
    HttpsCallableResult result;

    try {
      result = await callable.call(<String, dynamic>{'uid': '$uid'});
      print(result.data['msg']);
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }

    return result.data['msg'];
  }
}

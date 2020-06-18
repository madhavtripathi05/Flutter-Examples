import 'dart:async';

class Validators {
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (email.contains('@') && email.contains('.')) {
      sink.add(email);
    } else {
      sink.addError('Enter a Valid email');
    }
  });
  final validatePass =
      StreamTransformer<String, String>.fromHandlers(handleData: (pass, sink) {
    if (pass.length > 5) {
      sink.add(pass);
    } else {
      sink.addError('Enter at least 6 characters');
    }
  });
}

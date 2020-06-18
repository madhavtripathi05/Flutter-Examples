import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:material_app/bloc/validators.dart';

class MyBloc extends Object with Validators {
  var _emailController = BehaviorSubject<String>();
  var _passController = BehaviorSubject<String>();

  // adding data to stream
  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePass => _passController.sink.add;

  // getting data from stream
  Stream<String> get email => _emailController.stream.transform(validateEmail);
  Stream<String> get pass => _passController.stream.transform(validatePass);

  Stream<bool> get validLogin =>
      CombineLatestStream.combine2(email, pass, (e, p) => true);

  submit() {
    final validEmail = _emailController.value;
    final validPass = _passController.value;

    print('$validEmail is valid');
    print('$validPass is valid');
  }

  void dispose() {
    _emailController.close();
    _passController.close();
  }
}

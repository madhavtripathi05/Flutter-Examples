import 'package:flutter/material.dart';
import 'package:material_app/bloc/my_provider.dart';
import '../bloc/my_bloc.dart';

class BlocLogin extends StatelessWidget {
  static const routeName = '/bloc-login';

  Widget emailField(MyBloc bloc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<String>(
          stream: bloc.email,
          builder: (context, snapshot) {
            return TextField(
              keyboardType: TextInputType.emailAddress,
              onChanged: bloc.changeEmail,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your Email',
                errorText: snapshot.error,
              ),
            );
          }),
    );
  }

  Widget passField(MyBloc bloc) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<String>(
          stream: bloc.pass,
          builder: (context, snapshot) {
            return TextField(
              obscureText: true,
              onChanged: bloc.changePass,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                errorText: snapshot.error,
              ),
            );
          }),
    );
  }

  Widget loginButton(MyBloc bloc) {
    return StreamBuilder<bool>(
        stream: bloc.validLogin,
        builder: (context, snapshot) {
          return RaisedButton(
            child: Text('login'),
            onPressed:
                snapshot.hasError || !snapshot.hasData ? null : bloc.submit,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = MyProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login with Bloc'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          emailField(bloc),
          passField(bloc),
          SizedBox(height: 10),
          loginButton(bloc),
        ],
      ),
    );
  }
}

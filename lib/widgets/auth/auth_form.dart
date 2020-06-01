import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userPassword = '';
  String _userUsername = '';
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      //use those value to send our auth request
      print(_userEmail);
      print(_userPassword);
      print(_userUsername);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                validator: (val) {
                  if (val.isEmpty || !val.contains('@')) {
                    return 'Silahkan masukkan email yang valid';
                  }
                  return null;
                },
                onSaved: (value) {
                  _userEmail = value;
                },
                decoration: InputDecoration(labelText: 'Email Address'),
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty || val.length < 4) {
                    return 'Username tidak boleh kurang dari 4';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Username'),
                onSaved: (value) {
                  _userUsername = value;
                },
              ),
              TextFormField(
                validator: (val) {
                  if (val.isEmpty || val.length < 7) {
                    return 'Password tidak boleh kurang dari 7';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onSaved: (value) {
                  _userPassword = value;
                },
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                onPressed: _trySubmit,
                child: Text('Login'),
              ),
              FlatButton(
                textColor: Theme.of(context).primaryColor,
                onPressed: () {},
                child: Text('Create new account'),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}

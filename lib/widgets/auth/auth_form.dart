import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
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
              ),
              SizedBox(
                height: 12,
              ),
              RaisedButton(
                onPressed: () {},
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

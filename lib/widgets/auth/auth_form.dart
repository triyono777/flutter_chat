import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat/widgets/pickers/user_image_picker.dart';

class AuthForm extends StatefulWidget {
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    File image,
    BuildContext ctx,
  ) submitFn;
  final bool isLoading;
  const AuthForm(this.submitFn, this.isLoading);
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userPassword = '';
  var _userUsername = '';
  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Silahkan pilih gambar'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }
    if (isValid) {
      _formKey.currentState.save();
      //use those value to send our auth request
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userUsername.trim(),
        _isLogin,
        _userImageFile,
        context,
      );
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
              if (!_isLogin)
                UserImagePicker(
                  imageickFn: _pickedImage,
                ),
              TextFormField(
                key: ValueKey('email'),
                autocorrect: false,
                textCapitalization: TextCapitalization.none,
                enableSuggestions: false,
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
              if (!_isLogin)
                TextFormField(
                  key: ValueKey('username'),
                  autocorrect: true,
                  textCapitalization: TextCapitalization.words,
                  enableSuggestions: false,
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
                key: ValueKey('password'),
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
              if (widget.isLoading) CircularProgressIndicator(),
              if (!widget.isLoading)
                RaisedButton(
                  onPressed: _trySubmit,
                  child: Text(_isLogin ? 'Login' : 'Signup'),
                ),
              if (!widget.isLoading)
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                  child: Text(_isLogin
                      ? 'Create new account'
                      : 'Saya Sudah punya akun'),
                ),
            ],
          ),
        ),
      )),
    ));
  }
}

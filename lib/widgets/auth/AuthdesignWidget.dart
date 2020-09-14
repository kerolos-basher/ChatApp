import 'dart:io';

import 'package:flutter/material.dart';
import '../picker/imgpicker.dart';

// ignore: must_be_immutable
class AuthPageDesign extends StatefulWidget {
  bool isloading;
  AuthPageDesign(this.submitform, this.isloading);
  final void Function(String email, String username,File immg ,String password,
      bool islogin, BuildContext ctx) submitform;
  @override
  _AuthPageDesignState createState() => _AuthPageDesignState();
}

class _AuthPageDesignState extends State<AuthPageDesign> {
  final _formKey = GlobalKey<FormState>();
  String _emailAdress = '';
  String _userName = '';
  String _password = '';
  bool _isLogin = true;
  File userimg;
  void _pickedimg(File pickeedimg) {
    userimg = pickeedimg;
  }

  void _trySubmit() {
    
    final isvalidate = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (userimg == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text('please chose an image'),));
      return;
    }
    if (isvalidate) {
      _formKey.currentState.save();
      widget.submitform(_emailAdress.trim(), _userName.trim(), userimg, _password.trim(),
       _isLogin, context);
      // trim علشان لما ابعتها للسيرفر متتبعتش بالمسافات وتعمل ايرور
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (!_isLogin) ImgPicker(_pickedimg),
                  TextFormField(
                    key: ValueKey('emailaddress'),
                 autocorrect: false,
                 textCapitalization: TextCapitalization.none,
                 enableSuggestions: false,
                    decoration: InputDecoration(labelText: 'Email Address'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'In Valid Email Address';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _emailAdress = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                          autocorrect: true,
                 textCapitalization: TextCapitalization.words,
                 enableSuggestions: false,
                      decoration: InputDecoration(labelText: 'User Name'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Pleas Enter User name Maor Than 4 Char';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value.isEmpty || value.length < 6) {
                        return 'Pleas Enter Password Maor Than 6 Char';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  if (widget.isloading) CircularProgressIndicator(),
                  if (!widget.isloading)
                    RaisedButton(
                      child: _isLogin ? Text('Log In') : Text('Sign Up'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isloading)
                    FlatButton(
                      child: _isLogin
                          ? Text('Create New Account')
                          : Text('I allready have An Account'),
                      textColor: Theme.of(context).primaryColor,
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

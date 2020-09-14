import 'package:flutter/material.dart';

class LoginScrreenWidgets extends StatefulWidget {
  final Future<void> Function(String emailId, String password) loginFn;
  LoginScrreenWidgets(this.loginFn);
  @override
  _LoginScrreenWidgetsState createState() => _LoginScrreenWidgetsState();
}

class _LoginScrreenWidgetsState extends State<LoginScrreenWidgets> {
  Map<String, String> _authData = {
    'userid': '',
    'password': '',
  };

  final GlobalKey<FormState> _formKey = GlobalKey();
  final _passwordFocusNode = FocusNode();
  final _loginFocusNode = FocusNode();
  var _isLoding = false;

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _loginFocusNode.dispose();
    super.dispose();
  }

  Future<void> _saveForm() async {
    //Focus.of(context).unfocus(_passwordFocusNode);
    setState(() {
      _isLoding = true;
    });
    final isvalid = _formKey.currentState.validate();
    if (!isvalid) {
      setState(() {
        _isLoding = false;
      });
      return;
    }
    _formKey.currentState.save();
    //print(_authData['password']);
    await widget.loginFn(_authData['userid'], _authData['password']);

    if (this.mounted) {
      setState(() {
        _isLoding = false;
      });
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    final dh = MediaQuery.of(context).size.height;
    final dw = MediaQuery.of(context).size.width;
    //print('${dh.toString()},${dw.toString()}');
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 200,
              width: 215,
              child: Image.asset(
                'assets/images/utulogo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: dh * 0.05,
            ),
            Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Container(
                    width: dw * 0.72,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_passwordFocusNode);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter The Email .';
                            }

                            return null;
                          },
                          onSaved: (value) {
                            _authData['userid'] = value;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          obscureText: true,
                          focusNode: _passwordFocusNode,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context)
                                .requestFocus(_loginFocusNode);
                          },
                          decoration: InputDecoration(labelText: 'Password'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please Enter The EnRoll no.';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        _isLoding
                            ? Container(
                                //margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(3),
                                height: 35,
                                width: 35,
                                child: CircularProgressIndicator(
                                  backgroundColor: Colors.pink.shade300,
                                  strokeWidth: 3,
                                ),
                              )
                            : RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                color: Colors.indigo.shade400,
                                elevation: 0,
                                focusNode: _loginFocusNode,
                                child: Text(
                                  'login',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 3),
                                ),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  _saveForm();
                                })
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

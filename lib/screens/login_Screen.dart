import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:utu_faculty/provider/faculty.dart';
import '../widgets/login_screen_widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = '/loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> _login(String emailid, String password) async {
    try {
      await Provider.of<Faculty>(context, listen: false)
          .login(emailid, password);
    } on PlatformException catch (err) {
      String error = err.message.toString();
      String errormessage = 'Authication Failed !';
      if (error
          .toString()
          .contains(' no user record corresponding to this identifier')) {
        errormessage = 'User not Found !';
      } else if (error.toString().contains('password is invalid')) {
        errormessage = 'Invalid Password';
      } else if (error.toString().contains('email address is badly')) {
        errormessage = 'Invalid Email';
      }
      _showErrorDialog(errormessage);
    } catch (error) {
      _showErrorDialog(error.toString());
    }
  }

  Future<void> _showErrorDialog(String errorMessage) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Error ",
        ),
        content: Row(
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.orange,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              errorMessage,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ],
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text('Done'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginScrreenWidgets(_login),
    );
  }
}

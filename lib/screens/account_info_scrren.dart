import 'package:flutter/material.dart';
import './drawer_screen.dart';
import 'package:provider/provider.dart';
import '../provider/faculty.dart';

class AccountInfoScreen extends StatelessWidget {
  static const routeName = '/AccountInfo';

  @override
  Widget build(BuildContext context) {
    //BuildContext ctx = context;
    try {
      final GlobalKey<ScaffoldState> _scaffoldKey =
          new GlobalKey<ScaffoldState>();
      final da = Provider.of<Faculty>(context).details;
      final Map<String, String> data = {
        'name': da['name'],
        'mailId': da['mailId']
      };
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Text(
                  'Account ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.indigo.shade700),
                ),
                //SizedBox(width: 5,),
                Text(
                  'info',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content:
                          Text('You are not authorization to change data !'),
                      action: SnackBarAction(
                          label: 'Ohk !',
                          onPressed: () =>
                              _scaffoldKey.currentState.hideCurrentSnackBar()),
                      duration: Duration(seconds: 4),
                    ));
                  })
            ],
          ),
          drawer: DrawerScreen(routeName),
          body: SingleChildScrollView(
            child: Container(
              //margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Faculty Detail',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.blue.shade700),
                  ),
                  Divider(),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Name :',
                    style: TextStyle(color: Colors.black45),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    data['name'],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.indigo),
                  ),
                  SizedBox(
                    height: 13,
                  ),

//              Text('EnRoll No :',
//                style: TextStyle(
//                  color : Colors.black45
//                ),
//              ),
//              SizedBox(height: 3,),
//              Text(std.enrollNo.toString(),
//                style: TextStyle(
//                  fontWeight: FontWeight.w500,
//                  fontSize: 20,
//                  color: Colors.indigo
//                ),
//              ),
//              SizedBox(height: 7,),
//              Divider(),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    'Email :',
                    style: TextStyle(color: Colors.black45),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    data['mailId'],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.indigo),
                  ),
//              SizedBox(height: 7,),
//              Divider(),
//              SizedBox(height: 7,),
//              Text('Department :',
//                style: TextStyle(
//                  color : Colors.black45
//                ),
//              ),
//              SizedBox(height: 3,),
//              Text(std.location.department,
//                style: TextStyle(
//                  fontWeight: FontWeight.w500,
//                  fontSize: 20,
//                  color: Colors.indigo
//                ),
//              ),
//              SizedBox(height: 13,),
//
//              Text('course :',
//                style: TextStyle(
//                  color : Colors.black45
//                ),
//              ),
//              SizedBox(height: 3,),
//              Text(std.location.course,
//                style: TextStyle(
//                  fontWeight: FontWeight.w500,
//                  fontSize: 20,
//                  color: Colors.indigo
//                ),
//              ),
//              SizedBox(height: 13,),
//
//              Text('Divison :',
//                style: TextStyle(
//                  color : Colors.black45
//                ),
//              ),
//              SizedBox(height: 3,),
//              Text(std.location.divison,
//                style: TextStyle(
//                  fontWeight: FontWeight.w500,
//                  fontSize: 20,
//                  color: Colors.indigo
//                ),
//              ),
//              SizedBox(height: 13,),
//
//              Text('Batch :',
//                style: TextStyle(
//                  color : Colors.black45
//                ),
//              ),
//              SizedBox(height: 3,),
//              Text(std.location.batch,
//                style: TextStyle(
//                  fontWeight: FontWeight.w500,
//                  fontSize: 20,
//                  color: Colors.indigo
//                ),
//              ),
//              SizedBox(height: 13,),
                ],
              ),
            ),
          ));
    } catch (error) {
      final GlobalKey<ScaffoldState> _scaffoldKey =
          new GlobalKey<ScaffoldState>();
      return Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.ideographic,
              children: <Widget>[
                Text(
                  'Account ',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                      color: Colors.indigo.shade700),
                ),
                //SizedBox(width: 5,),
                Text(
                  'info',
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.black54),
                ),
              ],
            ),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    _scaffoldKey.currentState.hideCurrentSnackBar();
                    _scaffoldKey.currentState.showSnackBar(SnackBar(
                      content:
                          Text('You are not authorization to change data !'),
                      action: SnackBarAction(
                          label: 'Ohk !',
                          onPressed: () =>
                              _scaffoldKey.currentState.hideCurrentSnackBar()),
                      duration: Duration(seconds: 4),
                    ));
                  })
            ],
          ),
          drawer: DrawerScreen(AccountInfoScreen.routeName),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.sentiment_neutral,
                color: Colors.grey[400],
                size: 45,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'Restart Application / Check internet Connection',
                style: TextStyle(color: Colors.grey[400]),
              ),
            ],
          )));
    }
  }
}

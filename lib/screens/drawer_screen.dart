import 'package:flutter/material.dart';
import 'package:utu_faculty/provider/faculty.dart';
import './home_screen.dart';
import './Account_info_scrren.dart';
import 'package:provider/provider.dart';
//import '../main.dart' as main;

class DrawerScreen extends StatelessWidget {
  final routeName;

  DrawerScreen(this.routeName);

  //Widget sideIcons(Icon icon,)

  @override
  Widget build(BuildContext context) {
    //final mediaheight = MediaQuery.of(context).size.height;
    final mediaWidth = MediaQuery.of(context).size;
    return Container(
      height: mediaWidth.height,
      width: mediaWidth.width,
      color: Colors.black54,
      padding: EdgeInsets.only(
        //top: mediaheight*0.065,
        //bottom: MediaQuery.of(context).size.height*0.10,
        left: mediaWidth.width * 0.20,
        right: mediaWidth.width * 0.20,
      ),
      child: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              height: 200,
              width: 100,
              decoration: BoxDecoration(
                // color: Colors.white54,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.network(
                'https://i.postimg.cc/Qdp1cMTy/Uka-Tarsadia-University-Logo-1.png',
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            RaisedButton.icon(
              padding: EdgeInsets.all(18),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.grey[100])),
              onPressed: () {
                //Navigator.pop(context,true);
                if (routeName == HomeScreen.routeName) {
                  Navigator.pop(context);
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  //Navigator.of(context).pushNamed(HomeScreen.routeName);
                }
              },
              color: Colors.grey[100],
              icon: Icon(
                Icons.home,
                color: routeName == HomeScreen.routeName
                    ? Colors.pink.shade300
                    : Colors.black45,
              ),
              label: Text(
                'Home',
                style: TextStyle(
                  color: routeName == HomeScreen.routeName
                      ? Colors.pink.shade300
                      : Colors.black54,
                  //fontSize: 20
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            RaisedButton.icon(
              padding: EdgeInsets.all(18),

              onPressed: () {
                if (routeName == HomeScreen.routeName) {
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(AccountInfoScreen.routeName);
                } else {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed(AccountInfoScreen.routeName);
                }
                //Navigator.of(context).pushReplacementNamed(AccountInfoScreen.routeName);
              },
              color: Colors.grey[100],
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.grey[100])),
              icon: Icon(
                Icons.assignment,
                color: routeName == AccountInfoScreen.routeName
                    ? Colors.pink.shade300
                    : Colors.black54,
              ),
              // borderSide: routeName == AccountInfoScreen.routeName
              //     ? BorderSide(color: Colors.pink.shade300, width: 1)
              //     : null,
              label: Text(
                'Account',
                style: TextStyle(
                  color: routeName == AccountInfoScreen.routeName
                      ? Colors.pink.shade300
                      : Colors.black54,
                ),
              ),
            ),
            SizedBox(
              height: 250,
            ),
//            OutlineButton.icon(
//              onPressed: (){
//                if(routeName == HomeScreen.routeName){
//                  Navigator.pop(context);
//                  Navigator.of(context).pushNamed(HelpScreen.routeName);
//                }
//                else{
//                  Navigator.pop(context);
//                  Navigator.pop(context);
//                  Navigator.of(context).pushNamed(HelpScreen.routeName);
//                }
//                //Navigator.of(context).pushReplacementNamed(HelpScreen.routeName);
//              },
//              icon: Icon(Icons.help_outline,
//                color: routeName == HelpScreen.routeName ?  Colors.pink.shade300: Colors.white,
//              ),
//              borderSide: routeName == HelpScreen.routeName ? BorderSide(
//                color : Colors.pink.shade300,
//                width: 1
//              ) : null ,
//              label: Text('Help',
//                style: TextStyle(
//                   color:routeName == HelpScreen.routeName ?  Colors.pink.shade300: Colors.white,
//                ),
//              ),
//            ),
//            SizedBox(height: 15,),
            RaisedButton.icon(
              padding: EdgeInsets.all(18),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Faculty>(context, listen: false).logout();
                //FirebaseAuth.instance.signOut();
              },
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                  side: BorderSide(color: Colors.red)),
              color: Colors.red,
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text(
                'Logout',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}

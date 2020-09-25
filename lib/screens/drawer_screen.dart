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
    final mediaWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.only(
        //top: mediaheight*0.065,
        //bottom: MediaQuery.of(context).size.height*0.10,
        left: mediaWidth * 0.20,
        right: mediaWidth * 0.20,
      ),
      child: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(
              height: 30,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white54,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Image.asset(
                'assets/images/utulogo.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            OutlineButton.icon(
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
              icon: Icon(
                Icons.home,
                color: routeName == HomeScreen.routeName
                    ? Colors.pink.shade300
                    : Colors.white,
              ),
              borderSide: routeName == HomeScreen.routeName
                  ? BorderSide(color: Colors.pink.shade300, width: 1)
                  : null,
              label: Text(
                'Home',
                style: TextStyle(
                  color: routeName == HomeScreen.routeName
                      ? Colors.pink.shade300
                      : Colors.white,
                  //fontSize: 20
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
//            OutlineButton.icon(
//              onPressed: (){
//                if(routeName == HomeScreen.routeName){
//                  Navigator.pop(context);
//                  Navigator.of(context).pushNamed(StudentLoginScreen.routeName);
//                }
//                else{
//                  Navigator.pop(context);
//                  Navigator.pop(context);
//                  Navigator.of(context).pushNamed(StudentLoginScreen.routeName);
//                }
//              },
//              icon: Icon(Icons.person,
//                color: routeName == StudentLoginScreen.routeName ?  Colors.pink.shade300: Colors.white,
//              ),
//              borderSide: routeName == StudentLoginScreen.routeName ? BorderSide(
//                color : Colors.pink.shade300,
//                width: 1
//              ) : null ,
//              label: Text('Student Login',
//                style: TextStyle(
//                  color: routeName == StudentLoginScreen.routeName ?  Colors.pink.shade300: Colors.white,
//                  //fontSize: 20
//                ),),
//            ),
//            SizedBox(height: 15,),
//            OutlineButton.icon(
//              onPressed: (){
//                if(routeName == HomeScreen.routeName){
//                  Navigator.pop(context);
//                  Navigator.of(context).pushNamed(SisScreen.routeName);
//                }
//                else{
//                  Navigator.pop(context);
//                  Navigator.pop(context);
//                  Navigator.of(context).pushNamed(SisScreen.routeName);
//                }
//              },
//              icon: Icon(Icons.assignment_ind,
//                color: routeName == SisScreen.routeName ?  Colors.pink.shade300: Colors.white,),
//              label: Text('SiS',
//                style: TextStyle(
//                  color: routeName == SisScreen.routeName ?  Colors.pink.shade300: Colors.white,
//                  //fontSize: 20
//                ),
//              ),
//              borderSide: routeName == SisScreen.routeName ? BorderSide(
//                color : Colors.pink.shade300,
//                width: 1
//              ) : null ,
//              color: Colors.indigo.shade700
//            ),
//            SizedBox(height: 15,),
            OutlineButton.icon(
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
              icon: Icon(
                Icons.assignment,
                color: routeName == AccountInfoScreen.routeName
                    ? Colors.pink.shade300
                    : Colors.white,
              ),
              borderSide: routeName == AccountInfoScreen.routeName
                  ? BorderSide(color: Colors.pink.shade300, width: 1)
                  : null,
              label: Text(
                'Account',
                style: TextStyle(
                  color: routeName == AccountInfoScreen.routeName
                      ? Colors.pink.shade300
                      : Colors.white,
                ),
              ),
            ),
            SizedBox(
              height: 15,
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
            OutlineButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Faculty>(context, listen: false).logout();
                //FirebaseAuth.instance.signOut();
              },
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

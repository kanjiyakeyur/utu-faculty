import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../screens/add_notification_screen.dart';
import './drawer_screen.dart';
import '../provider/notification.dart';
import '../widgets/show_notification.dart';
import 'package:provider/provider.dart';
import '../provider/faculty.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/homeScreen';
  @override
  Widget build(BuildContext context) {
    //final fatchOrNot =
    //    Provider.of<UtuNotification>(context, listen: false).fatchedData;
    final userUid = Provider.of<Faculty>(context).userid;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: <Widget>[
            Text(
              'UTU ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.indigo.shade700),
            ),
            //SizedBox(width: 5,),
            Text(
              'Faculty',
              style: TextStyle(
                  //fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black54),
            ),
          ],
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(AddNotificationScreen.routeName);
              })
        ],
      ),
      drawer: DrawerScreen(routeName),
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('notification')
            .orderBy('datetime')
            .where('byid', isEqualTo: userUid)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final d = snapshot.data.documents;
          final data = d.reversed.toList();
          if (data.length == 0) {
            return Center(
              child: Text('Empty'),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (ctx, index) {
              return Padding(
                padding: const EdgeInsets.only(top: 5, right: 5, left: 5),
                child: ShowNotification(
                  data: NotificationType(
                    id: data[index].documentID,
                    title: data[index]['title'],
                    discription: data[index]['description'],
                    datetime: DateTime.parse(data[index]['datetime']),
                    department: UtuDepartment(
                      department: data[index]['location']['department'],
                      course: data[index]['location']['course'],
                      divison: data[index]['location']['divison'],
                      batch: data[index]['location']['batch'],
                    ),
                    by: data[index]['by'],
                    byid: data[index]['byid'],
                    expiredate: data[index]['expiredate'],
                    link: data[index]['link'],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: RaisedButton.icon(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          color: Colors.indigo.shade400,
          elevation: 0,
          label: Text(
            'Send',
            style: TextStyle(
                letterSpacing: 2,
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.w300),
          ),
          icon: Icon(
            Icons.near_me,
            color: Colors.white,
            size: 17,
          ),
          onPressed: () {
            Navigator.of(context).pushNamed(AddNotificationScreen.routeName);
          }),
    );
  }
}

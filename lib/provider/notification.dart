import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
//import './httpExeption.dart';
//import 'package:utu_faculty/provider/utuNotificationType.dart';

class UtuDepartment {
  String department;
  String course;
  String divison;
  String batch;

  UtuDepartment({
    this.department,
    this.course,
    this.divison,
    this.batch,
  });
}

class NotificationType {
  final String id;
  final String title;
  final String discription;
  final DateTime datetime;
  final String expiredate;
  final UtuDepartment department;
  final String byid;
  final String by;
  final String link;
  final String imageUrl;
  NotificationType({
    @required this.id,
    @required this.title,
    @required this.discription,
    @required this.datetime,
    @required this.expiredate,
    @required this.department,
    @required this.by,
    @required this.byid,
    @required this.link,
    @required this.imageUrl,
  });
}

class UtuNotification with ChangeNotifier {
  Future<void> sendNotification({
    String title,
    String description,
    String department,
    String course,
    String divison,
    String batch,
    String userid,
    String userName,
    String expiredate,
    String link,
    File image,
  }) async {
    try {
      final DateTime datetime = DateTime.now();
      var imgUrl = "EmptyImage";
      if (image != null) {
        final ref = FirebaseStorage.instance
            .ref()
            .child('Image')
            .child(datetime.toString() + userid + '.jpg');
        await ref.putFile(image).onComplete;
        //image link
        imgUrl = await ref.getDownloadURL();
      }

      await Firestore.instance.collection('notification').add({
        'title': title,
        'description': description,
        'datetime': datetime.toIso8601String(),
        'by': userName,
        'byid': userid,
        'location': {
          'department': department,
          'course': course,
          'divison': divison,
          'batch': batch
        },
        'expiredate': expiredate,
        'link': link,
        'image': imgUrl,
      });
    } catch (error) {
      throw error;
    }
  }

  Future<void> updateNotification({
    String id,
    String title,
    String description,
    String department,
    String course,
    String divison,
    String batch,
    String userid,
    String userName,
    String expiredate,
    String link,
    DateTime oldSendDate,
    File image,
    String imageUrl,
  }) async {
    try {
      if (image != null) {
        print(imageUrl);
        if (imageUrl == "EmptyImage") {
          final ref = FirebaseStorage.instance
              .ref()
              .child('Image')
              .child(oldSendDate.toString() + userid + '.jpg');
          await ref.putFile(image).onComplete;
          //image link
          imageUrl = await ref.getDownloadURL();
        } else {
          final ref = FirebaseStorage.instance
              .ref()
              .child('Image')
              .child(oldSendDate.toString() + userid + '.jpg');
          await ref
              .delete()
              .whenComplete(() async => await ref.putFile(image).onComplete);
          //await ref.putFile(image).onComplete;
          //image link
          imageUrl = await ref.getDownloadURL();
        }
      }
      await Firestore.instance
          .collection('notification')
          .document(id)
          .updateData({
        'title': title,
        'description': description,
        'datetime': oldSendDate.toIso8601String(),
        'by': userName,
        'byid': userid,
        'location': {
          'department': department,
          'course': course,
          'divison': divison,
          'batch': batch
        },
        'expiredate': expiredate,
        'link': link,
        'image': imageUrl,
      }).then((value) =>
              print("__________________________________Succes_______"));
    } catch (error) {
      throw error;
    }
  }

//  _addNotification(List xyz, String id, dynamic data) {
//    xyz.add(
//      NotificationType(
//        id: id.toString(),
//        title: data['title'].toString(),
//        discription: data['discription'].toString(),
//        datetime: DateTime.parse(data['datetime']),
//        department: UtuDepartment(
//            department: data['department']['department'].toString(),
//            course: data['department']['course'].toString(),
//            divison: data['department']['divison'].toString(),
//            batch: data['department']['batch'].toString()),
//        by: data['by'].toString(),
//        byid: data['byid'].toString(),
//      ),
//    );
//    //notifyListeners();
//  }

//  Future<void> fatchAndSet()async{
//    try
//    {
//    final url = 'https://utuconnect.firebaseio.com/notifications.json?auth=$_token';
//    final response = await http.get(url);
//    final responseData = json.decode(response.body) as Map<String,dynamic>;
//    if(responseData == null){
//      return ;
//    }
//    List<NotificationType> reloadDataList =[];
//    responseData.forEach((id, data) {
//      if(data['by'] == _userName && data['byid'] == _userId){
//        _addNotification(reloadDataList,id, data);
//      }
//    });
//    _notification = reloadDataList;
//     _fatchData = true;
//    notifyListeners();
//    }
//    catch(error){
//      throw error;
//    }
//  }

  Future<void> removeNotification(NotificationType data) async {
    try {
      await Firestore.instance
          .collection('notification')
          .document(data.id)
          .delete();
      if (data.imageUrl != "EmptyImage")
        await FirebaseStorage.instance
            .ref()
            .child("Image")
            .child(data.datetime.toString() + data.byid + ".jpg")
            .delete();
    } catch (error) {
      throw error;
    }
  }
}

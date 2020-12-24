import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart' as im;

class ImagePicker extends StatefulWidget {
  ImagePicker(this.imgPickerFn, this.newuser);
  final bool newuser;
  final void Function(File pickedImage) imgPickerFn;
  @override
  _ImagePickerState createState() => _ImagePickerState();
}

class _ImagePickerState extends State<ImagePicker> {
  File _pickedImage;

  void _openGallery(BuildContext context) async {
    var picture = await im.ImagePicker.pickImage(
        source: im.ImageSource.gallery,
        imageQuality: 70,
        maxWidth: 400,
        maxHeight: 400);
    this.setState(() {
      _pickedImage = picture;
    });
    Navigator.of(context).pop();
    widget.imgPickerFn(_pickedImage);
  }

  void _openCamera(BuildContext context) async {
    var picture = await im.ImagePicker.pickImage(
        source: im.ImageSource.camera,
        imageQuality: 70,
        maxWidth: 400,
        maxHeight: 400);
    this.setState(() {
      _pickedImage = picture;
    });
    Navigator.of(context).pop();
    widget.imgPickerFn(_pickedImage);
  }

  Future<void> _showSelectionDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("From where do you want to take the photo?"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Gallery"),
                      onTap: () {
                        _openGallery(context);
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Camera"),
                      onTap: () {
                        _openCamera(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        if (widget.newuser)
          CircleAvatar(
            radius: 40,
            backgroundImage: _pickedImage != null
                ? FileImage(_pickedImage)
                : AssetImage(
                    'assets/images/user.png',
                  ),
          ),
        if (!widget.newuser && _pickedImage != null)
          Container(
            child: Image.file(_pickedImage),
          ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
              onPressed: () => _showSelectionDialog(context),
              child: Row(
                children: <Widget>[
                  Icon(Icons.image),
                  SizedBox(
                    width: 10,
                  ),
                  Text('pick image'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

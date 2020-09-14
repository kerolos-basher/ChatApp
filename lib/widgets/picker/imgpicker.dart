import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class ImgPicker extends StatefulWidget {
  void Function (File pickeedimg) pickedimg;
  ImgPicker(this.pickedimg);
  @override
  _ImgPickerState createState() => _ImgPickerState();
}
class _ImgPickerState extends State<ImgPicker> {
  File _image;
  Future _picAnImg() async {
    // ignore: deprecated_member_use
    final pickedFile = await ImagePicker.pickImage(source: ImageSource.gallery,
    imageQuality: 70,
    maxWidth: 200);
    setState(() {
      _image = pickedFile;
    });
    widget.pickedimg(_image);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
            backgroundImage: _image != null ? FileImage(_image): null,
          ),
          FlatButton.icon(
            onPressed:_picAnImg,
            icon: Icon(Icons.image),
            label: Text('AddImg'),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );
  }
}

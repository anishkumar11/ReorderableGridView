import 'dart:io';

import 'package:assignment/configs/AppColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageViewerScreen extends StatefulWidget {

  String imageLink = "";

  ImageViewerScreen(String imageLink){
    this.imageLink = imageLink;
  }
  @override
  _ImageViewerScreenState createState() => _ImageViewerScreenState(imageLink);
}

class _ImageViewerScreenState extends State<ImageViewerScreen> {

  String imageLink = "";

  _ImageViewerScreenState(String imageLink){
    this.imageLink = imageLink;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: new AppBar(
        backgroundColor: AppColors.appBarBackgrounColor,
        elevation: 0,
      ),
      body: new Padding(
        padding: new EdgeInsets.only(top: 0, bottom: 1),
        child: setUpViewPage(),
      ),
    );
  }

  Widget setUpViewPage() {
    return Container(
        child: PhotoView(
          imageProvider: FileImage(File(imageLink)),
        )
    );
  }
}

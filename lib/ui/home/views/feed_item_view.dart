import 'dart:io';

import 'package:assignment/configs/AppColors.dart';
import 'package:assignment/configs/AssetsImages.dart';
import 'package:assignment/core/models/feed.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FeebItemView extends StatelessWidget {

  Feed item;
  double viewWidth = 0;
  // ignore: use_key_in_widget_constructors
  FeebItemView(Feed item) {
    this.item = item;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(padding: EdgeInsets.only(left: 0, right: 0, top: 10, bottom: 10),
      child: getItemView(context),);
  }

  Widget getItemView(BuildContext context) {
    viewWidth = MediaQuery
        .of(context)
        .size
        .width / 2;

    double viewHeight = viewWidth + MediaQuery
        .of(context)
        .size
        .width / 5;

    /*return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: viewWidth,
          height: viewHeight,
          margin: EdgeInsets.only(left: 5, right: 5),
          decoration: BoxDecoration(
              image: getBgImageView(),
              border: Border.all(color: Colors.black12),
              borderRadius: BorderRadius.all(Radius.circular(5))
          ),
        ),
        SizedBox(height: 10,),
        CommonWidgetUtils.getLabel2(item.title, 12, FontWeight.w500, AppColors.color_post_text)
      ],
    );*/
    return Stack(
      children: [
        Padding(padding: EdgeInsets.only(bottom: 15),
          child: GestureDetector(
            onTap: (){
              Utils.showImageViewerScreen(context, item.imagePath);
            },
            child: Container(
              width: viewWidth,
              height: viewHeight,
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                  image: getBgImageView(),
                  border: Border.all(color: Colors.black12),
                  borderRadius: BorderRadius.all(Radius.circular(5))),
              child: Container(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[],
                  )
              ),
            ),
          ),),
        Positioned.fill(
            child: Align(alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.only(top: 10),
                child: CommonWidgetUtils.getLabel2(item.title,
                    14, FontWeight.w400, AppColors.color_post_text),
              ),))
      ],
    );
  }

  DecorationImage getBgImageView(){
    String url = item.imagePath;
    if(!Utils.isEmpty(url)){
      return DecorationImage(
          image: FileImage(File(item.imagePath)),
          fit: BoxFit.cover,);
    }else {
      return DecorationImage(
          image: AssetImage(
              AssetsImages.placeHolder),
          fit: BoxFit.cover);
    }
  }


  Widget getActionBtn(String labelStr) {
    return GestureDetector(
      onTap: () {
      },
      child: Container(
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            gradient: new LinearGradient(
              colors: [
                AppColors.colorPrimary, //start
                AppColors.colorPrimary, //center
                AppColors.colorPrimary, //end
              ],
            )),
        padding: const EdgeInsets.only(left:10.0, right: 10, top:5, bottom: 5),
        child: Text(
          labelStr,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w400, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

}

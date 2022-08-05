
import 'package:assignment/configs/AppColors.dart';
import 'package:assignment/core/constants.dart';
import 'package:assignment/ui/home/new_image_screen.dart';
import 'package:assignment/ui/widgets/image_viewer_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class Utils {

  
  static bool isEmpty(String str) {
    if (str == null || str.length == 0 || str.contains("null")) {
      return true;
    }
    return false;
  }
  static bool StringEqualIgnoreCase(String str1, String str2){
    if(str1.toLowerCase().compareTo(str2.toLowerCase()) == 0){
      return true;
    }
    return false;
  }



  static void closeScreen(BuildContext context){Navigator.pop(context);}



  static void sendBroadcast(String event){
      if(Constants.eventBus != null){
        Constants.eventBus.fire(event);
      }
  }

  static void showImageViewerScreen(BuildContext context, String url){
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new ImageViewerScreen(url)));
  }


  static void showToast(BuildContext context, String message){
    if (context!=null) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: AppColors.colorPrimary,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

}

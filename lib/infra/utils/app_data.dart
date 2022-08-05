
import 'dart:convert';

import 'package:assignment/core/models/feed.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppData {

  static void saveFeedData(List<Feed> dataList) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('userData', getPostData(dataList));
  }

  static String getPostData(List<Feed> dataList) {

    var postData = {
      "status": 200,
      "data": "dataList",
    };
    var data = jsonEncode(postData);
    String postDataStr = data.toString().replaceAll("dataList", jsonEncode(dataList));
    postDataStr = postDataStr.replaceAll("\"[", "[");
    postDataStr = postDataStr.replaceAll("]\"", "]");
    return postDataStr;
  }
}

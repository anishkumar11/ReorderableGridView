import 'dart:convert';

import 'package:assignment/core/models/feed.dart';


class ResponseParser {

  static List<Feed> parseFeedListData(String response) {
    var tagObjsJson = jsonDecode(response)['data'] as List;
    List<Feed> list = tagObjsJson.map((tagJson) => Feed.fromJson(tagJson)).toList();
    return list;
  }

}

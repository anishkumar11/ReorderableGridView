
import 'package:assignment/core/models/feed.dart';
import 'package:event_bus/event_bus.dart';

class Constants {
  static EventBus eventBus;
  static List<Feed> dataList = null;

  static final String

      REFRESH_HOME_LIST_BROADCASTE_RECEIVER_ACTION = "REFRESH_HOME_LIST";
}

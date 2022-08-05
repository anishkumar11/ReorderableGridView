import 'dart:async';

import 'package:assignment/configs/AppColors.dart';
import 'package:assignment/configs/LocalString.dart';
import 'package:assignment/core/constants.dart';
import 'package:assignment/core/models/feed.dart';
import 'package:assignment/infra/network/ResponseParse.dart';
import 'package:assignment/infra/utils/app_data.dart';
import 'package:assignment/ui/home/views/feed_item_view.dart';
import 'package:assignment/ui/widgets/bottom_nav_bar.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:reorderable_grid_view/reorderable_grid_view.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  //For pagination
  ScrollController _scrollController = ScrollController();
  bool _processApi = false,
      _lastData = false;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registerEventListener();
    _scrollController.addListener(_onScroll);
    fetchFeedData();
  }

  void _onScroll() {
    double maxScroll = _scrollController.position.maxScrollExtent;
    double currentScroll = _scrollController.position.pixels;
    if (currentScroll == maxScroll) {
      if (_lastData && !_processApi) {
        fetchFeedData();
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      drawerEnableOpenDragGesture: true,
      backgroundColor: AppColors.backgroundColor,
      appBar: new AppBar(
        backgroundColor: AppColors.appBarBackgrounColor,
          elevation: 0,
          centerTitle: false,
          title: CommonWidgetUtils.getLabel2(LocalString.kAppName, 16, FontWeight.w500, AppColors.color_post_text),
      ),
      body: new Padding(
        padding: new EdgeInsets.only(top: 0, bottom: 1),
        child: setUpViewPage(),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }

  Widget setUpViewPage() {
    return new SafeArea(
        bottom: false,
        child: Container(
            width: double.infinity,
            child: getListView()));
  }


  Widget getListView() {
    if (Constants.dataList == null) {
      return Container(
          margin: EdgeInsets.symmetric(vertical: 50.0),
          child: SpinKitThreeBounce(
            color: AppColors.colorPrimary,
            size: 20.0,
          ));
    }else if(Constants.dataList.isEmpty){
      return Center(
        child: CommonWidgetUtils.getLabel2(LocalString.empty_data,
            14, FontWeight.w400, AppColors.color_post_text),
      );
    }else{
      return getGridView();
      /*return ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [
          StaggeredGrid.count(
              crossAxisCount: 2,
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              children: List.generate(Constants.dataList.length, (index) {
                return FeebItemView(Constants.dataList.elementAt(index));
              })
          ),
        ],
      );*/
    }
  }

  Widget getGridView() {

    /*return ListView(
      physics: BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: [
        StaggeredGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            children: List.generate(Constants.dataList.length, (index) {
              return FeebItemView(Constants.dataList.elementAt(index));
            })
        ),
      ],
    );*/
    return ReorderableGridView.count(
      crossAxisCount: 2,
      children: List.generate(Constants.dataList.length, (index) {
          var item = Constants.dataList.elementAt(index);
          return Container(
            key: ValueKey(item.id),
            child: FeebItemView(item),
          );
        }),
      /*children: Constants.dataList.map((Feed item) => Container(
        key: ValueKey(item.id),
        child: FeebItemView(item),
      )).toList(),*/
      onReorder: (oldIndex, newIndex) {
        setState(() {
          final element = Constants.dataList.removeAt(oldIndex);
          Constants.dataList.insert(newIndex, element);
          AppData.saveFeedData(Constants.dataList);
        });
      },
    );

    /*return ReorderableGridView.count(
      crossAxisCount: 2,
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: List.generate(Constants.dataList.length, (index) {
        return FeebItemView(Constants.dataList.elementAt(index));
      }),
      onReorder: (oldIndex, newIndex) {
        setState(() {
          final element = Constants.dataList.removeAt(oldIndex);
          Constants.dataList.insert(newIndex, element);
          AppData.saveFeedData(Constants.dataList);
        });
      },
    );*/
  }

  Future<void> fetchFeedData() async {

    _processApi = true;

    String resStr = "";
    SharedPreferences pref = await SharedPreferences.getInstance();
    if(pref.containsKey('userData')){
      resStr = pref.getString('userData');
    }

    List<Feed> list = ResponseParser.parseFeedListData(resStr);

    if(Constants.dataList == null){
      Constants.dataList = list;
    }else {
      Constants.dataList.addAll(list);
    }
    if(list != null && list.length > 0){
      _lastData = true;
    }else{
      _lastData = false;
    }
    page++;
    setState(() {
      _processApi = false;
    });
  }


  /**
   * Broadcaste event listener
   */

  StreamSubscription receiver;

  @override
  void dispose() {
    unRegisterEventListener();
    super.dispose();
  }

  void registerEventListener() {

    receiver = Constants.eventBus.on().listen((event) {
      print("home::event.toString() = " + event.toString());
      // Print the runtime type. Such a set up could be used for logging.
      if (event.toString().indexOf(Constants.REFRESH_HOME_LIST_BROADCASTE_RECEIVER_ACTION) >=0) {
        //Utils.closeScreen(context);
        setState(() {
          Constants.dataList = null;
          page = 1;
          fetchFeedData();
        });
      }
    });
  }

  void unRegisterEventListener() {
    try {
      if (receiver != null) {
        receiver.cancel();
      }
    } catch (myemailError) {}
  }
}

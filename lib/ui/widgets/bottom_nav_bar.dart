
import 'package:assignment/configs/AppColors.dart';
import 'package:assignment/configs/AssetsImages.dart';
import 'package:assignment/configs/LocalString.dart';
import 'package:assignment/core/models/feed.dart';
import 'package:assignment/ui/home/new_image_screen.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class BottomNavBar extends StatefulWidget {

  // ignore: use_key_in_widget_constructors
  BottomNavBar(){}

  @override
  _BottomNavBarState createState() =>
      _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {

  int PICKER_TYPE_IMAGE_GALLERY = 1,
      PICKER_TYPE_IMAGE_CAMMER = 2;

  // ignore: use_key_in_widget_constructors
  _BottomNavBarState(){}

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IgnorePointer(ignoring: false, child: setUpItemView());
  }

  Widget setUpItemView() {
    return setUpBottomNavBar();
  }

  Widget setUpBottomNavBar(){
    return Container(
      color: AppColors.colorPrimary,
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
              icon: getImageActionBtn(PICKER_TYPE_IMAGE_GALLERY),
              label: ""),

          BottomNavigationBarItem(
              icon: getImageActionBtn(PICKER_TYPE_IMAGE_CAMMER),
              label: ""),

        ],
        currentIndex: 0,
        onTap: _onItemTapped,
      ) /* add child content here */,
    );
  }



  void _onItemTapped(int index) {
    setState(() {
      //_selectedIndex = index;
      if(index == 0){ //Shop

      }
      else if (index == 1) {

      }
    });
  }

  Widget getImageActionBtn(int actionType) {

    if(actionType == PICKER_TYPE_IMAGE_CAMMER){//Camera
      return GestureDetector(
        onTap: (){
          pickImageAction(actionType);
        },
        child: Column(
          children: [
            Icon(
              Icons.camera_enhance,
              size: 20,
              color: Colors.white,
            ),
            Padding(padding: EdgeInsets.only(top: 2),
              child: CommonWidgetUtils.getLabel2(LocalString.camera, 11, FontWeight.w500, Colors.white),)
          ],
        ),
      );
    }else if(actionType == PICKER_TYPE_IMAGE_GALLERY){//Gallery
      return GestureDetector(
        onTap: (){
          pickImageAction(actionType);
        },
        child: Column(
          children: [
            Icon(
              Icons.photo,
              size: 20,
              color: Colors.white,
            ),
            Padding(padding: EdgeInsets.only(top: 2),
            child: CommonWidgetUtils.getLabel2(LocalString.gallery, 11, FontWeight.w500, Colors.white),)
          ],
        ),
      );
    }
  }

  Future<void> pickImageAction(int actionType) async{
    final ImagePicker _picker = ImagePicker();

    if(actionType == PICKER_TYPE_IMAGE_GALLERY){
      // Pick an image
      XFile _image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
      showNewImageScreen(context, _image);
    }else if(actionType == PICKER_TYPE_IMAGE_CAMMER){
      // Pick an image
      XFile _image = await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
      showNewImageScreen(context, _image);
    }

  }

   void showNewImageScreen(BuildContext context, XFile item){
    Navigator.push(context,
        new MaterialPageRoute(builder: (context) => new NewImageScreen(item)));
  }
}

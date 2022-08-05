import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:assignment/configs/AppColors.dart';
import 'package:assignment/configs/AssetsImages.dart';
import 'package:assignment/configs/LocalString.dart';
import 'package:assignment/core/constants.dart';
import 'package:assignment/core/keyboard_utils.dart';
import 'package:assignment/core/models/feed.dart';
import 'package:assignment/core/utils.dart';
import 'package:assignment/infra/utils/app_data.dart';
import 'package:assignment/widgets/common_widget_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class NewImageScreen extends StatefulWidget {

  XFile link;
  NewImageScreen(XFile link) {
    this.link = link;
  }

  @override
  _NewImageScreenState createState() => _NewImageScreenState(link);
}

class _NewImageScreenState extends State<NewImageScreen> {


   String _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
   Random _rnd = Random();

  final TextEditingController _titleEditingController = TextEditingController();

  String titleError = "";


  XFile _image = null;
  

  int INPUT_TYPE_TEXT = 1;

  _NewImageScreenState(XFile link) {
    this._image = link;
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
      backgroundColor: Colors.white,
      appBar: new AppBar(
          centerTitle: true,
          title: new Text(
            LocalString.add_image,
            style:
            TextStyle(color: Colors.black, fontSize: 16.0),
          )),
      body: new Padding(
        padding: new EdgeInsets.only(left: 30, right: 30, bottom: 20),
        child: setUpViewPage(),
      ),
    );
  }


  Widget setUpViewPage() {
    return new SafeArea(
        bottom: false,
        child: Container(
            height: double.infinity,
            width: double.infinity,
            child: SingleChildScrollView(
                padding: EdgeInsets.only(top: 0, bottom: 15),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: getDataFields(),
                ))));
  }

  List<Widget> getDataFields(){
    List<Widget> list = [];

    list.add(SizedBox(height: 10,));

    if(_image != null){
      list.add(Center(child: Image.file(File(_image.path),fit: BoxFit.cover,)));
    }

    addTextView(LocalString.image_title,
        _titleEditingController,
        INPUT_TYPE_TEXT,
        titleError,
        list);

    list.add(SizedBox(
      height: 20,
    ));

    list.add(Padding(
      padding: new EdgeInsets.fromLTRB(0, 30, 0, 10),
      child: getSubmitButton(),
    ));


    return list;
  }

  

  void addTextView(String label,
      TextEditingController editingController,
      int inputType,
      String error, List<Widget> list) {

    list.add(Padding(
      padding: new EdgeInsets.only(top: 20),
      child: CommonWidgetUtils.getLabel2(label,
          14, FontWeight.w700, AppColors.color_post_text),
    ));
    list.add(Padding(
      padding: new EdgeInsets.only(top: 10),
      child: getTextField(editingController, inputType),
    ));
    list.add(getErrorLabel(error));
  }


  Widget getErrorLabel(String errorMsg) {
    if(!Utils.isEmpty(errorMsg)){
      return new Padding(
        padding: new EdgeInsets.only(top: 5, left: 5),
        child: CommonWidgetUtils.getLabel2(errorMsg,
            11, FontWeight.w500, Colors.red),
      );
    }
    return Container();
  }

  Widget getSubmitButton() {
    return GestureDetector(
      onTap: () {
        submitAction(context);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: new BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: new LinearGradient(
              colors: [
                AppColors.colorPrimary, //start
                AppColors.colorPrimary, //center
                AppColors.colorPrimary, //end
              ],
            )),
        padding: const EdgeInsets.all(10.0),
        child: Text(
          LocalString.submit,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget getTextField(TextEditingController editingController ,int inputType) {
    TextInputType textInputType = TextInputType.text;
    int maxlines = null;
    if(inputType == INPUT_TYPE_TEXT){
      maxlines = 1;
    }

    return Container(
        decoration: new BoxDecoration(
          color: Colors.black.withAlpha(10),
          shape: BoxShape.rectangle,
          border: Border.all(color: Colors.black.withAlpha(10)),
          borderRadius: BorderRadius.circular(5.0),
        ),
        padding: const EdgeInsets.only(left: 10, right: 10,),
        child: SizedBox(
          child: TextField(
              controller: editingController,
              keyboardType: textInputType,
              maxLines: maxlines,
              textCapitalization: TextCapitalization.sentences,
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black
              ),
              decoration: InputDecoration(
                fillColor: Colors.grey,
                border:InputBorder.none,
              )
          ),
        ));
  }

  


  void cancelAllError() {
    setState(() {
      this.titleError = "";

    });
  }



  void submitAction(BuildContext context) {
    KeyboardUtils.closeKeyboard(context);
    cancelAllError();

    if(Utils.isEmpty(_titleEditingController.text.trim())){
      setState(() {
        titleError = LocalString.required;
      });
      return;
    }
    doSubmit();
  }


  String getUDIDString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<void> doSubmit() async {

    Feed pi = Feed();
    pi.id = getUDIDString(6);
    pi.title = _titleEditingController.text.trim();
    pi.imagePath = _image.path;

    if(Constants.dataList == null){
      Constants.dataList = [];
    }
    Constants.dataList.add(pi);

    AppData.saveFeedData(Constants.dataList);
    Utils.closeScreen(context);
    Utils.sendBroadcast(Constants.REFRESH_HOME_LIST_BROADCASTE_RECEIVER_ACTION);
    Utils.showToast(context, 'message');
  }

  void disposeTextFields(){
    try{
      _titleEditingController.dispose();
    }catch(e){}
  }

  @override
  void dispose() {
    disposeTextFields();
    
    super.dispose();
  }

}

import 'dart:core';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nico_resturant/src/config/validate_form.dart';
import 'package:nico_resturant/src/services//loading_model.dart';
import 'package:nico_resturant/src/services/db.dart';
import 'package:nico_resturant/src/style/style.dart';
import 'package:nico_resturant/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

enum Payment { Cash, Debt }

class SellForm extends StatefulWidget {
  @override
  _SellFormState createState() => _SellFormState();
}

class _SellFormState extends State<SellForm> {
  bool _isLoading = false;
  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  var _isFirstCrossFadeEnabled = false;
  int _theWhich = 1;
  var _db = DatabaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  DateTime chosenDate = DateTime.now();
  String foodName;
  String imageUrl;
  num foodPrice;
  num rate;
  String additionalInfo;

  TextEditingController foodNameController = TextEditingController();
  TextEditingController imageUrlController = TextEditingController();
  TextEditingController foodPriceController = TextEditingController();

  TextEditingController rateController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();

  @override
  void dispose() {
    foodNameController.dispose();
    imageUrlController.dispose();
    foodPriceController.dispose();
    rateController.dispose();
    additionalInfoController.dispose();

    super.dispose();
  }

  Color _color = Colors.blue;
  bool _isDebt = false;
  Payment type = Payment.Cash;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(gradient: mainGradientColorReverse),
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: globalTextColorDarker),
            title: Text(
              'Add a Dish',
              style: TextStyle(
                  shadows: [globalBoxShadow], color: globalTextColorDarker),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: Container(
            child: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: globalCard(
                      bgColor: Colors.transparent,
                      width: double.infinity,
                      margin: EdgeInsets.all(10.0),
                      child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                formTextFieldNoBorder(
                                    validator: emptyTextValidator,
                                    theHelper: 'Dish Name',
                                    controller: foodNameController),
                                Divider(
                                  height: 5,
                                ),
                                formTextFieldNoBorder(
                                    validator: emptyTextValidator,
                                    theHelper: 'given Rate',
                                    controller: rateController),
                                Divider(
                                  height: 5,
                                ),
                                formTextFieldNoBorder(
                                    theHelper: 'Price',
                                    controller: foodPriceController),
                                Divider(
                                  height: 5,
                                ),
                                formTextFieldNoBorder(
                                    theHelper: 'Additional Information',
                                    controller: additionalInfoController),
                                Divider(
                                  height: 5,
                                ),
                                formTextFieldNoBorder(
                                    theHelper: 'From Web Image Url',
                                    controller: imageUrlController),
                              ],
                            ),
                          )),
                    ),
                  ),
                  Expanded(
                    child: Container(
                        child: _image == null
                            ? Text('No Image Selected')
                            : Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                        clipBehavior: Clip.hardEdge,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(20)),
                                        child: Image.file(
                                          _image,
                                          scale: 1.0,
                                          width: 300,
                                          fit: BoxFit.fitHeight,
                                          height: 300,
                                        )),
                                  ),
                                  Divider(
                                    height: 5,
                                  ),
                                  globalBtn(
                                      theGColor: mainGradientColorReverse,
                                      spColor: Colors.amber,
                                      theOnPressed: () => uploadImg(),
                                      theTitle: 'Upload the Image'),
                                ],
                              )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: globalBtn(
                        theTitle: 'Pick An Image',
                        theOnPressed: getImage,
                        theGColor: mainGradientColorReverse),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 8.0, right: 8.0, left: 8.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          globalBtn(
                              theShadow: [
                                BoxShadow(
                                    color: Colors.redAccent, blurRadius: 5)
                              ],
                              theOnPressed: () {
                                Navigator.pop(context);
                              },
                              theGColor: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Colors.red[800], Colors.redAccent]),
                              theTitle: 'Cancel'),
                          VerticalDivider(),
                          globalBtn(
                            theShadow: [
                              BoxShadow(color: mainColor, blurRadius: 5)
                            ],
                            spColor: Colors.white.withOpacity(0.2),
                            theOnPressed: () {
                              _addSalesRecord();
                            },
                            theGColor: mainGradientColor,
                            theTitle: 'Submit',
                          ),
                        ]),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  animateCrossFade() {
    setState(() {
      _isFirstCrossFadeEnabled = !_isFirstCrossFadeEnabled;
    });
  }

  convertTaxFromPercentToDouble(num percent, num foodPrice) {
    num taxInMoney = 0;
    num taxInDouble = 0;
    taxInDouble = percent * (0.01);
    taxInMoney = foodPrice * taxInDouble;
    debugPrint('converting' + percent.toString());
    return taxInMoney.toDouble();
  }

  popDatePicker() async {
    chosenDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.dark(),
          child: child,
        );
      },
    );

    if (chosenDate != null) {
      setState(() {
        return chosenDate;
      });
    }
  }

  _addSalesRecord() async {
    debugPrint('add sale record initiated');
    if (_formKey.currentState.validate() == true) {
      Provider.of<LoadingModel>(context, listen: false).trueLoading();
      Timestamp _invoiceCreationTime = Timestamp.fromDate(DateTime.now());
      String _foodName = foodNameController.text ?? ' ';
      String _imageUrl = imageUrlController.text ?? ' ';
      num _foodPrice = num.tryParse(foodPriceController.text) ?? 0;
      num _rate = num.tryParse(rateController.text) ?? 0;
      String _additionalInfo = additionalInfoController.text ?? ' ';
      bool _isSettled;
      if (_isDebt == true) {
        _isSettled = false;
      } else {
        _isSettled = true;
      }

      //todo add loading
      await _db.ref.add({
        'invoiceCreationTime': _invoiceCreationTime,
        'foodName': _foodName,
        'imageUrl': _imageUrl ?? imageUrl,
        'foodPrice': _foodPrice,
        'rate': _rate,
        'additionalInfo': _additionalInfo,
        'isSettled': _isSettled,
      }).then((onValue) {
        debugPrint(onValue.documentID.toString() + ' added to db');
        Provider.of<LoadingModel>(context, listen: false).falseLoading();
        Navigator.pop(context);
      });
    } else {
      debugPrint('Couldnt Validate data');
    }
  }

  Future<void> uploadImg() async {
    setState(() {
      _isLoading = true;
    });

    final StorageReference fireBaseStorage = FirebaseStorage.instance
        .ref()
        .child(foodNameController.value.text == null
            ? 'food_e.jpg'
            : foodNameController.value.text + '.jpg');
    final StorageUploadTask theTask = fireBaseStorage.putFile(_image);

    theTask.events.listen((onData) async {
      if (theTask.isSuccessful) {
        debugPrint('The Task is Successfull');
        var dowUrl = await fireBaseStorage.getDownloadURL();
        setState(() {
          _isLoading = false;
          imageUrl = dowUrl;
          debugPrint('download img src : ' + imageUrl);
        });
      }
      if (onData.type == StorageTaskEventType.failure) {
        debugPrint('Failed ...');

        _isLoading = false;
        debugPrint('Error');
      }
    });
  }
}

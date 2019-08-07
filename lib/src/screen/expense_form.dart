import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nico_resturant/src/config/config.dart';
import 'package:nico_resturant/src/config/validate_form.dart';
import 'package:nico_resturant/src/services//loading_model.dart';
import 'package:nico_resturant/src/services/db.dart';
import 'package:nico_resturant/src/style/style.dart';
import 'package:nico_resturant/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

enum Payment { Cash, Debt }

class ExpanseForm extends StatefulWidget {
  @override
  _ExpanseFormState createState() => _ExpanseFormState();
}

class _ExpanseFormState extends State<ExpanseForm> {
  var _isFirstCrossFadeEnabled = false;
  int _theWhich = 1;
  var _db = DatabaseService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime chosenDate = DateTime.now();
  String itemName;
  String shopName;
  num totalPrice;
//  num discount;
  num paidPrice;
  num prePayment;
  num debt;
  String budgetFrom;
  String submitterName;

  TextEditingController itemNameController = TextEditingController();
  TextEditingController shopNameController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
//  TextEditingController paidPriceController = TextEditingController();

  /// if debt selected
  TextEditingController discountController = TextEditingController();
  TextEditingController debtPrePaymentController = TextEditingController();

  /// if debt selected
  TextEditingController debtDebtController = TextEditingController();
  TextEditingController budgetFromController = TextEditingController();
  TextEditingController submitterNameController = TextEditingController();
  TextEditingController additionalInfoController = TextEditingController();

  @override
  void dispose() {
    itemNameController.dispose();
    shopNameController.dispose();
    totalPriceController.dispose();
    discountController.dispose();
    debtPrePaymentController.dispose();
    debtDebtController.dispose();
    budgetFromController.dispose();
    submitterNameController.dispose();

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
              'Add an Expense',
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Container(
                                        width: 250,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: FlatButton(
                                          onPressed: () => popDatePicker(),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                width: 30,
                                                height: 30,
                                                child: Icon(
                                                  FontAwesomeIcons.calendarAlt,
                                                  color: secondColor,
                                                ),
                                              ),
                                              VerticalDivider(),
                                              Text(
                                                chosenDate != null
                                                    ? dateFormat
                                                        .format(chosenDate)
                                                    : dateFormat
                                                        .format(DateTime.now()),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color:
                                                        globalTextColorDarker),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, right: 8.0, left: 8.0),
                                        child: formTextFieldNoBorder(
                                          validator: emptyTextValidator,
                                          controller: itemNameController,
                                          theHelper: 'Item Name',
//                              theLabel: 'Service Name',
                                          theIcon: FontAwesomeIcons.cartPlus,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, right: 8.0, left: 8.0),
                                        child: formTextFieldNoBorder(
                                          validator: emptyTextValidator,
                                          controller: shopNameController,
                                          theHelper: 'Store Name',
//                              theLabel: 'Service Name',
                                          theIcon: FontAwesomeIcons.store,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 8.0, right: 8.0, left: 8.0),
                                        child: Row(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 3,
                                              child: formTextFieldNoBorder(
                                                textInputType:
                                                    TextInputType.number,
                                                validator: validateNumber,
                                                controller:
                                                    totalPriceController,
                                                theHelper: 'Total Cart Price',
                                                theIcon: FontAwesomeIcons
                                                    .moneyBillWave,
                                              ),
                                            ),
                                            VerticalDivider(
                                              width: 5,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ]),
                                Container(
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: RadioListTile<Payment>(
                                          title: const Text('Cash'),
                                          value: Payment.Cash,
                                          groupValue: type,
                                          onChanged: (Payment value) {
                                            setState(() {
                                              _isDebt = false;
                                              type = value;
                                            });
                                          },
                                        ),
                                      ),
                                      Expanded(
                                        child: RadioListTile<Payment>(
                                          title: const Text('Debt'),
                                          value: Payment.Debt,
                                          groupValue: type,
                                          onChanged: (Payment value) {
                                            setState(() {
                                              type = value;
                                              _isDebt = true;
                                            });
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 8.0, left: 8.0),
                                  child: AnimatedCrossFade(
                                      duration: Duration(milliseconds: 300),
                                      firstChild: Row(
                                        children: <Widget>[
                                          Expanded(
                                            child: formTextFieldNoBorder(
                                              controller:
                                                  debtPrePaymentController,
                                              theHelper: 'pre-payment ',
//                              theLabel: 'Service Name',
                                              theIcon:
                                                  FontAwesomeIcons.dollarSign,
                                            ),
                                          ),
                                          VerticalDivider(
                                            width: 5,
                                          ),
                                          Expanded(
                                            child: formTextFieldNoBorder(
//                                                validator: emptyTextValidator,
                                                controller: debtDebtController,
                                                theHelper: 'debt',
                                                theIcon: FontAwesomeIcons
                                                    .dollarSign),
                                          ),
                                        ],
                                      ),
                                      secondChild: Container(),
                                      crossFadeState: _isDebt == true
                                          ? CrossFadeState.showFirst
                                          : CrossFadeState.showSecond),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 8.0, left: 8.0),
                                  child: formTextFieldNoBorder(
                                      validator: emptyTextValidator,
                                      controller: budgetFromController,
                                      theHelper: 'Budget From',
                                      theIcon: FontAwesomeIcons.piggyBank),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 8.0, left: 8.0),
                                  child: formTextFieldNoBorder(
                                      controller: submitterNameController,
                                      theHelper: 'submitter '
                                          'name',
                                      theIcon: FontAwesomeIcons.userAstronaut),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, right: 8.0, left: 8.0),
                                  child: formTextFieldNoBorder(
                                    theLabel: 'Additional Information',
                                    theHelper: 'Additional Information',
                                    theIcon: FontAwesomeIcons.info,
                                    controller: additionalInfoController,
                                  ),
                                )
                              ],
                            ),
                          )),
                    ),
                  ),

//                Divider(
//                  color: Colors.transparent,
//                ),
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

  calculatePayablePrice() {
    if (discountController.value.text.isNotEmpty &&
        totalPriceController.value.text.isNotEmpty) {
//      discount = num.tryParse(discountController.value.text);
      totalPrice = num.tryParse(totalPriceController.text);

//      num discountInMoney =
//          convertTaxFromPercentToDouble(discount, totalPrice);
//      debugPrint('dis in mone' + discountInMoney.toString());
//      setState(() {
//        paidPrice = totalPrice - discountInMoney;
//      });

      debugPrint('pay price' + paidPrice.toString());
    } else {
      setState(() {
        paidPrice = null;
      });
    }
  }

  convertTaxFromPercentToDouble(num percent, num totalPrice) {
    num taxInMoney = 0;
    num taxInDouble = 0;
    taxInDouble = percent * (0.01);
    taxInMoney = totalPrice * taxInDouble;
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
//    debugPrint(dateFormat.format(chosenDate));

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
      calculatePayablePrice();
      Timestamp _invoiceCreationTime = Timestamp.fromDate(DateTime.now());
      chosenDate == null ?? DateTime.now();
      Timestamp _chosenDate = Timestamp.fromDate(chosenDate) ?? Timestamp.now();
      String _itemName = itemNameController.text ?? 'no service name';
      String _shopName = shopNameController.text ?? 'no customer selected';
      num _totalPrice = num.tryParse(totalPriceController.text) ?? 0;
      num _discount = num.tryParse(discountController.text) ?? 0;
      num _paidPrice = paidPrice ?? 0;
      num _prePayment = num.tryParse(debtPrePaymentController.text) ?? 0;
      num _debt = num.tryParse(debtDebtController.text) ?? 0;
      String _budgetFrom = budgetFromController.text ?? 'default';
      String _submitterName = submitterNameController.text ?? 'default';
      String _additionalInfo = additionalInfoController.text ?? 'default';
      bool _isSettled;
      if (_isDebt == true) {
        _isSettled = false;
      } else {
        _isSettled = true;
      }

      //todo add loading
      await _db.refExp.add({
        'invoiceCreationTime': _invoiceCreationTime,
        'chosenDate': _chosenDate,
        'itemName': _itemName,
        'shopName': _shopName,
        'totalPrice': _totalPrice,
        'discount': _discount,
        'paidPrice': _paidPrice,
        'prePayment': _prePayment,
        'debt': _debt,
        'budgetFrom': _budgetFrom,
        'submitterName': _submitterName,
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

  Widget _showPayablePrice() {
    return Container(
      child: Expanded(
        child: Container(
          margin: EdgeInsets.only(top: 8.0),
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white70,
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          height: 50,
          child: Text(
            'Payable Price: ' + paidPrice.toString(),
            style: TextStyle(fontSize: 18, color: globalTextColorDarker),
          ),
        ),
      ),
    );
  }
}

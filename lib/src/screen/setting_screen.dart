import 'package:flutter/material.dart';
import 'package:nico_resturant/src/services/setting_model.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String dropdownValue;

  @override
  Widget build(BuildContext context) {
    SettingModel settingProvider = Provider.of<SettingModel>(context);
    dropdownValue = settingProvider.itemViewModel;
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      appBar: AppBar(),
      body: Container(
        child: Container(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Text(
                  'Item view model: ',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                VerticalDivider(),
                DropdownButton<String>(
                  value: dropdownValue,
                  icon: Icon(
                    Icons.arrow_downward,
                    color: Colors.grey[800],
                  ),
                  iconSize: 24,
                  elevation: 16,
                  dropdownColor: Colors.white,
                  style: TextStyle(color: Colors.grey[800]),
                  underline: Container(
                    height: 2,
                    color: Colors.red,
                  ),
                  onChanged: (String newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                    settingProvider.changeItemViewModel(newValue);
                    debugPrint('value is : ' +
                        newValue +
                        '   ' +
                        'item on provider is'
                            ' : ${settingProvider.itemViewModel}');
                  },
                  items: <String>['Full Screen View', 'Grid View']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            )),
      ),
    );
  }
}

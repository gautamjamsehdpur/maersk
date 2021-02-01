import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<Settings> {
  List<bool> isSelected;
  bool isSwitched = false;
  String dvChangeOfficeHours = '9 AM - 5 PM';
  String dvChangeTimezone = 'India';
  @override
  void initState() {
    isSelected = [true, false];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Settings"),
        ),
        body: Center(
            child: Container(
          margin: EdgeInsets.all(15.0),
          alignment: Alignment.topLeft,
          child: Column(
            children: <Widget>[
              Text(
                'Change office time',
                textAlign: TextAlign.left,
              
              ),
              DropdownButton<String>(
                value: dvChangeOfficeHours,
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dvChangeOfficeHours = newValue;
                  });
                },
                items: <String>[
                  '9 AM - 5 PM',
                  '10 AM - 6 PM',
                  '11 AM - 7 PM',
                  '12 AM - 8 PM'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              Text(
                'Convert timezone',
                textAlign: TextAlign.left,
              
              ),
              DropdownButton<String>(
                value: dvChangeTimezone,
                isExpanded: true,
                icon: Icon(Icons.arrow_downward),
                iconSize: 24,
                elevation: 16,
                style: TextStyle(color: Colors.black),
                underline: Container(
                  height: 1,
                  color: Colors.grey,
                ),
                onChanged: (String newValue) {
                  setState(() {
                    dvChangeTimezone = newValue;
                  });
                },
                items: <String>['India', 'USA', 'UAE', 'Canada']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              SwitchListTile(
                title: const Text('Notification'),
                value: isSwitched,
                onChanged: (value) {
                  setState(() {
                    isSwitched = value;
                    print(isSwitched);
                  });
                },
                activeTrackColor: Colors.blue,
                activeColor: Colors.blue,
              ),
            ],
          ),
        )));
  }
}

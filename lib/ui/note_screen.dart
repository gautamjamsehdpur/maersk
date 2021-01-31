import 'package:flutter/material.dart';
import 'package:Maersk/model/listfile.dart';
import 'package:Maersk/util/database_helper.dart';
import 'package:date_time_picker/date_time_picker.dart';

class NoteScreen extends StatefulWidget {
  final Note note;
  NoteScreen(this.note);

  @override
  State<StatefulWidget> createState() => new _NoteScreenState();
}

class _NoteScreenState extends State<NoteScreen> {
  DatabaseHelper db = new DatabaseHelper();

  TextEditingController _titleController;
  TextEditingController _descriptionController;
  TextEditingController _durationController;

  String dvChooseRoom = 'Meeting Room 1';
  String dvPriority = 'High';
  String dvReminder = '30 min';
  String dateTime = '';

  @override
  void initState() {
    super.initState();

    _titleController = new TextEditingController(text: widget.note.title);
    _descriptionController =
        new TextEditingController(text: widget.note.description);
    _durationController = new TextEditingController(text: "30 min");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Book Meetings')),
      body: Container(
        margin: EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Duration'),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            DateTimePicker(
              type: DateTimePickerType.dateTimeSeparate,
              dateMask: 'd MMM, yyyy',
              initialValue: DateTime.now().toString(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2100),
              icon: Icon(Icons.event),
              dateLabelText: 'Date',
              timeLabelText: "Hour",
              
              onChanged: (val) => print(val),
              validator: (val) {
                print(val);
                dateTime = val;
                return null;
              },
              onSaved: (val) => print(val),
            ),
            Padding(padding: new EdgeInsets.all(10.0)),
            DropdownButton<String>(
              value: dvChooseRoom,
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
                  dvChooseRoom = newValue;
                });
              },
              items: <String>[
                'Meeting Room 1',
                'Meeting Room 2',
                'Meeting Room 3',
                'Meeting Room 4'
              ].map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            DropdownButton<String>(
              isExpanded: true,
              value: dvPriority,
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
                  dvPriority = newValue;
                });
              },
              items: <String>['High', 'Medium', 'Low']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(padding: new EdgeInsets.all(5.0)),
            DropdownButton<String>(
              isExpanded: true,
              value: dvReminder,
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
                  dvReminder = newValue;
                });
              },
              items: <String>['15 min', '30 min', '24 hrs']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            Padding(padding: new EdgeInsets.all(10.0)),
            SizedBox(
              width: double.infinity, // match_parent
              child: RaisedButton(
                child: (widget.note.id != null) ? Text('Update') : Text('Add'),
                onPressed: () {
                  if (widget.note.id != null) {
                    db
                        .updateNote(Note.fromMap({
                      'id': widget.note.id,
                      'title': _titleController.text,
                      'description': _descriptionController.text
                    }))
                        .then((_) {
                      Navigator.pop(context, 'update');
                    });
                  } else {
                    db
                        .saveNote(Note(
                            _titleController.text, _descriptionController.text, _durationController.text, dvChooseRoom, dvPriority, dvReminder, dateTime))
                        .then((_) {
                      Navigator.pop(context, 'save');
                    });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

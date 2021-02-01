import 'package:flutter/material.dart';
import 'package:Maersk/model/listfile.dart';
import 'package:Maersk/util/database_helper.dart';
import 'package:Maersk/ui/note_screen.dart';
import 'package:Maersk/ui/settings.dart';
 
class ListViewNote extends StatefulWidget {
  @override
  _ListViewNoteState createState() => new _ListViewNoteState();
}
 
class _ListViewNoteState extends State<ListViewNote> {
  List<Note> items = new List();
  DatabaseHelper db = new DatabaseHelper();
 
  @override
  void initState() {
    super.initState();
 
    db.getAllNotes().then((notes) {
      setState(() {
        notes.forEach((note) {
          items.add(Note.fromMap(note));
        });
      });
    });
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        break;
      case 'Settings':
      //MaterialPageRoute(builder: (context) => Settings());
      Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Settings()),
  );
        break;
    }
}
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maersk Assignment',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Maersk Assignment'),
          centerTitle: true,
          backgroundColor: Colors.blue,
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Logout', 'Settings'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
        body: Center(
          child: ListView.builder(
              itemCount: items.length,
              padding: const EdgeInsets.all(15.0),
              itemBuilder: (context, position) {
                return Column(
                  children: <Widget>[
                    Divider(height: 5.0),
                    ListTile(
                      title: Text(
                        '${'Title : '+items[position].title}',
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.black,
                        ),
                      ),
                      
                      subtitle: Text(
                        '${'Description : ' + items[position].description  +'\n'+'Duration : '+ items[position].duration +'\n'+'Room : '+ items[position].meetingroom +'\n'+'Reminder :'+ items[position].reminder +'\n'+ items[position].datetime}',
                        style: new TextStyle(
                          fontSize: 18.0,
                        ),
                      ),

                      leading: Column(
                        children: <Widget>[
                          Padding(padding: EdgeInsets.all(0.0)),
                          CircleAvatar(
                            backgroundColor: Colors.blueAccent,
                            radius: 7.0,
                            child: Text(
                              '${items[position].id}',
                              style: TextStyle(
                                fontSize: 10.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          IconButton(
                              icon: const Icon(Icons.remove_circle_outline),
                              onPressed: () => _deleteNote(context, items[position], position)),
                        ],
                      ),
                      onTap: () => _navigateToNote(context, items[position]),
                    ),
                  ],
                );
              }),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => _createNewNote(context),
        ),
      ),
    );
  }
 
  void _deleteNote(BuildContext context, Note note, int position) async {
    db.deleteNote(note.id).then((notes) {
      setState(() {
        items.removeAt(position);
      });
    });
  }
 
  void _navigateToNote(BuildContext context, Note note) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(note)),
    );
 
    if (result == 'update') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }
 
  void _createNewNote(BuildContext context) async {
    String result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NoteScreen(Note('', '', '', '', '', '', ''))),
    );
 
    if (result == 'save') {
      db.getAllNotes().then((notes) {
        setState(() {
          items.clear();
          notes.forEach((note) {
            items.add(Note.fromMap(note));
          });
        });
      });
    }
  }
}
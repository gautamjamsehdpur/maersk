class Note {
  int _id;
  String _title;
  String _description;
  String _duration;
  String _meetingroom;
  String _priority;
  String _reminder;
  String _dateTime;
 
  Note(this._title, this._description, this._duration, this._meetingroom, this._priority, this._reminder, this._dateTime);
 
  Note.map(dynamic obj) {
    this._id = obj['id'];
    this._title = obj['title'];
    this._description = obj['description'];
    this._duration = obj['duration'];
    this._meetingroom = obj['meetingroom'];
    this._priority = obj['priorityty'];
    this._reminder = obj['reminder'];
    this._dateTime = obj['datetime'];
  }
 
  int get id => _id;
  String get title => _title;
  String get description => _description;
  String get duration => _duration;
  String get meetingroom => _meetingroom;
  String get priorityty => _priority;
  String get reminder => _reminder;
  String get datetime => _dateTime;
 
  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['duration'] = _duration;
    map['meetingroom'] = _meetingroom;
    map['priorityty'] = _priority;
    map['reminder'] = _reminder;
    map['datetime'] = _dateTime;
 
    return map;
  }
 
  Note.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._duration = map['duration'];
    this._meetingroom = map['meetingroom'];
    this._priority = map['priorityty'];
    this._reminder = map['reminder'];
    this._dateTime = map['datetime'];
  }
}
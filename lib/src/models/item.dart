class Item {
  int _countResult;
  List<_Result> _results;
  Item.fromJson(Map<String, dynamic> parsedJson) {
    _countResult = parsedJson['count_result'];
    List<_Result> temp = [];

    for (int i = 0; i < parsedJson['results'].length; i++) {
      _Result result = _Result(parsedJson['results'][i]);
      temp.add(result);
    }

    _results = temp;
  }

  int get countResult => _countResult;
  List<_Result> get results => _results;
}

class _Result {
  int _id;
  String _name;

  _Result(result) {
    this._id = result['id'];
    this._name = result['name'];
  }

  int get id => this._id;
  String get name => this._name;
}

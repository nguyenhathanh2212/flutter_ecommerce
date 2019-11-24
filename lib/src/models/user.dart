class User {
  int _id;
  String _uid;
  String _username;
  String _email;

  User(this._id, this._uid, this._username, this._email);
  User.forCreate(this._uid, this._username, this._email);

  factory User.fromMap(Map<String, dynamic> data) {
    return User(
      data['id'],
      data['uid'],
      data['username'],
      data['email'],
    );
  }

  int get id => _id;
  String get uid => _uid;
  String get username => _username;
  String get email => _email;

  Map<String, dynamic> toMap() => {
    'uid': _uid,
    'username': _username,
    'email': _email,
  };
}

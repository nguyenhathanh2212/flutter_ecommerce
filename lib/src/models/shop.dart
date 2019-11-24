class Shop {
  int _id;
  String _name;
  String _address;

  Shop(this._id, this._name, this._address);
  Shop.forCreate( this._name, this._address);

  factory Shop.fromMap(Map<String, dynamic> data) {
    return Shop(
      data['id'],
      data['name'],
      data['address'],
    );
  }

  int get id => _id;
  String get name => _name;
  String get address => _address;

  Map<String, dynamic> toMap() => {
    'name': _name,
    'address': _address,
  };
}

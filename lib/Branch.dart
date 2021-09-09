class Branch{
  String _shopName;
  int _id;
  String _tel;
  double _lat;
  double _lng;
  String _manager;

  Branch(this._shopName, this._id, this._tel, this._lat, this._lng, this._manager);


get shopName => _shopName;
get id => _id;
get tel => _tel;
get lat => _lat;
get lng => _lng;
get manager => _manager;
}
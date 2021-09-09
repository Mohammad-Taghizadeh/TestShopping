class Product{
  String _productName;
  int _id;
  String _price;
  String _imageurl;
  bool _off;
  String _description;

  Product(this._productName, this._id, this._price, this._imageurl, this._off, this._description);

  get productName => _productName;
  get id => _id;
  get price => _price;
  get imageurl => _imageurl;
  get off => _off;
  get description => _description;
}
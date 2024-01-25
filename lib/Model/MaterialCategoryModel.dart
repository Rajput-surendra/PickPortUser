/// status : true
/// message : "Categories list"
/// data : [{"id":"68","title":"Wood","slug":"wood","parent":"0","leval":"0","description":"","image":"download_(66).jpg","status":"1","subcat_name":"Fruits, Exotics, Mangoes"},{"id":"69","title":"Accessories & Spare Part ","slug":"accessories-spare-part ","parent":"0","leval":"0","description":"","image":"download_(67).jpg","status":"1","subcat_name":"Cold Drinks, Healthy and Engery Drinks, Juices & Drinks, Tea & Coffee, Water & Soda, Milk Drinks"},{"id":"70","title":"Glass","slug":"glass","parent":"0","leval":"0","description":"","image":"download_(68).jpg","status":"1","subcat_name":"noodles vermicelli, sauces and ketchup, Jams & Spreads, Pasta & Soups, Ready Made Meals & Mixes, Pickles & Chutneys, Canned & Frozen Food, Honey & Chyawanprash, Baking & Dessert Items"},{"id":"71","title":"Ceramic","slug":"ceramic","parent":"0","leval":"0","description":"","image":"download_(69).jpg","status":"1","subcat_name":"Furniture and storage, Curtains, Cushions & Accessories, Decor, Gardening & Festivities, Mats & Carpets, Table & Kitchen Linen"},{"id":"72","title":"Agricultural Equipment","slug":"agricultural-equipment","parent":"0","leval":"0","description":"","image":"download_(70).jpg","status":"1","subcat_name":"Dog Supplies, Cat supplies"},{"id":"73","title":"Machinery","slug":"machinery","parent":"0","leval":"0","description":"","image":"download_(71).jpg","status":"1","subcat_name":"kids Toys and more, Stationery  Supplies, Art & Craft Supplies, Sport Fitness and outdoors"},{"id":"77","title":"Test","slug":"test","parent":"0","leval":"0","description":"","image":"","status":"1","subcat_name":"Disinfectants, Laundry Detergents, Cleaners, Dishwashers, Pooja Needs"}]

class MaterialCategoryModel {
  MaterialCategoryModel({
      bool? status, 
      String? message, 
      List<CatData>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  MaterialCategoryModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(CatData.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CatData>? _data;
MaterialCategoryModel copyWith({  bool? status,
  String? message,
  List<CatData>? data,
}) => MaterialCategoryModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<CatData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "68"
/// title : "Wood"
/// slug : "wood"
/// parent : "0"
/// leval : "0"
/// description : ""
/// image : "download_(66).jpg"
/// status : "1"
/// subcat_name : "Fruits, Exotics, Mangoes"

class CatData {
  CatData({
      String? id, 
      String? title, 
      String? slug, 
      String? parent, 
      String? leval, 
      String? description, 
      String? image, 
      String? status, 
      String? subcatName,}){
    _id = id;
    _title = title;
    _slug = slug;
    _parent = parent;
    _leval = leval;
    _description = description;
    _image = image;
    _status = status;
    _subcatName = subcatName;
}

  CatData.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _slug = json['slug'];
    _parent = json['parent'];
    _leval = json['leval'];
    _description = json['description'];
    _image = json['image'];
    _status = json['status'];
    _subcatName = json['subcat_name'];
  }
  String? _id;
  String? _title;
  String? _slug;
  String? _parent;
  String? _leval;
  String? _description;
  String? _image;
  String? _status;
  String? _subcatName;
  CatData copyWith({  String? id,
  String? title,
  String? slug,
  String? parent,
  String? leval,
  String? description,
  String? image,
  String? status,
  String? subcatName,
}) => CatData(  id: id ?? _id,
  title: title ?? _title,
  slug: slug ?? _slug,
  parent: parent ?? _parent,
  leval: leval ?? _leval,
  description: description ?? _description,
  image: image ?? _image,
  status: status ?? _status,
  subcatName: subcatName ?? _subcatName,
);
  String? get id => _id;
  String? get title => _title;
  String? get slug => _slug;
  String? get parent => _parent;
  String? get leval => _leval;
  String? get description => _description;
  String? get image => _image;
  String? get status => _status;
  String? get subcatName => _subcatName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['slug'] = _slug;
    map['parent'] = _parent;
    map['leval'] = _leval;
    map['description'] = _description;
    map['image'] = _image;
    map['status'] = _status;
    map['subcat_name'] = _subcatName;
    return map;
  }

}
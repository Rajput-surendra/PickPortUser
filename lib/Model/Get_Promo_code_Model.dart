/// status : true
/// message : "Use pramo code."
/// data : [{"id":"39","coupon_name":"25off","coupon_description":"Exclusive 25rs off for our first 100 Customers *minimum cart value 400*","coupon_code":"NEW100","valid_from":"2024-01-01","valid_to":"2025-07-13","validity_type":"","product_name":"","discount_type":"","discount_value":"25","cart_value":"400","uses_restriction":"50","is_applied":"0"},{"id":"40","coupon_name":"123456","coupon_description":"dfdfv","coupon_code":"tgrf","valid_from":"2024-01-01","valid_to":"2024-10-12","validity_type":"","product_name":"","discount_type":"","discount_value":"10","cart_value":"200","uses_restriction":"1","is_applied":"0"}]

class GetPromoCodeModel {
  GetPromoCodeModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetPromoCodeModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Data>? _data;
GetPromoCodeModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetPromoCodeModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  List<Data>? get data => _data;

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

/// id : "39"
/// coupon_name : "25off"
/// coupon_description : "Exclusive 25rs off for our first 100 Customers *minimum cart value 400*"
/// coupon_code : "NEW100"
/// valid_from : "2024-01-01"
/// valid_to : "2025-07-13"
/// validity_type : ""
/// product_name : ""
/// discount_type : ""
/// discount_value : "25"
/// cart_value : "400"
/// uses_restriction : "50"
/// is_applied : "0"

class Data {
  Data({
      String? id, 
      String? couponName, 
      String? couponDescription, 
      String? couponCode, 
      String? validFrom, 
      String? validTo, 
      String? validityType, 
      String? productName, 
      String? discountType, 
      String? discountValue, 
      String? cartValue, 
      String? usesRestriction, 
      String? isApplied,}){
    _id = id;
    _couponName = couponName;
    _couponDescription = couponDescription;
    _couponCode = couponCode;
    _validFrom = validFrom;
    _validTo = validTo;
    _validityType = validityType;
    _productName = productName;
    _discountType = discountType;
    _discountValue = discountValue;
    _cartValue = cartValue;
    _usesRestriction = usesRestriction;
    _isApplied = isApplied;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _couponName = json['coupon_name'];
    _couponDescription = json['coupon_description'];
    _couponCode = json['coupon_code'];
    _validFrom = json['valid_from'];
    _validTo = json['valid_to'];
    _validityType = json['validity_type'];
    _productName = json['product_name'];
    _discountType = json['discount_type'];
    _discountValue = json['discount_value'];
    _cartValue = json['cart_value'];
    _usesRestriction = json['uses_restriction'];
    _isApplied = json['is_applied'];
  }
  String? _id;
  String? _couponName;
  String? _couponDescription;
  String? _couponCode;
  String? _validFrom;
  String? _validTo;
  String? _validityType;
  String? _productName;
  String? _discountType;
  String? _discountValue;
  String? _cartValue;
  String? _usesRestriction;
  String? _isApplied;
Data copyWith({  String? id,
  String? couponName,
  String? couponDescription,
  String? couponCode,
  String? validFrom,
  String? validTo,
  String? validityType,
  String? productName,
  String? discountType,
  String? discountValue,
  String? cartValue,
  String? usesRestriction,
  String? isApplied,
}) => Data(  id: id ?? _id,
  couponName: couponName ?? _couponName,
  couponDescription: couponDescription ?? _couponDescription,
  couponCode: couponCode ?? _couponCode,
  validFrom: validFrom ?? _validFrom,
  validTo: validTo ?? _validTo,
  validityType: validityType ?? _validityType,
  productName: productName ?? _productName,
  discountType: discountType ?? _discountType,
  discountValue: discountValue ?? _discountValue,
  cartValue: cartValue ?? _cartValue,
  usesRestriction: usesRestriction ?? _usesRestriction,
  isApplied: isApplied ?? _isApplied,
);
  String? get id => _id;
  String? get couponName => _couponName;
  String? get couponDescription => _couponDescription;
  String? get couponCode => _couponCode;
  String? get validFrom => _validFrom;
  String? get validTo => _validTo;
  String? get validityType => _validityType;
  String? get productName => _productName;
  String? get discountType => _discountType;
  String? get discountValue => _discountValue;
  String? get cartValue => _cartValue;
  String? get usesRestriction => _usesRestriction;
  String? get isApplied => _isApplied;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['coupon_name'] = _couponName;
    map['coupon_description'] = _couponDescription;
    map['coupon_code'] = _couponCode;
    map['valid_from'] = _validFrom;
    map['valid_to'] = _validTo;
    map['validity_type'] = _validityType;
    map['product_name'] = _productName;
    map['discount_type'] = _discountType;
    map['discount_value'] = _discountValue;
    map['cart_value'] = _cartValue;
    map['uses_restriction'] = _usesRestriction;
    map['is_applied'] = _isApplied;
    return map;
  }

}
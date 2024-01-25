/// status : true
/// message : "Parcel send Successfully"
/// sale_id : "0"
/// order_id : null
/// cap : [{"fee_id":"1","cap_type":"1","min_amount":"0","max_amount":"5","min_weight":"10","max_weight":"15","amount":"","fee_charge":"50","date_time":"2024-01-01","id":"1","name":"2 wheeler Gear","image":"https://developmentalphawizz.com/pickport/uploads/cap/image12.png"},{"fee_id":"5","cap_type":"6","min_amount":"0","max_amount":"10","min_weight":"20","max_weight":"30","amount":"","fee_charge":"80","date_time":"2023-07-31","id":"6","name":"2 wheeler Non Gear","image":"https://developmentalphawizz.com/pickport/uploads/cap/image16.png"}]

class Registerparcelmodel {
  Registerparcelmodel({
      bool? status, 
      String? message, 
      String? saleId, 
      dynamic orderId, 
      List<Cap>? cap,}){
    _status = status;
    _message = message;
    _saleId = saleId;
    _orderId = orderId;
    _cap = cap;
}

  Registerparcelmodel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _saleId = json['sale_id'];
    _orderId = json['order_id'];
    if (json['cap'] != null) {
      _cap = [];
      json['cap'].forEach((v) {
        _cap?.add(Cap.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  String? _saleId;
  dynamic _orderId;
  List<Cap>? _cap;
Registerparcelmodel copyWith({  bool? status,
  String? message,
  String? saleId,
  dynamic orderId,
  List<Cap>? cap,
}) => Registerparcelmodel(  status: status ?? _status,
  message: message ?? _message,
  saleId: saleId ?? _saleId,
  orderId: orderId ?? _orderId,
  cap: cap ?? _cap,
);
  bool? get status => _status;
  String? get message => _message;
  String? get saleId => _saleId;
  dynamic get orderId => _orderId;
  List<Cap>? get cap => _cap;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['sale_id'] = _saleId;
    map['order_id'] = _orderId;
    if (_cap != null) {
      map['cap'] = _cap?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// fee_id : "1"
/// cap_type : "1"
/// min_amount : "0"
/// max_amount : "5"
/// min_weight : "10"
/// max_weight : "15"
/// amount : ""
/// fee_charge : "50"
/// date_time : "2024-01-01"
/// id : "1"
/// name : "2 wheeler Gear"
/// image : "https://developmentalphawizz.com/pickport/uploads/cap/image12.png"

class Cap {
  Cap({
      String? feeId, 
      String? capType, 
      String? minAmount, 
      String? maxAmount, 
      String? minWeight, 
      String? maxWeight, 
      String? amount, 
      String? feeCharge, 
      String? dateTime, 
      String? id, 
      String? name, 
      String? image,}){
    _feeId = feeId;
    _capType = capType;
    _minAmount = minAmount;
    _maxAmount = maxAmount;
    _minWeight = minWeight;
    _maxWeight = maxWeight;
    _amount = amount;
    _feeCharge = feeCharge;
    _dateTime = dateTime;
    _id = id;
    _name = name;
    _image = image;
}

  Cap.fromJson(dynamic json) {
    _feeId = json['fee_id'];
    _capType = json['cap_type'];
    _minAmount = json['min_amount'];
    _maxAmount = json['max_amount'];
    _minWeight = json['min_weight'];
    _maxWeight = json['max_weight'];
    _amount = json['amount'];
    _feeCharge = json['fee_charge'];
    _dateTime = json['date_time'];
    _id = json['id'];
    _name = json['name'];
    _image = json['image'];
  }
  String? _feeId;
  String? _capType;
  String? _minAmount;
  String? _maxAmount;
  String? _minWeight;
  String? _maxWeight;
  String? _amount;
  String? _feeCharge;
  String? _dateTime;
  String? _id;
  String? _name;
  String? _image;
Cap copyWith({  String? feeId,
  String? capType,
  String? minAmount,
  String? maxAmount,
  String? minWeight,
  String? maxWeight,
  String? amount,
  String? feeCharge,
  String? dateTime,
  String? id,
  String? name,
  String? image,
}) => Cap(  feeId: feeId ?? _feeId,
  capType: capType ?? _capType,
  minAmount: minAmount ?? _minAmount,
  maxAmount: maxAmount ?? _maxAmount,
  minWeight: minWeight ?? _minWeight,
  maxWeight: maxWeight ?? _maxWeight,
  amount: amount ?? _amount,
  feeCharge: feeCharge ?? _feeCharge,
  dateTime: dateTime ?? _dateTime,
  id: id ?? _id,
  name: name ?? _name,
  image: image ?? _image,
);
  String? get feeId => _feeId;
  String? get capType => _capType;
  String? get minAmount => _minAmount;
  String? get maxAmount => _maxAmount;
  String? get minWeight => _minWeight;
  String? get maxWeight => _maxWeight;
  String? get amount => _amount;
  String? get feeCharge => _feeCharge;
  String? get dateTime => _dateTime;
  String? get id => _id;
  String? get name => _name;
  String? get image => _image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['fee_id'] = _feeId;
    map['cap_type'] = _capType;
    map['min_amount'] = _minAmount;
    map['max_amount'] = _maxAmount;
    map['min_weight'] = _minWeight;
    map['max_weight'] = _maxWeight;
    map['amount'] = _amount;
    map['fee_charge'] = _feeCharge;
    map['date_time'] = _dateTime;
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }

}
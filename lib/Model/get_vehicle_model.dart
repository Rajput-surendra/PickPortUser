/// status : true
/// message : "vehicle List"
/// data : {"cap_name":"2 wheeler Gear","image":"https://developmentalphawizz.com/pickport/uploads/cap/image121.png","cap_id":"1","fee_id":"23","min_amount":"0","max_amount":"0.13","min_weight":"5","max_weight":"10","fee_charge":"50","category_name":"Ceramic","receiver_name":"gdhffv","receiver_phone":"9589599959","on_date":"2024-02-09","delivery_time":"07:34:44pm"}

class GetVehicleModel {
  GetVehicleModel({
      bool? status, 
      String? message, 
      Data? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetVehicleModel.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _status;
  String? _message;
  Data? _data;
GetVehicleModel copyWith({  bool? status,
  String? message,
  Data? data,
}) => GetVehicleModel(  status: status ?? _status,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get status => _status;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// cap_name : "2 wheeler Gear"
/// image : "https://developmentalphawizz.com/pickport/uploads/cap/image121.png"
/// cap_id : "1"
/// fee_id : "23"
/// min_amount : "0"
/// max_amount : "0.13"
/// min_weight : "5"
/// max_weight : "10"
/// fee_charge : "50"
/// category_name : "Ceramic"
/// receiver_name : "gdhffv"
/// receiver_phone : "9589599959"
/// on_date : "2024-02-09"
/// delivery_time : "07:34:44pm"

class Data {
  Data({
      String? capName, 
      String? image, 
      String? capId, 
      String? feeId, 
      String? minAmount, 
      String? maxAmount, 
      String? minWeight, 
      String? maxWeight, 
      String? feeCharge, 
      String? categoryName, 
      String? receiverName, 
      String? receiverPhone, 
      String? onDate, 
      String? deliveryTime,}){
    _capName = capName;
    _image = image;
    _capId = capId;
    _feeId = feeId;
    _minAmount = minAmount;
    _maxAmount = maxAmount;
    _minWeight = minWeight;
    _maxWeight = maxWeight;
    _feeCharge = feeCharge;
    _categoryName = categoryName;
    _receiverName = receiverName;
    _receiverPhone = receiverPhone;
    _onDate = onDate;
    _deliveryTime = deliveryTime;
}

  Data.fromJson(dynamic json) {
    _capName = json['cap_name'];
    _image = json['image'];
    _capId = json['cap_id'];
    _feeId = json['fee_id'];
    _minAmount = json['min_amount'];
    _maxAmount = json['max_amount'];
    _minWeight = json['min_weight'];
    _maxWeight = json['max_weight'];
    _feeCharge = json['fee_charge'];
    _categoryName = json['category_name'];
    _receiverName = json['receiver_name'];
    _receiverPhone = json['receiver_phone'];
    _onDate = json['on_date'];
    _deliveryTime = json['delivery_time'];
  }
  String? _capName;
  String? _image;
  String? _capId;
  String? _feeId;
  String? _minAmount;
  String? _maxAmount;
  String? _minWeight;
  String? _maxWeight;
  String? _feeCharge;
  String? _categoryName;
  String? _receiverName;
  String? _receiverPhone;
  String? _onDate;
  String? _deliveryTime;
Data copyWith({  String? capName,
  String? image,
  String? capId,
  String? feeId,
  String? minAmount,
  String? maxAmount,
  String? minWeight,
  String? maxWeight,
  String? feeCharge,
  String? categoryName,
  String? receiverName,
  String? receiverPhone,
  String? onDate,
  String? deliveryTime,
}) => Data(  capName: capName ?? _capName,
  image: image ?? _image,
  capId: capId ?? _capId,
  feeId: feeId ?? _feeId,
  minAmount: minAmount ?? _minAmount,
  maxAmount: maxAmount ?? _maxAmount,
  minWeight: minWeight ?? _minWeight,
  maxWeight: maxWeight ?? _maxWeight,
  feeCharge: feeCharge ?? _feeCharge,
  categoryName: categoryName ?? _categoryName,
  receiverName: receiverName ?? _receiverName,
  receiverPhone: receiverPhone ?? _receiverPhone,
  onDate: onDate ?? _onDate,
  deliveryTime: deliveryTime ?? _deliveryTime,
);
  String? get capName => _capName;
  String? get image => _image;
  String? get capId => _capId;
  String? get feeId => _feeId;
  String? get minAmount => _minAmount;
  String? get maxAmount => _maxAmount;
  String? get minWeight => _minWeight;
  String? get maxWeight => _maxWeight;
  String? get feeCharge => _feeCharge;
  String? get categoryName => _categoryName;
  String? get receiverName => _receiverName;
  String? get receiverPhone => _receiverPhone;
  String? get onDate => _onDate;
  String? get deliveryTime => _deliveryTime;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cap_name'] = _capName;
    map['image'] = _image;
    map['cap_id'] = _capId;
    map['fee_id'] = _feeId;
    map['min_amount'] = _minAmount;
    map['max_amount'] = _maxAmount;
    map['min_weight'] = _minWeight;
    map['max_weight'] = _maxWeight;
    map['fee_charge'] = _feeCharge;
    map['category_name'] = _categoryName;
    map['receiver_name'] = _receiverName;
    map['receiver_phone'] = _receiverPhone;
    map['on_date'] = _onDate;
    map['delivery_time'] = _deliveryTime;
    return map;
  }

}
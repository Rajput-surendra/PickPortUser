/// error : false
/// message : "Data Get Sucessfully"
/// data : {"sale_id":"256","order_id":"264","sender_name":"surendra ","sender_phone":"7024663830","receiver_name":"harish choudhary ","receiver_phone":"7854669985","reciver_full_address":"test","receiver_address":"919, Part I, Scheme No 114, Indore, Madhya Pradesh 452010, India","sender_address":"151, Indore, Madhya Pradesh, India","booking_type":"1","booking_date":"2024-01-10","booking_time":"07:03 PM","sender_latitude":"22.7469366","sender_longitude":"75.8980127","receiver_latitude":"22.7684648","receiver_longitude":"75.8967932","meterial_category":"71","category_name":"Ceramic","distance":2.396975045143322713414590907632373273372650146484375}
/// delivery_fee : [{"fee_id":"4","cap_type":"1","min_amount":"0","max_amount":"3","min_weight":"0","max_weight":"20","amount":"","fee_charge":"50","description":"","date_time":"2024-01-04","id":"1","name":"2 wheeler Gear","image":"https://developmentalphawizz.com/pickport/uploads/cap/image12.png"},{"fee_id":"6","cap_type":"4","min_amount":"0","max_amount":"4","min_weight":"40","max_weight":"50","amount":"","fee_charge":"500","description":"","date_time":"2024-01-08","id":"4","name":"Tata 407","image":"https://developmentalphawizz.com/pickport/uploads/cap/image14.png"},{"fee_id":"11","cap_type":"2","min_amount":"0","max_amount":"5","min_weight":"20","max_weight":"30","amount":"","fee_charge":"100","description":"","date_time":"2024-01-08","id":"2","name":"Data Ace","image":"https://developmentalphawizz.com/pickport/uploads/cap/image11.png"},{"fee_id":"14","cap_type":"5","min_amount":"0","max_amount":"5","min_weight":"10","max_weight":"20","amount":"","fee_charge":"111","description":"","date_time":"2024-01-08","id":"5","name":"Mahindra pikup","image":"https://developmentalphawizz.com/pickport/uploads/cap/image15.png"}]

class VehicleDataModelList {
  VehicleDataModelList({
      bool? error, 
      String? message, 
      Data? data, 
      List<DeliveryFee>? deliveryFee,}){
    _error = error;
    _message = message;
    _data = data;
    _deliveryFee = deliveryFee;
}

  VehicleDataModelList.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
    if (json['delivery_fee'] != null) {
      _deliveryFee = [];
      json['delivery_fee'].forEach((v) {
        _deliveryFee?.add(DeliveryFee.fromJson(v));
      });
    }
  }
  bool? _error;
  String? _message;
  Data? _data;
  List<DeliveryFee>? _deliveryFee;
VehicleDataModelList copyWith({  bool? error,
  String? message,
  Data? data,
  List<DeliveryFee>? deliveryFee,
}) => VehicleDataModelList(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
  deliveryFee: deliveryFee ?? _deliveryFee,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;
  List<DeliveryFee>? get deliveryFee => _deliveryFee;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    if (_deliveryFee != null) {
      map['delivery_fee'] = _deliveryFee?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// fee_id : "4"
/// cap_type : "1"
/// min_amount : "0"
/// max_amount : "3"
/// min_weight : "0"
/// max_weight : "20"
/// amount : ""
/// fee_charge : "50"
/// description : ""
/// date_time : "2024-01-04"
/// id : "1"
/// name : "2 wheeler Gear"
/// image : "https://developmentalphawizz.com/pickport/uploads/cap/image12.png"

class DeliveryFee {
  DeliveryFee({
      String? feeId, 
      String? capType, 
      String? minAmount, 
      String? maxAmount, 
      String? minWeight, 
      String? maxWeight, 
      String? amount, 
      String? feeCharge, 
      String? description, 
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
    _description = description;
    _dateTime = dateTime;
    _id = id;
    _name = name;
    _image = image;
}

  DeliveryFee.fromJson(dynamic json) {
    _feeId = json['fee_id'];
    _capType = json['cap_type'];
    _minAmount = json['min_amount'];
    _maxAmount = json['max_amount'];
    _minWeight = json['min_weight'];
    _maxWeight = json['max_weight'];
    _amount = json['amount'];
    _feeCharge = json['fee_charge'];
    _description = json['description'];
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
  String? _description;
  String? _dateTime;
  String? _id;
  String? _name;
  String? _image;
DeliveryFee copyWith({  String? feeId,
  String? capType,
  String? minAmount,
  String? maxAmount,
  String? minWeight,
  String? maxWeight,
  String? amount,
  String? feeCharge,
  String? description,
  String? dateTime,
  String? id,
  String? name,
  String? image,
}) => DeliveryFee(  feeId: feeId ?? _feeId,
  capType: capType ?? _capType,
  minAmount: minAmount ?? _minAmount,
  maxAmount: maxAmount ?? _maxAmount,
  minWeight: minWeight ?? _minWeight,
  maxWeight: maxWeight ?? _maxWeight,
  amount: amount ?? _amount,
  feeCharge: feeCharge ?? _feeCharge,
  description: description ?? _description,
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
  String? get description => _description;
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
    map['description'] = _description;
    map['date_time'] = _dateTime;
    map['id'] = _id;
    map['name'] = _name;
    map['image'] = _image;
    return map;
  }

}

/// sale_id : "256"
/// order_id : "264"
/// sender_name : "surendra "
/// sender_phone : "7024663830"
/// receiver_name : "harish choudhary "
/// receiver_phone : "7854669985"
/// reciver_full_address : "test"
/// receiver_address : "919, Part I, Scheme No 114, Indore, Madhya Pradesh 452010, India"
/// sender_address : "151, Indore, Madhya Pradesh, India"
/// booking_type : "1"
/// booking_date : "2024-01-10"
/// booking_time : "07:03 PM"
/// sender_latitude : "22.7469366"
/// sender_longitude : "75.8980127"
/// receiver_latitude : "22.7684648"
/// receiver_longitude : "75.8967932"
/// meterial_category : "71"
/// category_name : "Ceramic"
/// distance : 2.396975045143322713414590907632373273372650146484375

class Data {
  Data({
      String? saleId, 
      String? orderId, 
      String? senderName, 
      String? senderPhone, 
      String? receiverName, 
      String? receiverPhone, 
      String? reciverFullAddress, 
      String? receiverAddress, 
      String? senderAddress, 
      String? bookingType, 
      String? bookingDate, 
      String? bookingTime, 
      String? senderLatitude, 
      String? senderLongitude, 
      String? receiverLatitude, 
      String? receiverLongitude, 
      String? meterialCategory, 
      String? categoryName, 
      num? distance,}){
    _saleId = saleId;
    _orderId = orderId;
    _senderName = senderName;
    _senderPhone = senderPhone;
    _receiverName = receiverName;
    _receiverPhone = receiverPhone;
    _reciverFullAddress = reciverFullAddress;
    _receiverAddress = receiverAddress;
    _senderAddress = senderAddress;
    _bookingType = bookingType;
    _bookingDate = bookingDate;
    _bookingTime = bookingTime;
    _senderLatitude = senderLatitude;
    _senderLongitude = senderLongitude;
    _receiverLatitude = receiverLatitude;
    _receiverLongitude = receiverLongitude;
    _meterialCategory = meterialCategory;
    _categoryName = categoryName;
    _distance = distance;
}

  Data.fromJson(dynamic json) {
    _saleId = json['sale_id'];
    _orderId = json['order_id'];
    _senderName = json['sender_name'];
    _senderPhone = json['sender_phone'];
    _receiverName = json['receiver_name'];
    _receiverPhone = json['receiver_phone'];
    _reciverFullAddress = json['reciver_full_address'];
    _receiverAddress = json['receiver_address'];
    _senderAddress = json['sender_address'];
    _bookingType = json['booking_type'];
    _bookingDate = json['booking_date'];
    _bookingTime = json['booking_time'];
    _senderLatitude = json['sender_latitude'];
    _senderLongitude = json['sender_longitude'];
    _receiverLatitude = json['receiver_latitude'];
    _receiverLongitude = json['receiver_longitude'];
    _meterialCategory = json['meterial_category'];
    _categoryName = json['category_name'];
    _distance = json['distance'];
  }
  String? _saleId;
  String? _orderId;
  String? _senderName;
  String? _senderPhone;
  String? _receiverName;
  String? _receiverPhone;
  String? _reciverFullAddress;
  String? _receiverAddress;
  String? _senderAddress;
  String? _bookingType;
  String? _bookingDate;
  String? _bookingTime;
  String? _senderLatitude;
  String? _senderLongitude;
  String? _receiverLatitude;
  String? _receiverLongitude;
  String? _meterialCategory;
  String? _categoryName;
  num? _distance;
Data copyWith({  String? saleId,
  String? orderId,
  String? senderName,
  String? senderPhone,
  String? receiverName,
  String? receiverPhone,
  String? reciverFullAddress,
  String? receiverAddress,
  String? senderAddress,
  String? bookingType,
  String? bookingDate,
  String? bookingTime,
  String? senderLatitude,
  String? senderLongitude,
  String? receiverLatitude,
  String? receiverLongitude,
  String? meterialCategory,
  String? categoryName,
  num? distance,
}) => Data(  saleId: saleId ?? _saleId,
  orderId: orderId ?? _orderId,
  senderName: senderName ?? _senderName,
  senderPhone: senderPhone ?? _senderPhone,
  receiverName: receiverName ?? _receiverName,
  receiverPhone: receiverPhone ?? _receiverPhone,
  reciverFullAddress: reciverFullAddress ?? _reciverFullAddress,
  receiverAddress: receiverAddress ?? _receiverAddress,
  senderAddress: senderAddress ?? _senderAddress,
  bookingType: bookingType ?? _bookingType,
  bookingDate: bookingDate ?? _bookingDate,
  bookingTime: bookingTime ?? _bookingTime,
  senderLatitude: senderLatitude ?? _senderLatitude,
  senderLongitude: senderLongitude ?? _senderLongitude,
  receiverLatitude: receiverLatitude ?? _receiverLatitude,
  receiverLongitude: receiverLongitude ?? _receiverLongitude,
  meterialCategory: meterialCategory ?? _meterialCategory,
  categoryName: categoryName ?? _categoryName,
  distance: distance ?? _distance,
);
  String? get saleId => _saleId;
  String? get orderId => _orderId;
  String? get senderName => _senderName;
  String? get senderPhone => _senderPhone;
  String? get receiverName => _receiverName;
  String? get receiverPhone => _receiverPhone;
  String? get reciverFullAddress => _reciverFullAddress;
  String? get receiverAddress => _receiverAddress;
  String? get senderAddress => _senderAddress;
  String? get bookingType => _bookingType;
  String? get bookingDate => _bookingDate;
  String? get bookingTime => _bookingTime;
  String? get senderLatitude => _senderLatitude;
  String? get senderLongitude => _senderLongitude;
  String? get receiverLatitude => _receiverLatitude;
  String? get receiverLongitude => _receiverLongitude;
  String? get meterialCategory => _meterialCategory;
  String? get categoryName => _categoryName;
  num? get distance => _distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sale_id'] = _saleId;
    map['order_id'] = _orderId;
    map['sender_name'] = _senderName;
    map['sender_phone'] = _senderPhone;
    map['receiver_name'] = _receiverName;
    map['receiver_phone'] = _receiverPhone;
    map['reciver_full_address'] = _reciverFullAddress;
    map['receiver_address'] = _receiverAddress;
    map['sender_address'] = _senderAddress;
    map['booking_type'] = _bookingType;
    map['booking_date'] = _bookingDate;
    map['booking_time'] = _bookingTime;
    map['sender_latitude'] = _senderLatitude;
    map['sender_longitude'] = _senderLongitude;
    map['receiver_latitude'] = _receiverLatitude;
    map['receiver_longitude'] = _receiverLongitude;
    map['meterial_category'] = _meterialCategory;
    map['category_name'] = _categoryName;
    map['distance'] = _distance;
    return map;
  }

}
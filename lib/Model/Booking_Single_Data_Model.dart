/// error : false
/// message : "Data Get Sucessfully"
/// data : {"sale_id":"256","order_id":"264","receiver_name":"harish choudhary ","receiver_phone":"7854669985","reciver_full_address":"test","receiver_address":"919, Part I, Scheme No 114, Indore, Madhya Pradesh 452010, India","sender_address":"151, Indore, Madhya Pradesh, India","booking_type":"1","booking_date":"2024-01-10","booking_time":"07:03 PM","meterial_category":"71","category_name":"Ceramic"}

class BookingSingleDataModel {
  BookingSingleDataModel({
      bool? error,
      String? message,
      Data? data,}){
    _error = error;
    _message = message;
    _data = data;
}

  BookingSingleDataModel.fromJson(dynamic json) {
    _error = json['error'];
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? _error;
  String? _message;
  Data? _data;
BookingSingleDataModel copyWith({  bool? error,
  String? message,
  Data? data,
}) => BookingSingleDataModel(  error: error ?? _error,
  message: message ?? _message,
  data: data ?? _data,
);
  bool? get error => _error;
  String? get message => _message;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['error'] = _error;
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

/// sale_id : "256"
/// order_id : "264"
/// receiver_name : "harish choudhary "
/// receiver_phone : "7854669985"
/// reciver_full_address : "test"
/// receiver_address : "919, Part I, Scheme No 114, Indore, Madhya Pradesh 452010, India"
/// sender_address : "151, Indore, Madhya Pradesh, India"
/// booking_type : "1"
/// booking_date : "2024-01-10"
/// booking_time : "07:03 PM"
/// meterial_category : "71"
/// category_name : "Ceramic"

class Data {
  Data({
      String? saleId,
      String? orderId,
      String? receiverName,
      String? receiverPhone,
      String? reciverFullAddress,
      String? receiverAddress,
      String? senderAddress,
      String? bookingType,
      String? bookingDate,
      String? bookingTime,
      String? meterialCategory,
      String? categoryName,}){
    _saleId = saleId;
    _orderId = orderId;
    _receiverName = receiverName;
    _receiverPhone = receiverPhone;
    _reciverFullAddress = reciverFullAddress;
    _receiverAddress = receiverAddress;
    _senderAddress = senderAddress;
    _bookingType = bookingType;
    _bookingDate = bookingDate;
    _bookingTime = bookingTime;
    _meterialCategory = meterialCategory;
    _categoryName = categoryName;
}

  Data.fromJson(dynamic json) {
    _saleId = json['sale_id'];
    _orderId = json['order_id'];
    _receiverName = json['receiver_name'];
    _receiverPhone = json['receiver_phone'];
    _reciverFullAddress = json['reciver_full_address'];
    _receiverAddress = json['receiver_address'];
    _senderAddress = json['sender_address'];
    _bookingType = json['booking_type'];
    _bookingDate = json['booking_date'];
    _bookingTime = json['booking_time'];
    _meterialCategory = json['meterial_category'];
    _categoryName = json['category_name'];
  }
  String? _saleId;
  String? _orderId;
  String? _receiverName;
  String? _receiverPhone;
  String? _reciverFullAddress;
  String? _receiverAddress;
  String? _senderAddress;
  String? _bookingType;
  String? _bookingDate;
  String? _bookingTime;
  String? _meterialCategory;
  String? _categoryName;
Data copyWith({  String? saleId,
  String? orderId,
  String? receiverName,
  String? receiverPhone,
  String? reciverFullAddress,
  String? receiverAddress,
  String? senderAddress,
  String? bookingType,
  String? bookingDate,
  String? bookingTime,
  String? meterialCategory,
  String? categoryName,
}) => Data(  saleId: saleId ?? _saleId,
  orderId: orderId ?? _orderId,
  receiverName: receiverName ?? _receiverName,
  receiverPhone: receiverPhone ?? _receiverPhone,
  reciverFullAddress: reciverFullAddress ?? _reciverFullAddress,
  receiverAddress: receiverAddress ?? _receiverAddress,
  senderAddress: senderAddress ?? _senderAddress,
  bookingType: bookingType ?? _bookingType,
  bookingDate: bookingDate ?? _bookingDate,
  bookingTime: bookingTime ?? _bookingTime,
  meterialCategory: meterialCategory ?? _meterialCategory,
  categoryName: categoryName ?? _categoryName,
);
  String? get saleId => _saleId;
  String? get orderId => _orderId;
  String? get receiverName => _receiverName;
  String? get receiverPhone => _receiverPhone;
  String? get reciverFullAddress => _reciverFullAddress;
  String? get receiverAddress => _receiverAddress;
  String? get senderAddress => _senderAddress;
  String? get bookingType => _bookingType;
  String? get bookingDate => _bookingDate;
  String? get bookingTime => _bookingTime;
  String? get meterialCategory => _meterialCategory;
  String? get categoryName => _categoryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sale_id'] = _saleId;
    map['order_id'] = _orderId;
    map['receiver_name'] = _receiverName;
    map['receiver_phone'] = _receiverPhone;
    map['reciver_full_address'] = _reciverFullAddress;
    map['receiver_address'] = _receiverAddress;
    map['sender_address'] = _senderAddress;
    map['booking_type'] = _bookingType;
    map['booking_date'] = _bookingDate;
    map['booking_time'] = _bookingTime;
    map['meterial_category'] = _meterialCategory;
    map['category_name'] = _categoryName;
    return map;
  }

}
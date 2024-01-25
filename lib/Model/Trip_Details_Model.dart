/// status : true
/// data : [{"sale_id":"43","order_id":"55","barcode":"","barcode_link":"","user_id":"194","delivery_boy_id":"0","booking_ref":"17061792061","sender_name":"friday","sender_address":"Man Rood Redison Choraha Indore, Ratna Lok Colony Rd, near by Hanuman Mandir, Ratna Lok Colony, Indore, Madhya Pradesh 452011, India","sender_fulladdress":"Man Rood Redison Choraha Indore, Ratna Lok Colony Rd, near by Hanuman Mandir, Ratna Lok Colony, Indore, Madhya Pradesh 452011, India","receiver_name":"test","receiver_phone":"7888485555","receiver_address":"43, Sheetal Nagar, Sceme No 54, Vijay Nagar, Indore, Madhya Pradesh 452011, India","req_deliveryboy_ids":"191,199,201,202,203,208,216,218,221,223,229,230,234,236,248,251,263,328","on_date":"2024-01-25","delivery_time_from":"04:10:06pm","delivery_time_to":null,"slottime":null,"status":"6","note":null,"is_paid":"1","shipping_charge":null,"coupon_discount":"0","coupon_code":"","total_amount":"57","total_rewards":null,"total_kg":null,"total_items":null,"socity_id":null,"address_id":null,"delivery_address":null,"area":null,"location_id":null,"delivery_charge":"0","new_store_id":"0","assign_to":"0","payment_method":"Cash On Delivery","payment_types":"","First_name":null,"Last_name":null,"email":null,"phone_no":"4444444444","zip_code":null,"date_time":"2024-01-25 04:10","deliveryboy_order_status":null,"assigned_time":null,"is_status":"1","delivery_latitude":null,"delivery_longitude":null,"order_received_time":null,"food_prepare_time":null,"order_pickup_time":null,"order_delivered_time":null,"order_time_complete":null,"city":null,"distance":"0.15","reciver_full_address":"test","sender_latitude":"22.7480953","sender_longitude":"75.8987934","receiver_latitude":"22.7481372","receiver_longitude":"75.8973604","parcel_photo":null,"is_cod_order_verify":null,"account_name":null,"account_number":null,"booking_type":"0","booking_date":"2024-1-25 1","booking_time":" 16:8","cab_id":"1","parcel_history":"0","otp":"316118","sender_otp":"0","receiver_otp":"0","message":"","driver_name":"","driver_phone":"","driver_email":"","user_image":"","unique_id":"PP23001","new_date":"1970-Jan-01","material_info":{"sale_item_id":"43","sale_id":"43","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"57","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"68","parcel_weight":"20","material_cat_name":"Wood"},"driver_details":{"cab_img":"https://developmentalphawizz.com/pickport/uploads/cap/image121.png","cab_name":"2 wheeler Gear","user_image":"https://developmentalphawizz.com/pickport/api/uploads/profile/"}}]
/// total_cost : 57
/// message : "Record found"
/// total_record : 1
/// order_id : "55"

class TripDetailsModel {
  TripDetailsModel({
      bool? status, 
      List<Data>? data, 
      num? totalCost, 
      String? message, 
      num? totalRecord, 
      String? orderId,}){
    _status = status;
    _data = data;
    _totalCost = totalCost;
    _message = message;
    _totalRecord = totalRecord;
    _orderId = orderId;
}

  TripDetailsModel.fromJson(dynamic json) {
    _status = json['status'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(Data.fromJson(v));
      });
    }
    _totalCost = json['total_cost'];
    _message = json['message'];
    _totalRecord = json['total_record'];
    _orderId = json['order_id'];
  }
  bool? _status;
  List<Data>? _data;
  num? _totalCost;
  String? _message;
  num? _totalRecord;
  String? _orderId;
TripDetailsModel copyWith({  bool? status,
  List<Data>? data,
  num? totalCost,
  String? message,
  num? totalRecord,
  String? orderId,
}) => TripDetailsModel(  status: status ?? _status,
  data: data ?? _data,
  totalCost: totalCost ?? _totalCost,
  message: message ?? _message,
  totalRecord: totalRecord ?? _totalRecord,
  orderId: orderId ?? _orderId,
);
  bool? get status => _status;
  List<Data>? get data => _data;
  num? get totalCost => _totalCost;
  String? get message => _message;
  num? get totalRecord => _totalRecord;
  String? get orderId => _orderId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    map['total_cost'] = _totalCost;
    map['message'] = _message;
    map['total_record'] = _totalRecord;
    map['order_id'] = _orderId;
    return map;
  }

}

/// sale_id : "43"
/// order_id : "55"
/// barcode : ""
/// barcode_link : ""
/// user_id : "194"
/// delivery_boy_id : "0"
/// booking_ref : "17061792061"
/// sender_name : "friday"
/// sender_address : "Man Rood Redison Choraha Indore, Ratna Lok Colony Rd, near by Hanuman Mandir, Ratna Lok Colony, Indore, Madhya Pradesh 452011, India"
/// sender_fulladdress : "Man Rood Redison Choraha Indore, Ratna Lok Colony Rd, near by Hanuman Mandir, Ratna Lok Colony, Indore, Madhya Pradesh 452011, India"
/// receiver_name : "test"
/// receiver_phone : "7888485555"
/// receiver_address : "43, Sheetal Nagar, Sceme No 54, Vijay Nagar, Indore, Madhya Pradesh 452011, India"
/// req_deliveryboy_ids : "191,199,201,202,203,208,216,218,221,223,229,230,234,236,248,251,263,328"
/// on_date : "2024-01-25"
/// delivery_time_from : "04:10:06pm"
/// delivery_time_to : null
/// slottime : null
/// status : "6"
/// note : null
/// is_paid : "1"
/// shipping_charge : null
/// coupon_discount : "0"
/// coupon_code : ""
/// total_amount : "57"
/// total_rewards : null
/// total_kg : null
/// total_items : null
/// socity_id : null
/// address_id : null
/// delivery_address : null
/// area : null
/// location_id : null
/// delivery_charge : "0"
/// new_store_id : "0"
/// assign_to : "0"
/// payment_method : "Cash On Delivery"
/// payment_types : ""
/// First_name : null
/// Last_name : null
/// email : null
/// phone_no : "4444444444"
/// zip_code : null
/// date_time : "2024-01-25 04:10"
/// deliveryboy_order_status : null
/// assigned_time : null
/// is_status : "1"
/// delivery_latitude : null
/// delivery_longitude : null
/// order_received_time : null
/// food_prepare_time : null
/// order_pickup_time : null
/// order_delivered_time : null
/// order_time_complete : null
/// city : null
/// distance : "0.15"
/// reciver_full_address : "test"
/// sender_latitude : "22.7480953"
/// sender_longitude : "75.8987934"
/// receiver_latitude : "22.7481372"
/// receiver_longitude : "75.8973604"
/// parcel_photo : null
/// is_cod_order_verify : null
/// account_name : null
/// account_number : null
/// booking_type : "0"
/// booking_date : "2024-1-25 1"
/// booking_time : " 16:8"
/// cab_id : "1"
/// parcel_history : "0"
/// otp : "316118"
/// sender_otp : "0"
/// receiver_otp : "0"
/// message : ""
/// driver_name : ""
/// driver_phone : ""
/// driver_email : ""
/// user_image : ""
/// unique_id : "PP23001"
/// new_date : "1970-Jan-01"
/// material_info : {"sale_item_id":"43","sale_id":"43","product_id":"0","product_name":"","qty":"0","unit":"","unit_value":"0","price":"57","qty_in_kg":"0","rewards":"","discountprice":"0","meterial_category":"68","parcel_weight":"20","material_cat_name":"Wood"}
/// driver_details : {"cab_img":"https://developmentalphawizz.com/pickport/uploads/cap/image121.png","cab_name":"2 wheeler Gear","user_image":"https://developmentalphawizz.com/pickport/api/uploads/profile/"}

class Data {
  Data({
      String? saleId, 
      String? orderId, 
      String? barcode, 
      String? barcodeLink, 
      String? userId, 
      String? deliveryBoyId, 
      String? bookingRef, 
      String? senderName, 
      String? senderAddress, 
      String? senderFulladdress, 
      String? receiverName, 
      String? receiverPhone, 
      String? receiverAddress, 
      String? reqDeliveryboyIds, 
      String? onDate, 
      String? deliveryTimeFrom, 
      dynamic deliveryTimeTo, 
      dynamic slottime, 
      String? status, 
      dynamic note, 
      String? isPaid, 
      dynamic shippingCharge, 
      String? couponDiscount, 
      String? couponCode, 
      String? totalAmount, 
      dynamic totalRewards, 
      dynamic totalKg, 
      dynamic totalItems, 
      dynamic socityId, 
      dynamic addressId, 
      dynamic deliveryAddress, 
      dynamic area, 
      dynamic locationId, 
      String? deliveryCharge, 
      String? newStoreId, 
      String? assignTo, 
      String? paymentMethod, 
      String? paymentTypes, 
      dynamic firstName, 
      dynamic lastName, 
      dynamic email, 
      String? phoneNo, 
      dynamic zipCode, 
      String? dateTime, 
      dynamic deliveryboyOrderStatus, 
      dynamic assignedTime, 
      String? isStatus, 
      dynamic deliveryLatitude, 
      dynamic deliveryLongitude, 
      dynamic orderReceivedTime, 
      dynamic foodPrepareTime, 
      dynamic orderPickupTime, 
      dynamic orderDeliveredTime, 
      dynamic orderTimeComplete, 
      dynamic city, 
      String? distance, 
      String? reciverFullAddress, 
      String? senderLatitude, 
      String? senderLongitude, 
      String? receiverLatitude, 
      String? receiverLongitude, 
      dynamic parcelPhoto, 
      dynamic isCodOrderVerify, 
      dynamic accountName, 
      dynamic accountNumber, 
      String? bookingType, 
      String? bookingDate, 
      String? bookingTime, 
      String? cabId, 
      String? parcelHistory, 
      String? otp, 
      String? senderOtp, 
      String? receiverOtp, 
      String? message, 
      String? driverName, 
      String? driverPhone, 
      String? driverEmail, 
      String? userImage, 
      String? uniqueId, 
      String? newDate, 
      MaterialInfo? materialInfo, 
      DriverDetails? driverDetails,}){
    _saleId = saleId;
    _orderId = orderId;
    _barcode = barcode;
    _barcodeLink = barcodeLink;
    _userId = userId;
    _deliveryBoyId = deliveryBoyId;
    _bookingRef = bookingRef;
    _senderName = senderName;
    _senderAddress = senderAddress;
    _senderFulladdress = senderFulladdress;
    _receiverName = receiverName;
    _receiverPhone = receiverPhone;
    _receiverAddress = receiverAddress;
    _reqDeliveryboyIds = reqDeliveryboyIds;
    _onDate = onDate;
    _deliveryTimeFrom = deliveryTimeFrom;
    _deliveryTimeTo = deliveryTimeTo;
    _slottime = slottime;
    _status = status;
    _note = note;
    _isPaid = isPaid;
    _shippingCharge = shippingCharge;
    _couponDiscount = couponDiscount;
    _couponCode = couponCode;
    _totalAmount = totalAmount;
    _totalRewards = totalRewards;
    _totalKg = totalKg;
    _totalItems = totalItems;
    _socityId = socityId;
    _addressId = addressId;
    _deliveryAddress = deliveryAddress;
    _area = area;
    _locationId = locationId;
    _deliveryCharge = deliveryCharge;
    _newStoreId = newStoreId;
    _assignTo = assignTo;
    _paymentMethod = paymentMethod;
    _paymentTypes = paymentTypes;
    _firstName = firstName;
    _lastName = lastName;
    _email = email;
    _phoneNo = phoneNo;
    _zipCode = zipCode;
    _dateTime = dateTime;
    _deliveryboyOrderStatus = deliveryboyOrderStatus;
    _assignedTime = assignedTime;
    _isStatus = isStatus;
    _deliveryLatitude = deliveryLatitude;
    _deliveryLongitude = deliveryLongitude;
    _orderReceivedTime = orderReceivedTime;
    _foodPrepareTime = foodPrepareTime;
    _orderPickupTime = orderPickupTime;
    _orderDeliveredTime = orderDeliveredTime;
    _orderTimeComplete = orderTimeComplete;
    _city = city;
    _distance = distance;
    _reciverFullAddress = reciverFullAddress;
    _senderLatitude = senderLatitude;
    _senderLongitude = senderLongitude;
    _receiverLatitude = receiverLatitude;
    _receiverLongitude = receiverLongitude;
    _parcelPhoto = parcelPhoto;
    _isCodOrderVerify = isCodOrderVerify;
    _accountName = accountName;
    _accountNumber = accountNumber;
    _bookingType = bookingType;
    _bookingDate = bookingDate;
    _bookingTime = bookingTime;
    _cabId = cabId;
    _parcelHistory = parcelHistory;
    _otp = otp;
    _senderOtp = senderOtp;
    _receiverOtp = receiverOtp;
    _message = message;
    _driverName = driverName;
    _driverPhone = driverPhone;
    _driverEmail = driverEmail;
    _userImage = userImage;
    _uniqueId = uniqueId;
    _newDate = newDate;
    _materialInfo = materialInfo;
    _driverDetails = driverDetails;
}

  Data.fromJson(dynamic json) {
    _saleId = json['sale_id'];
    _orderId = json['order_id'];
    _barcode = json['barcode'];
    _barcodeLink = json['barcode_link'];
    _userId = json['user_id'];
    _deliveryBoyId = json['delivery_boy_id'];
    _bookingRef = json['booking_ref'];
    _senderName = json['sender_name'];
    _senderAddress = json['sender_address'];
    _senderFulladdress = json['sender_fulladdress'];
    _receiverName = json['receiver_name'];
    _receiverPhone = json['receiver_phone'];
    _receiverAddress = json['receiver_address'];
    _reqDeliveryboyIds = json['req_deliveryboy_ids'];
    _onDate = json['on_date'];
    _deliveryTimeFrom = json['delivery_time_from'];
    _deliveryTimeTo = json['delivery_time_to'];
    _slottime = json['slottime'];
    _status = json['status'];
    _note = json['note'];
    _isPaid = json['is_paid'];
    _shippingCharge = json['shipping_charge'];
    _couponDiscount = json['coupon_discount'];
    _couponCode = json['coupon_code'];
    _totalAmount = json['total_amount'];
    _totalRewards = json['total_rewards'];
    _totalKg = json['total_kg'];
    _totalItems = json['total_items'];
    _socityId = json['socity_id'];
    _addressId = json['address_id'];
    _deliveryAddress = json['delivery_address'];
    _area = json['area'];
    _locationId = json['location_id'];
    _deliveryCharge = json['delivery_charge'];
    _newStoreId = json['new_store_id'];
    _assignTo = json['assign_to'];
    _paymentMethod = json['payment_method'];
    _paymentTypes = json['payment_types'];
    _firstName = json['First_name'];
    _lastName = json['Last_name'];
    _email = json['email'];
    _phoneNo = json['phone_no'];
    _zipCode = json['zip_code'];
    _dateTime = json['date_time'];
    _deliveryboyOrderStatus = json['deliveryboy_order_status'];
    _assignedTime = json['assigned_time'];
    _isStatus = json['is_status'];
    _deliveryLatitude = json['delivery_latitude'];
    _deliveryLongitude = json['delivery_longitude'];
    _orderReceivedTime = json['order_received_time'];
    _foodPrepareTime = json['food_prepare_time'];
    _orderPickupTime = json['order_pickup_time'];
    _orderDeliveredTime = json['order_delivered_time'];
    _orderTimeComplete = json['order_time_complete'];
    _city = json['city'];
    _distance = json['distance'];
    _reciverFullAddress = json['reciver_full_address'];
    _senderLatitude = json['sender_latitude'];
    _senderLongitude = json['sender_longitude'];
    _receiverLatitude = json['receiver_latitude'];
    _receiverLongitude = json['receiver_longitude'];
    _parcelPhoto = json['parcel_photo'];
    _isCodOrderVerify = json['is_cod_order_verify'];
    _accountName = json['account_name'];
    _accountNumber = json['account_number'];
    _bookingType = json['booking_type'];
    _bookingDate = json['booking_date'];
    _bookingTime = json['booking_time'];
    _cabId = json['cab_id'];
    _parcelHistory = json['parcel_history'];
    _otp = json['otp'];
    _senderOtp = json['sender_otp'];
    _receiverOtp = json['receiver_otp'];
    _message = json['message'];
    _driverName = json['driver_name'];
    _driverPhone = json['driver_phone'];
    _driverEmail = json['driver_email'];
    _userImage = json['user_image'];
    _uniqueId = json['unique_id'];
    _newDate = json['new_date'];
    _materialInfo = json['material_info'] != null ? MaterialInfo.fromJson(json['material_info']) : null;
    _driverDetails = json['driver_details'] != null ? DriverDetails.fromJson(json['driver_details']) : null;
  }
  String? _saleId;
  String? _orderId;
  String? _barcode;
  String? _barcodeLink;
  String? _userId;
  String? _deliveryBoyId;
  String? _bookingRef;
  String? _senderName;
  String? _senderAddress;
  String? _senderFulladdress;
  String? _receiverName;
  String? _receiverPhone;
  String? _receiverAddress;
  String? _reqDeliveryboyIds;
  String? _onDate;
  String? _deliveryTimeFrom;
  dynamic _deliveryTimeTo;
  dynamic _slottime;
  String? _status;
  dynamic _note;
  String? _isPaid;
  dynamic _shippingCharge;
  String? _couponDiscount;
  String? _couponCode;
  String? _totalAmount;
  dynamic _totalRewards;
  dynamic _totalKg;
  dynamic _totalItems;
  dynamic _socityId;
  dynamic _addressId;
  dynamic _deliveryAddress;
  dynamic _area;
  dynamic _locationId;
  String? _deliveryCharge;
  String? _newStoreId;
  String? _assignTo;
  String? _paymentMethod;
  String? _paymentTypes;
  dynamic _firstName;
  dynamic _lastName;
  dynamic _email;
  String? _phoneNo;
  dynamic _zipCode;
  String? _dateTime;
  dynamic _deliveryboyOrderStatus;
  dynamic _assignedTime;
  String? _isStatus;
  dynamic _deliveryLatitude;
  dynamic _deliveryLongitude;
  dynamic _orderReceivedTime;
  dynamic _foodPrepareTime;
  dynamic _orderPickupTime;
  dynamic _orderDeliveredTime;
  dynamic _orderTimeComplete;
  dynamic _city;
  String? _distance;
  String? _reciverFullAddress;
  String? _senderLatitude;
  String? _senderLongitude;
  String? _receiverLatitude;
  String? _receiverLongitude;
  dynamic _parcelPhoto;
  dynamic _isCodOrderVerify;
  dynamic _accountName;
  dynamic _accountNumber;
  String? _bookingType;
  String? _bookingDate;
  String? _bookingTime;
  String? _cabId;
  String? _parcelHistory;
  String? _otp;
  String? _senderOtp;
  String? _receiverOtp;
  String? _message;
  String? _driverName;
  String? _driverPhone;
  String? _driverEmail;
  String? _userImage;
  String? _uniqueId;
  String? _newDate;
  MaterialInfo? _materialInfo;
  DriverDetails? _driverDetails;
Data copyWith({  String? saleId,
  String? orderId,
  String? barcode,
  String? barcodeLink,
  String? userId,
  String? deliveryBoyId,
  String? bookingRef,
  String? senderName,
  String? senderAddress,
  String? senderFulladdress,
  String? receiverName,
  String? receiverPhone,
  String? receiverAddress,
  String? reqDeliveryboyIds,
  String? onDate,
  String? deliveryTimeFrom,
  dynamic deliveryTimeTo,
  dynamic slottime,
  String? status,
  dynamic note,
  String? isPaid,
  dynamic shippingCharge,
  String? couponDiscount,
  String? couponCode,
  String? totalAmount,
  dynamic totalRewards,
  dynamic totalKg,
  dynamic totalItems,
  dynamic socityId,
  dynamic addressId,
  dynamic deliveryAddress,
  dynamic area,
  dynamic locationId,
  String? deliveryCharge,
  String? newStoreId,
  String? assignTo,
  String? paymentMethod,
  String? paymentTypes,
  dynamic firstName,
  dynamic lastName,
  dynamic email,
  String? phoneNo,
  dynamic zipCode,
  String? dateTime,
  dynamic deliveryboyOrderStatus,
  dynamic assignedTime,
  String? isStatus,
  dynamic deliveryLatitude,
  dynamic deliveryLongitude,
  dynamic orderReceivedTime,
  dynamic foodPrepareTime,
  dynamic orderPickupTime,
  dynamic orderDeliveredTime,
  dynamic orderTimeComplete,
  dynamic city,
  String? distance,
  String? reciverFullAddress,
  String? senderLatitude,
  String? senderLongitude,
  String? receiverLatitude,
  String? receiverLongitude,
  dynamic parcelPhoto,
  dynamic isCodOrderVerify,
  dynamic accountName,
  dynamic accountNumber,
  String? bookingType,
  String? bookingDate,
  String? bookingTime,
  String? cabId,
  String? parcelHistory,
  String? otp,
  String? senderOtp,
  String? receiverOtp,
  String? message,
  String? driverName,
  String? driverPhone,
  String? driverEmail,
  String? userImage,
  String? uniqueId,
  String? newDate,
  MaterialInfo? materialInfo,
  DriverDetails? driverDetails,
}) => Data(  saleId: saleId ?? _saleId,
  orderId: orderId ?? _orderId,
  barcode: barcode ?? _barcode,
  barcodeLink: barcodeLink ?? _barcodeLink,
  userId: userId ?? _userId,
  deliveryBoyId: deliveryBoyId ?? _deliveryBoyId,
  bookingRef: bookingRef ?? _bookingRef,
  senderName: senderName ?? _senderName,
  senderAddress: senderAddress ?? _senderAddress,
  senderFulladdress: senderFulladdress ?? _senderFulladdress,
  receiverName: receiverName ?? _receiverName,
  receiverPhone: receiverPhone ?? _receiverPhone,
  receiverAddress: receiverAddress ?? _receiverAddress,
  reqDeliveryboyIds: reqDeliveryboyIds ?? _reqDeliveryboyIds,
  onDate: onDate ?? _onDate,
  deliveryTimeFrom: deliveryTimeFrom ?? _deliveryTimeFrom,
  deliveryTimeTo: deliveryTimeTo ?? _deliveryTimeTo,
  slottime: slottime ?? _slottime,
  status: status ?? _status,
  note: note ?? _note,
  isPaid: isPaid ?? _isPaid,
  shippingCharge: shippingCharge ?? _shippingCharge,
  couponDiscount: couponDiscount ?? _couponDiscount,
  couponCode: couponCode ?? _couponCode,
  totalAmount: totalAmount ?? _totalAmount,
  totalRewards: totalRewards ?? _totalRewards,
  totalKg: totalKg ?? _totalKg,
  totalItems: totalItems ?? _totalItems,
  socityId: socityId ?? _socityId,
  addressId: addressId ?? _addressId,
  deliveryAddress: deliveryAddress ?? _deliveryAddress,
  area: area ?? _area,
  locationId: locationId ?? _locationId,
  deliveryCharge: deliveryCharge ?? _deliveryCharge,
  newStoreId: newStoreId ?? _newStoreId,
  assignTo: assignTo ?? _assignTo,
  paymentMethod: paymentMethod ?? _paymentMethod,
  paymentTypes: paymentTypes ?? _paymentTypes,
  firstName: firstName ?? _firstName,
  lastName: lastName ?? _lastName,
  email: email ?? _email,
  phoneNo: phoneNo ?? _phoneNo,
  zipCode: zipCode ?? _zipCode,
  dateTime: dateTime ?? _dateTime,
  deliveryboyOrderStatus: deliveryboyOrderStatus ?? _deliveryboyOrderStatus,
  assignedTime: assignedTime ?? _assignedTime,
  isStatus: isStatus ?? _isStatus,
  deliveryLatitude: deliveryLatitude ?? _deliveryLatitude,
  deliveryLongitude: deliveryLongitude ?? _deliveryLongitude,
  orderReceivedTime: orderReceivedTime ?? _orderReceivedTime,
  foodPrepareTime: foodPrepareTime ?? _foodPrepareTime,
  orderPickupTime: orderPickupTime ?? _orderPickupTime,
  orderDeliveredTime: orderDeliveredTime ?? _orderDeliveredTime,
  orderTimeComplete: orderTimeComplete ?? _orderTimeComplete,
  city: city ?? _city,
  distance: distance ?? _distance,
  reciverFullAddress: reciverFullAddress ?? _reciverFullAddress,
  senderLatitude: senderLatitude ?? _senderLatitude,
  senderLongitude: senderLongitude ?? _senderLongitude,
  receiverLatitude: receiverLatitude ?? _receiverLatitude,
  receiverLongitude: receiverLongitude ?? _receiverLongitude,
  parcelPhoto: parcelPhoto ?? _parcelPhoto,
  isCodOrderVerify: isCodOrderVerify ?? _isCodOrderVerify,
  accountName: accountName ?? _accountName,
  accountNumber: accountNumber ?? _accountNumber,
  bookingType: bookingType ?? _bookingType,
  bookingDate: bookingDate ?? _bookingDate,
  bookingTime: bookingTime ?? _bookingTime,
  cabId: cabId ?? _cabId,
  parcelHistory: parcelHistory ?? _parcelHistory,
  otp: otp ?? _otp,
  senderOtp: senderOtp ?? _senderOtp,
  receiverOtp: receiverOtp ?? _receiverOtp,
  message: message ?? _message,
  driverName: driverName ?? _driverName,
  driverPhone: driverPhone ?? _driverPhone,
  driverEmail: driverEmail ?? _driverEmail,
  userImage: userImage ?? _userImage,
  uniqueId: uniqueId ?? _uniqueId,
  newDate: newDate ?? _newDate,
  materialInfo: materialInfo ?? _materialInfo,
  driverDetails: driverDetails ?? _driverDetails,
);
  String? get saleId => _saleId;
  String? get orderId => _orderId;
  String? get barcode => _barcode;
  String? get barcodeLink => _barcodeLink;
  String? get userId => _userId;
  String? get deliveryBoyId => _deliveryBoyId;
  String? get bookingRef => _bookingRef;
  String? get senderName => _senderName;
  String? get senderAddress => _senderAddress;
  String? get senderFulladdress => _senderFulladdress;
  String? get receiverName => _receiverName;
  String? get receiverPhone => _receiverPhone;
  String? get receiverAddress => _receiverAddress;
  String? get reqDeliveryboyIds => _reqDeliveryboyIds;
  String? get onDate => _onDate;
  String? get deliveryTimeFrom => _deliveryTimeFrom;
  dynamic get deliveryTimeTo => _deliveryTimeTo;
  dynamic get slottime => _slottime;
  String? get status => _status;
  dynamic get note => _note;
  String? get isPaid => _isPaid;
  dynamic get shippingCharge => _shippingCharge;
  String? get couponDiscount => _couponDiscount;
  String? get couponCode => _couponCode;
  String? get totalAmount => _totalAmount;
  dynamic get totalRewards => _totalRewards;
  dynamic get totalKg => _totalKg;
  dynamic get totalItems => _totalItems;
  dynamic get socityId => _socityId;
  dynamic get addressId => _addressId;
  dynamic get deliveryAddress => _deliveryAddress;
  dynamic get area => _area;
  dynamic get locationId => _locationId;
  String? get deliveryCharge => _deliveryCharge;
  String? get newStoreId => _newStoreId;
  String? get assignTo => _assignTo;
  String? get paymentMethod => _paymentMethod;
  String? get paymentTypes => _paymentTypes;
  dynamic get firstName => _firstName;
  dynamic get lastName => _lastName;
  dynamic get email => _email;
  String? get phoneNo => _phoneNo;
  dynamic get zipCode => _zipCode;
  String? get dateTime => _dateTime;
  dynamic get deliveryboyOrderStatus => _deliveryboyOrderStatus;
  dynamic get assignedTime => _assignedTime;
  String? get isStatus => _isStatus;
  dynamic get deliveryLatitude => _deliveryLatitude;
  dynamic get deliveryLongitude => _deliveryLongitude;
  dynamic get orderReceivedTime => _orderReceivedTime;
  dynamic get foodPrepareTime => _foodPrepareTime;
  dynamic get orderPickupTime => _orderPickupTime;
  dynamic get orderDeliveredTime => _orderDeliveredTime;
  dynamic get orderTimeComplete => _orderTimeComplete;
  dynamic get city => _city;
  String? get distance => _distance;
  String? get reciverFullAddress => _reciverFullAddress;
  String? get senderLatitude => _senderLatitude;
  String? get senderLongitude => _senderLongitude;
  String? get receiverLatitude => _receiverLatitude;
  String? get receiverLongitude => _receiverLongitude;
  dynamic get parcelPhoto => _parcelPhoto;
  dynamic get isCodOrderVerify => _isCodOrderVerify;
  dynamic get accountName => _accountName;
  dynamic get accountNumber => _accountNumber;
  String? get bookingType => _bookingType;
  String? get bookingDate => _bookingDate;
  String? get bookingTime => _bookingTime;
  String? get cabId => _cabId;
  String? get parcelHistory => _parcelHistory;
  String? get otp => _otp;
  String? get senderOtp => _senderOtp;
  String? get receiverOtp => _receiverOtp;
  String? get message => _message;
  String? get driverName => _driverName;
  String? get driverPhone => _driverPhone;
  String? get driverEmail => _driverEmail;
  String? get userImage => _userImage;
  String? get uniqueId => _uniqueId;
  String? get newDate => _newDate;
  MaterialInfo? get materialInfo => _materialInfo;
  DriverDetails? get driverDetails => _driverDetails;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sale_id'] = _saleId;
    map['order_id'] = _orderId;
    map['barcode'] = _barcode;
    map['barcode_link'] = _barcodeLink;
    map['user_id'] = _userId;
    map['delivery_boy_id'] = _deliveryBoyId;
    map['booking_ref'] = _bookingRef;
    map['sender_name'] = _senderName;
    map['sender_address'] = _senderAddress;
    map['sender_fulladdress'] = _senderFulladdress;
    map['receiver_name'] = _receiverName;
    map['receiver_phone'] = _receiverPhone;
    map['receiver_address'] = _receiverAddress;
    map['req_deliveryboy_ids'] = _reqDeliveryboyIds;
    map['on_date'] = _onDate;
    map['delivery_time_from'] = _deliveryTimeFrom;
    map['delivery_time_to'] = _deliveryTimeTo;
    map['slottime'] = _slottime;
    map['status'] = _status;
    map['note'] = _note;
    map['is_paid'] = _isPaid;
    map['shipping_charge'] = _shippingCharge;
    map['coupon_discount'] = _couponDiscount;
    map['coupon_code'] = _couponCode;
    map['total_amount'] = _totalAmount;
    map['total_rewards'] = _totalRewards;
    map['total_kg'] = _totalKg;
    map['total_items'] = _totalItems;
    map['socity_id'] = _socityId;
    map['address_id'] = _addressId;
    map['delivery_address'] = _deliveryAddress;
    map['area'] = _area;
    map['location_id'] = _locationId;
    map['delivery_charge'] = _deliveryCharge;
    map['new_store_id'] = _newStoreId;
    map['assign_to'] = _assignTo;
    map['payment_method'] = _paymentMethod;
    map['payment_types'] = _paymentTypes;
    map['First_name'] = _firstName;
    map['Last_name'] = _lastName;
    map['email'] = _email;
    map['phone_no'] = _phoneNo;
    map['zip_code'] = _zipCode;
    map['date_time'] = _dateTime;
    map['deliveryboy_order_status'] = _deliveryboyOrderStatus;
    map['assigned_time'] = _assignedTime;
    map['is_status'] = _isStatus;
    map['delivery_latitude'] = _deliveryLatitude;
    map['delivery_longitude'] = _deliveryLongitude;
    map['order_received_time'] = _orderReceivedTime;
    map['food_prepare_time'] = _foodPrepareTime;
    map['order_pickup_time'] = _orderPickupTime;
    map['order_delivered_time'] = _orderDeliveredTime;
    map['order_time_complete'] = _orderTimeComplete;
    map['city'] = _city;
    map['distance'] = _distance;
    map['reciver_full_address'] = _reciverFullAddress;
    map['sender_latitude'] = _senderLatitude;
    map['sender_longitude'] = _senderLongitude;
    map['receiver_latitude'] = _receiverLatitude;
    map['receiver_longitude'] = _receiverLongitude;
    map['parcel_photo'] = _parcelPhoto;
    map['is_cod_order_verify'] = _isCodOrderVerify;
    map['account_name'] = _accountName;
    map['account_number'] = _accountNumber;
    map['booking_type'] = _bookingType;
    map['booking_date'] = _bookingDate;
    map['booking_time'] = _bookingTime;
    map['cab_id'] = _cabId;
    map['parcel_history'] = _parcelHistory;
    map['otp'] = _otp;
    map['sender_otp'] = _senderOtp;
    map['receiver_otp'] = _receiverOtp;
    map['message'] = _message;
    map['driver_name'] = _driverName;
    map['driver_phone'] = _driverPhone;
    map['driver_email'] = _driverEmail;
    map['user_image'] = _userImage;
    map['unique_id'] = _uniqueId;
    map['new_date'] = _newDate;
    if (_materialInfo != null) {
      map['material_info'] = _materialInfo?.toJson();
    }
    if (_driverDetails != null) {
      map['driver_details'] = _driverDetails?.toJson();
    }
    return map;
  }

}

/// cab_img : "https://developmentalphawizz.com/pickport/uploads/cap/image121.png"
/// cab_name : "2 wheeler Gear"
/// user_image : "https://developmentalphawizz.com/pickport/api/uploads/profile/"

class DriverDetails {
  DriverDetails({
      String? cabImg, 
      String? cabName, 
      String? userImage,}){
    _cabImg = cabImg;
    _cabName = cabName;
    _userImage = userImage;
}

  DriverDetails.fromJson(dynamic json) {
    _cabImg = json['cab_img'];
    _cabName = json['cab_name'];
    _userImage = json['user_image'];
  }
  String? _cabImg;
  String? _cabName;
  String? _userImage;
DriverDetails copyWith({  String? cabImg,
  String? cabName,
  String? userImage,
}) => DriverDetails(  cabImg: cabImg ?? _cabImg,
  cabName: cabName ?? _cabName,
  userImage: userImage ?? _userImage,
);
  String? get cabImg => _cabImg;
  String? get cabName => _cabName;
  String? get userImage => _userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['cab_img'] = _cabImg;
    map['cab_name'] = _cabName;
    map['user_image'] = _userImage;
    return map;
  }

}

/// sale_item_id : "43"
/// sale_id : "43"
/// product_id : "0"
/// product_name : ""
/// qty : "0"
/// unit : ""
/// unit_value : "0"
/// price : "57"
/// qty_in_kg : "0"
/// rewards : ""
/// discountprice : "0"
/// meterial_category : "68"
/// parcel_weight : "20"
/// material_cat_name : "Wood"

class MaterialInfo {
  MaterialInfo({
      String? saleItemId, 
      String? saleId, 
      String? productId, 
      String? productName, 
      String? qty, 
      String? unit, 
      String? unitValue, 
      String? price, 
      String? qtyInKg, 
      String? rewards, 
      String? discountprice, 
      String? meterialCategory, 
      String? parcelWeight, 
      String? materialCatName,}){
    _saleItemId = saleItemId;
    _saleId = saleId;
    _productId = productId;
    _productName = productName;
    _qty = qty;
    _unit = unit;
    _unitValue = unitValue;
    _price = price;
    _qtyInKg = qtyInKg;
    _rewards = rewards;
    _discountprice = discountprice;
    _meterialCategory = meterialCategory;
    _parcelWeight = parcelWeight;
    _materialCatName = materialCatName;
}

  MaterialInfo.fromJson(dynamic json) {
    _saleItemId = json['sale_item_id'];
    _saleId = json['sale_id'];
    _productId = json['product_id'];
    _productName = json['product_name'];
    _qty = json['qty'];
    _unit = json['unit'];
    _unitValue = json['unit_value'];
    _price = json['price'];
    _qtyInKg = json['qty_in_kg'];
    _rewards = json['rewards'];
    _discountprice = json['discountprice'];
    _meterialCategory = json['meterial_category'];
    _parcelWeight = json['parcel_weight'];
    _materialCatName = json['material_cat_name'];
  }
  String? _saleItemId;
  String? _saleId;
  String? _productId;
  String? _productName;
  String? _qty;
  String? _unit;
  String? _unitValue;
  String? _price;
  String? _qtyInKg;
  String? _rewards;
  String? _discountprice;
  String? _meterialCategory;
  String? _parcelWeight;
  String? _materialCatName;
MaterialInfo copyWith({  String? saleItemId,
  String? saleId,
  String? productId,
  String? productName,
  String? qty,
  String? unit,
  String? unitValue,
  String? price,
  String? qtyInKg,
  String? rewards,
  String? discountprice,
  String? meterialCategory,
  String? parcelWeight,
  String? materialCatName,
}) => MaterialInfo(  saleItemId: saleItemId ?? _saleItemId,
  saleId: saleId ?? _saleId,
  productId: productId ?? _productId,
  productName: productName ?? _productName,
  qty: qty ?? _qty,
  unit: unit ?? _unit,
  unitValue: unitValue ?? _unitValue,
  price: price ?? _price,
  qtyInKg: qtyInKg ?? _qtyInKg,
  rewards: rewards ?? _rewards,
  discountprice: discountprice ?? _discountprice,
  meterialCategory: meterialCategory ?? _meterialCategory,
  parcelWeight: parcelWeight ?? _parcelWeight,
  materialCatName: materialCatName ?? _materialCatName,
);
  String? get saleItemId => _saleItemId;
  String? get saleId => _saleId;
  String? get productId => _productId;
  String? get productName => _productName;
  String? get qty => _qty;
  String? get unit => _unit;
  String? get unitValue => _unitValue;
  String? get price => _price;
  String? get qtyInKg => _qtyInKg;
  String? get rewards => _rewards;
  String? get discountprice => _discountprice;
  String? get meterialCategory => _meterialCategory;
  String? get parcelWeight => _parcelWeight;
  String? get materialCatName => _materialCatName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sale_item_id'] = _saleItemId;
    map['sale_id'] = _saleId;
    map['product_id'] = _productId;
    map['product_name'] = _productName;
    map['qty'] = _qty;
    map['unit'] = _unit;
    map['unit_value'] = _unitValue;
    map['price'] = _price;
    map['qty_in_kg'] = _qtyInKg;
    map['rewards'] = _rewards;
    map['discountprice'] = _discountprice;
    map['meterial_category'] = _meterialCategory;
    map['parcel_weight'] = _parcelWeight;
    map['material_cat_name'] = _materialCatName;
    return map;
  }

}
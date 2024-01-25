class ParcelhistoryModel {
  bool? status;
  String? message;
  int? totalRecord;
  List<Data>? data;

  ParcelhistoryModel({this.status, this.message, this.totalRecord, this.data});

  ParcelhistoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    totalRecord = json['total_record'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    data['total_record'] = this.totalRecord;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? orderId;
  String? userId;
  String? senderName;
  String? senderAddress;
  String? senderFulladdress;
  String? orderAmount;
  String? paymentMethod;
  String? phoneNo;
  String? isPaid;
  String? senderLatitude;
  String? senderLongitude;
  String? onDate;
  String? deliveryTimeFrom;
  String? saleIds;
  String? otp;
  String? orderStatus;
  String? status;
  String? totalAmount;
  ParcelDetails? parcelDetails;

  Data(
      {this.orderId,
        this.userId,
        this.senderName,
        this.senderAddress,
        this.senderFulladdress,
        this.orderAmount,
        this.paymentMethod,
        this.phoneNo,
        this.isPaid,
        this.senderLatitude,
        this.senderLongitude,
        this.onDate,
        this.deliveryTimeFrom,
        this.saleIds,
        this.otp,
        this.orderStatus,
        this.status,
        this.totalAmount,
        this.parcelDetails});

  Data.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    userId = json['user_id'];
    senderName = json['sender_name'];
    senderAddress = json['sender_address'];
    senderFulladdress = json['sender_fulladdress'];
    orderAmount = json['order_amount'];
    paymentMethod = json['payment_method'];
    phoneNo = json['phone_no'];
    isPaid = json['is_paid'];
    senderLatitude = json['sender_latitude'];
    senderLongitude = json['sender_longitude'];
    onDate = json['on_date'];
    deliveryTimeFrom = json['delivery_time_from'];
    saleIds = json['sale_ids'];
    otp = json['otp'];
    orderStatus = json['order_status'];
    status = json['status'];
    totalAmount = json['total_amount'];
    parcelDetails = json['parcel_details'] != null
        ? new ParcelDetails.fromJson(json['parcel_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_id'] = this.orderId;
    data['user_id'] = this.userId;
    data['sender_name'] = this.senderName;
    data['sender_address'] = this.senderAddress;
    data['sender_fulladdress'] = this.senderFulladdress;
    data['order_amount'] = this.orderAmount;
    data['payment_method'] = this.paymentMethod;
    data['phone_no'] = this.phoneNo;
    data['is_paid'] = this.isPaid;
    data['sender_latitude'] = this.senderLatitude;
    data['sender_longitude'] = this.senderLongitude;
    data['on_date'] = this.onDate;
    data['delivery_time_from'] = this.deliveryTimeFrom;
    data['sale_ids'] = this.saleIds;
    data['otp'] = this.otp;
    data['order_status'] = this.orderStatus;
    data['status'] = this.status;
    data['total_amount'] = this.totalAmount;
    if (this.parcelDetails != null) {
      data['parcel_details'] = this.parcelDetails!.toJson();
    }
    return data;
  }
}

class ParcelDetails {
  String? saleId;
  String? orderId;
  String? barcode;
  String? barcodeLink;
  String? userId;
  String? deliveryBoyId;
  String? bookingRef;
  String? senderName;
  String? senderAddress;
  String? senderFulladdress;
  String? receiverName;
  String? receiverPhone;
  String? receiverAddress;
  String? reqDeliveryboyIds;
  String? onDate;
  String? deliveryTimeFrom;
  Null? deliveryTimeTo;
  Null? slottime;
  String? status;
  Null? note;
  String? isPaid;
  Null? shippingCharge;
  String? couponDiscount;
  String? couponCode;
  String? totalAmount;
  Null? totalRewards;
  Null? totalKg;
  Null? totalItems;
  Null? socityId;
  Null? addressId;
  Null? deliveryAddress;
  Null? area;
  Null? locationId;
  String? deliveryCharge;
  String? newStoreId;
  String? assignTo;
  String? paymentMethod;
  String? paymentTypes;
  Null? firstName;
  Null? lastName;
  Null? email;
  String? phoneNo;
  Null? zipCode;
  String? dateTime;
  Null? deliveryboyOrderStatus;
  String? assignedTime;
  String? isStatus;
  Null? deliveryLatitude;
  Null? deliveryLongitude;
  String? orderReceivedTime;
  Null? foodPrepareTime;
  Null? orderPickupTime;
  Null? orderDeliveredTime;
  Null? orderTimeComplete;
  Null? city;
  String? distance;
  String? reciverFullAddress;
  String? senderLatitude;
  String? senderLongitude;
  String? receiverLatitude;
  String? receiverLongitude;
  Null? parcelPhoto;
  Null? isCodOrderVerify;
  Null? accountName;
  Null? accountNumber;
  String? bookingType;
  String? bookingDate;
  String? bookingTime;
  String? cabId;
  String? parcelHistory;
  String? otp;
  String? senderOtp;
  String? receiverOtp;
  String? message;
  MaterialInfo? materialInfo;

  ParcelDetails(
      {this.saleId,
        this.orderId,
        this.barcode,
        this.barcodeLink,
        this.userId,
        this.deliveryBoyId,
        this.bookingRef,
        this.senderName,
        this.senderAddress,
        this.senderFulladdress,
        this.receiverName,
        this.receiverPhone,
        this.receiverAddress,
        this.reqDeliveryboyIds,
        this.onDate,
        this.deliveryTimeFrom,
        this.deliveryTimeTo,
        this.slottime,
        this.status,
        this.note,
        this.isPaid,
        this.shippingCharge,
        this.couponDiscount,
        this.couponCode,
        this.totalAmount,
        this.totalRewards,
        this.totalKg,
        this.totalItems,
        this.socityId,
        this.addressId,
        this.deliveryAddress,
        this.area,
        this.locationId,
        this.deliveryCharge,
        this.newStoreId,
        this.assignTo,
        this.paymentMethod,
        this.paymentTypes,
        this.firstName,
        this.lastName,
        this.email,
        this.phoneNo,
        this.zipCode,
        this.dateTime,
        this.deliveryboyOrderStatus,
        this.assignedTime,
        this.isStatus,
        this.deliveryLatitude,
        this.deliveryLongitude,
        this.orderReceivedTime,
        this.foodPrepareTime,
        this.orderPickupTime,
        this.orderDeliveredTime,
        this.orderTimeComplete,
        this.city,
        this.distance,
        this.reciverFullAddress,
        this.senderLatitude,
        this.senderLongitude,
        this.receiverLatitude,
        this.receiverLongitude,
        this.parcelPhoto,
        this.isCodOrderVerify,
        this.accountName,
        this.accountNumber,
        this.bookingType,
        this.bookingDate,
        this.bookingTime,
        this.cabId,
        this.parcelHistory,
        this.otp,
        this.senderOtp,
        this.receiverOtp,
        this.message,
        this.materialInfo});

  ParcelDetails.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    orderId = json['order_id'];
    barcode = json['barcode'];
    barcodeLink = json['barcode_link'];
    userId = json['user_id'];
    deliveryBoyId = json['delivery_boy_id'];
    bookingRef = json['booking_ref'];
    senderName = json['sender_name'];
    senderAddress = json['sender_address'];
    senderFulladdress = json['sender_fulladdress'];
    receiverName = json['receiver_name'];
    receiverPhone = json['receiver_phone'];
    receiverAddress = json['receiver_address'];
    reqDeliveryboyIds = json['req_deliveryboy_ids'];
    onDate = json['on_date'];
    deliveryTimeFrom = json['delivery_time_from'];
    deliveryTimeTo = json['delivery_time_to'];
    slottime = json['slottime'];
    status = json['status'];
    note = json['note'];
    isPaid = json['is_paid'];
    shippingCharge = json['shipping_charge'];
    couponDiscount = json['coupon_discount'];
    couponCode = json['coupon_code'];
    totalAmount = json['total_amount'];
    totalRewards = json['total_rewards'];
    totalKg = json['total_kg'];
    totalItems = json['total_items'];
    socityId = json['socity_id'];
    addressId = json['address_id'];
    deliveryAddress = json['delivery_address'];
    area = json['area'];
    locationId = json['location_id'];
    deliveryCharge = json['delivery_charge'];
    newStoreId = json['new_store_id'];
    assignTo = json['assign_to'];
    paymentMethod = json['payment_method'];
    paymentTypes = json['payment_types'];
    firstName = json['First_name'];
    lastName = json['Last_name'];
    email = json['email'];
    phoneNo = json['phone_no'];
    zipCode = json['zip_code'];
    dateTime = json['date_time'];
    deliveryboyOrderStatus = json['deliveryboy_order_status'];
    assignedTime = json['assigned_time'];
    isStatus = json['is_status'];
    deliveryLatitude = json['delivery_latitude'];
    deliveryLongitude = json['delivery_longitude'];
    orderReceivedTime = json['order_received_time'];
    foodPrepareTime = json['food_prepare_time'];
    orderPickupTime = json['order_pickup_time'];
    orderDeliveredTime = json['order_delivered_time'];
    orderTimeComplete = json['order_time_complete'];
    city = json['city'];
    distance = json['distance'];
    reciverFullAddress = json['reciver_full_address'];
    senderLatitude = json['sender_latitude'];
    senderLongitude = json['sender_longitude'];
    receiverLatitude = json['receiver_latitude'];
    receiverLongitude = json['receiver_longitude'];
    parcelPhoto = json['parcel_photo'];
    isCodOrderVerify = json['is_cod_order_verify'];
    accountName = json['account_name'];
    accountNumber = json['account_number'];
    bookingType = json['booking_type'];
    bookingDate = json['booking_date'];
    bookingTime = json['booking_time'];
    cabId = json['cab_id'];
    parcelHistory = json['parcel_history'];
    otp = json['otp'];
    senderOtp = json['sender_otp'];
    receiverOtp = json['receiver_otp'];
    message = json['message'];
    materialInfo = json['material_info'] != null
        ? new MaterialInfo.fromJson(json['material_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['order_id'] = this.orderId;
    data['barcode'] = this.barcode;
    data['barcode_link'] = this.barcodeLink;
    data['user_id'] = this.userId;
    data['delivery_boy_id'] = this.deliveryBoyId;
    data['booking_ref'] = this.bookingRef;
    data['sender_name'] = this.senderName;
    data['sender_address'] = this.senderAddress;
    data['sender_fulladdress'] = this.senderFulladdress;
    data['receiver_name'] = this.receiverName;
    data['receiver_phone'] = this.receiverPhone;
    data['receiver_address'] = this.receiverAddress;
    data['req_deliveryboy_ids'] = this.reqDeliveryboyIds;
    data['on_date'] = this.onDate;
    data['delivery_time_from'] = this.deliveryTimeFrom;
    data['delivery_time_to'] = this.deliveryTimeTo;
    data['slottime'] = this.slottime;
    data['status'] = this.status;
    data['note'] = this.note;
    data['is_paid'] = this.isPaid;
    data['shipping_charge'] = this.shippingCharge;
    data['coupon_discount'] = this.couponDiscount;
    data['coupon_code'] = this.couponCode;
    data['total_amount'] = this.totalAmount;
    data['total_rewards'] = this.totalRewards;
    data['total_kg'] = this.totalKg;
    data['total_items'] = this.totalItems;
    data['socity_id'] = this.socityId;
    data['address_id'] = this.addressId;
    data['delivery_address'] = this.deliveryAddress;
    data['area'] = this.area;
    data['location_id'] = this.locationId;
    data['delivery_charge'] = this.deliveryCharge;
    data['new_store_id'] = this.newStoreId;
    data['assign_to'] = this.assignTo;
    data['payment_method'] = this.paymentMethod;
    data['payment_types'] = this.paymentTypes;
    data['First_name'] = this.firstName;
    data['Last_name'] = this.lastName;
    data['email'] = this.email;
    data['phone_no'] = this.phoneNo;
    data['zip_code'] = this.zipCode;
    data['date_time'] = this.dateTime;
    data['deliveryboy_order_status'] = this.deliveryboyOrderStatus;
    data['assigned_time'] = this.assignedTime;
    data['is_status'] = this.isStatus;
    data['delivery_latitude'] = this.deliveryLatitude;
    data['delivery_longitude'] = this.deliveryLongitude;
    data['order_received_time'] = this.orderReceivedTime;
    data['food_prepare_time'] = this.foodPrepareTime;
    data['order_pickup_time'] = this.orderPickupTime;
    data['order_delivered_time'] = this.orderDeliveredTime;
    data['order_time_complete'] = this.orderTimeComplete;
    data['city'] = this.city;
    data['distance'] = this.distance;
    data['reciver_full_address'] = this.reciverFullAddress;
    data['sender_latitude'] = this.senderLatitude;
    data['sender_longitude'] = this.senderLongitude;
    data['receiver_latitude'] = this.receiverLatitude;
    data['receiver_longitude'] = this.receiverLongitude;
    data['parcel_photo'] = this.parcelPhoto;
    data['is_cod_order_verify'] = this.isCodOrderVerify;
    data['account_name'] = this.accountName;
    data['account_number'] = this.accountNumber;
    data['booking_type'] = this.bookingType;
    data['booking_date'] = this.bookingDate;
    data['booking_time'] = this.bookingTime;
    data['cab_id'] = this.cabId;
    data['parcel_history'] = this.parcelHistory;
    data['otp'] = this.otp;
    data['sender_otp'] = this.senderOtp;
    data['receiver_otp'] = this.receiverOtp;
    data['message'] = this.message;
    if (this.materialInfo != null) {
      data['material_info'] = this.materialInfo!.toJson();
    }
    return data;
  }
}

class MaterialInfo {
  String? saleItemId;
  String? saleId;
  String? productId;
  String? productName;
  String? qty;
  String? unit;
  String? unitValue;
  String? price;
  String? qtyInKg;
  String? rewards;
  String? discountprice;
  String? meterialCategory;
  String? parcelWeight;
  String? cabName;
  String? cabImage;
  String? driverName;
  String? driverMobile;

  MaterialInfo(
      {this.saleItemId,
        this.saleId,
        this.productId,
        this.productName,
        this.qty,
        this.unit,
        this.unitValue,
        this.price,
        this.qtyInKg,
        this.rewards,
        this.discountprice,
        this.meterialCategory,
        this.parcelWeight,
        this.cabName,
        this.cabImage,
        this.driverName,
        this.driverMobile});

  MaterialInfo.fromJson(Map<String, dynamic> json) {
    saleItemId = json['sale_item_id'];
    saleId = json['sale_id'];
    productId = json['product_id'];
    productName = json['product_name'];
    qty = json['qty'];
    unit = json['unit'];
    unitValue = json['unit_value'];
    price = json['price'];
    qtyInKg = json['qty_in_kg'];
    rewards = json['rewards'];
    discountprice = json['discountprice'];
    meterialCategory = json['meterial_category'];
    parcelWeight = json['parcel_weight'];
    cabName = json['cab_name'];
    cabImage = json['cab_image'];
    driverName = json['driver_name'];
    driverMobile = json['driver_mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_item_id'] = this.saleItemId;
    data['sale_id'] = this.saleId;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    data['qty'] = this.qty;
    data['unit'] = this.unit;
    data['unit_value'] = this.unitValue;
    data['price'] = this.price;
    data['qty_in_kg'] = this.qtyInKg;
    data['rewards'] = this.rewards;
    data['discountprice'] = this.discountprice;
    data['meterial_category'] = this.meterialCategory;
    data['parcel_weight'] = this.parcelWeight;
    data['cab_name'] = this.cabName;
    data['cab_image'] = this.cabImage;
    data['driver_name'] = this.driverName;
    data['driver_mobile'] = this.driverMobile;
    return data;
  }
}

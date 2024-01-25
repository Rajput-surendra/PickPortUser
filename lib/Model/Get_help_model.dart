/// status : true
/// message : "Data get Successfully"
/// data : [{"id":"4","message":"Business activities include any activity a business engages in for the primary purpose of making a profit. This is a general term that encompasses all the economic activities carried out by a company during the course of business","image":"casting_maetal_plate12.jpg","video":"2023-06-14_15-25-53.mp4","created_at":"2024-01-05 21:44:47","updated_at":"2024-01-05 21:44:47"},{"id":"9","message":"sadfasd","image":null,"video":null,"created_at":"2023-09-25 12:17:22","updated_at":"2023-09-25 12:17:22"},{"id":"22","message":"this is test message for our activities","image":null,"video":null,"created_at":"2023-10-31 16:46:00","updated_at":"2023-10-31 16:46:00"},{"id":"23","message":"new messages","image":"uploads/media/2023/screen15.png","video":null,"created_at":"2023-10-31 16:47:35","updated_at":"2023-10-31 16:47:35"}]

class GetHelpModel {
  GetHelpModel({
      bool? status, 
      String? message, 
      List<Data>? data,}){
    _status = status;
    _message = message;
    _data = data;
}

  GetHelpModel.fromJson(dynamic json) {
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
GetHelpModel copyWith({  bool? status,
  String? message,
  List<Data>? data,
}) => GetHelpModel(  status: status ?? _status,
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

/// id : "4"
/// message : "Business activities include any activity a business engages in for the primary purpose of making a profit. This is a general term that encompasses all the economic activities carried out by a company during the course of business"
/// image : "casting_maetal_plate12.jpg"
/// video : "2023-06-14_15-25-53.mp4"
/// created_at : "2024-01-05 21:44:47"
/// updated_at : "2024-01-05 21:44:47"

class Data {
  Data({
      String? id, 
      String? message, 
      String? image, 
      String? video, 
      String? createdAt, 
      String? updatedAt,}){
    _id = id;
    _message = message;
    _image = image;
    _video = video;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _message = json['message'];
    _image = json['image'];
    _video = json['video'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String? _id;
  String? _message;
  String? _image;
  String? _video;
  String? _createdAt;
  String? _updatedAt;
Data copyWith({  String? id,
  String? message,
  String? image,
  String? video,
  String? createdAt,
  String? updatedAt,
}) => Data(  id: id ?? _id,
  message: message ?? _message,
  image: image ?? _image,
  video: video ?? _video,
  createdAt: createdAt ?? _createdAt,
  updatedAt: updatedAt ?? _updatedAt,
);
  String? get id => _id;
  String? get message => _message;
  String? get image => _image;
  String? get video => _video;
  String? get createdAt => _createdAt;
  String? get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['message'] = _message;
    map['image'] = _image;
    map['video'] = _video;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}
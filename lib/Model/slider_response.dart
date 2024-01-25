/// status : true
/// message : "Slider Get Successfully"
/// amount : [{"slider_image":"https://developmentalphawizz.com/pickport/uploads/sliders/imgpsh_fullsize_anim_(2).png"}]

class SliderResponse {
  SliderResponse({
      bool? status, 
      String? message, 
      List<Amount>? amount,}){
    _status = status;
    _message = message;
    _amount = amount;
}

  SliderResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['amount'] != null) {
      _amount = [];
      json['amount'].forEach((v) {
        _amount?.add(Amount.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Amount>? _amount;
SliderResponse copyWith({  bool? status,
  String? message,
  List<Amount>? amount,
}) => SliderResponse(  status: status ?? _status,
  message: message ?? _message,
  amount: amount ?? _amount,
);
  bool? get status => _status;
  String? get message => _message;
  List<Amount>? get amount => _amount;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_amount != null) {
      map['amount'] = _amount?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// slider_image : "https://developmentalphawizz.com/pickport/uploads/sliders/imgpsh_fullsize_anim_(2).png"

class Amount {
  Amount({
      String? sliderImage,}){
    _sliderImage = sliderImage;
}

  Amount.fromJson(dynamic json) {
    _sliderImage = json['slider_image'];
  }
  String? _sliderImage;
Amount copyWith({  String? sliderImage,
}) => Amount(  sliderImage: sliderImage ?? _sliderImage,
);
  String? get sliderImage => _sliderImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['slider_image'] = _sliderImage;
    return map;
  }

}
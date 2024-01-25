import 'dart:convert';

AnimalCatResponse animalCatFromJson(String str) => AnimalCatResponse.fromJson(json.decode(str));

String animalCatToJson(AnimalCatResponse data) => json.encode(data.toJson());
class AnimalCatResponse {
  bool? error;
  String? message;
  List<AnimalCatList>? data;

  AnimalCatResponse({this.error, this.message, this.data});

  AnimalCatResponse.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    message = json['message'];
    if (json['data'] != null) {
      data = <AnimalCatList>[];
      json['data'].forEach((v) {
        data!.add(new AnimalCatList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AnimalCatList {
  String? id;
  String? name;
  String? parentId;
  String? slug;
  String? image;

  String? rowOrder;
  String? status;
  String? clicks;

  AnimalCatList(
      {this.id,
        this.name,
        this.parentId,
        this.slug,
        this.image,

        this.rowOrder,
        this.status,
        this.clicks});

  AnimalCatList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    parentId = json['parent_id'];
    slug = json['slug'];
    image = json['image'];

    rowOrder = json['row_order'];
    status = json['status'];
    clicks = json['clicks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['parent_id'] = this.parentId;
    data['slug'] = this.slug;
    data['image'] = this.image;

    data['row_order'] = this.rowOrder;
    data['status'] = this.status;
    data['clicks'] = this.clicks;
    return data;
  }
}

// ignore_for_file: prefer_collection_literals

import 'package:api_handling_by_dio/models/user.dart';

class SingleUserResponse {
  User? data;

  SingleUserResponse({this.data});

  SingleUserResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? User.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

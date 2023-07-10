// ignore_for_file: prefer_collection_literals

import 'package:api_handling_by_dio/models/user.dart';

class MultipleUserResponse {
  int? page;
  int? perPage;
  int? total;
  int? totalPages;
  List<User>? data;

  MultipleUserResponse(
      {this.page, this.perPage, this.total, this.totalPages, this.data});

  MultipleUserResponse.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    perPage = json['per_page'];
    total = json['total'];
    totalPages = json['total_pages'];
    if (json['data'] != null) {
      data = <User>[];
      json['data'].forEach((v) {
        data!.add(User.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = page;
    data['per_page'] = perPage;
    data['total'] = total;
    data['total_pages'] = totalPages;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// ignore_for_file: avoid_print, sized_box_for_whitespace, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/single_user_response.dart';
import '../http_service.dart';

class SingleUserScreen extends StatefulWidget {
  const SingleUserScreen({super.key});

  @override
  State<SingleUserScreen> createState() => _SingleUserScreenState();
}

class _SingleUserScreenState extends State<SingleUserScreen> {
  late HttpService http;
  late SingleUserResponse singleUserResponse;
  late User user;
  final dio = Dio();

  bool isLoading = false;

  Future getUser() async {
    Response response;
    try {
      isLoading = true;
      print('loading');

      // response = await http.getRequest("api/users/2");
      response = await dio.get('https://reqres.in/api/users/2');

      print(response.data.toString());
      print('Stop loading');

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          singleUserResponse = SingleUserResponse.fromJson(response.data);
          user = singleUserResponse.data!;
        });
      } else {
        print('There is some problem status code not 200');
      }
    } on Exception catch (e) {
      isLoading = false;
      print(e.toString());
    }
  }

  @override
  void initState() {
    http = HttpService();
    getUser();
    // getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text('Get Single User'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : user != null
              ? Container(
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(user.avatar.toString()),
                      const SizedBox(height: 16),
                      Text('Hello ${user.firstName} ${user.lastName}'),
                    ],
                  ),
                )
              : const Center(
                  child: Text('No user object'),
                ),
    );
  }
}

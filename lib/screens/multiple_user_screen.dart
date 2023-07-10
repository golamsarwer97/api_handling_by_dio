// ignore_for_file: avoid_print, sized_box_for_whitespace, unnecessary_null_comparison

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../models/user.dart';
import '../models/multiple_user_response.dart';
import '../http_service.dart';

class MultipleUserScreen extends StatefulWidget {
  const MultipleUserScreen({super.key});

  @override
  State<MultipleUserScreen> createState() => _MultipleUserScreenState();
}

class _MultipleUserScreenState extends State<MultipleUserScreen> {
  late HttpService http;
  late MultipleUserResponse multipleUserResponse;
  List<User> users = [];

  final dio = Dio();

  bool isLoading = false;

  Future getMultipleUser() async {
    Response response;
    try {
      isLoading = true;
      print('loading');

      // response = await http.getRequest("api/users/2");
      response = await dio.get('https://reqres.in/api/users?page=2');

      print(response.data.toString());
      print('Stop loading');

      isLoading = false;

      if (response.statusCode == 200) {
        setState(() {
          multipleUserResponse = MultipleUserResponse.fromJson(response.data);
          users = multipleUserResponse.data!;
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
    getMultipleUser();
    // getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink.shade200,
        title: const Text('Get multiple User'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : users.length != null
              ? ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];

                    return ListTile(
                      title: Text(user.firstName.toString()),
                      subtitle: Text(user.email.toString()),
                      leading: Image.network(user.avatar.toString()),
                    );
                  },
                )
              : const Center(
                  child: Text('No user object'),
                ),
    );
  }
}

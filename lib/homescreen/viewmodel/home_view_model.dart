import 'dart:convert';
import 'package:crud_api_show/homescreen/model/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as developer;

class HomeViewModel with ChangeNotifier {
  final url = Uri.parse(
      "https://crudcrud.com/api/711772e261334d8ca929fea5acde7ef1/gogul");
  List<UserModel> users = [];
  String name = "";
  String mobile = "";
  String email = "";
  String gender = "";
  String itemId = "";
  bool isLoading = false;

  Future<void> fetchUsers() async {
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> apiResponse = json.decode(response.body);

        users = apiResponse
            .map((userData) => UserModel(
                  id: userData['_id'],
                  name: userData['name'],
                  email: userData['email'],
                  mobile: userData['mobile'],
                  gender: userData['gender'],
                ))
            .toList();
        developer.log('apiResponse: $apiResponse');
        notifyListeners();
      } else {
        throw Exception('Failed to load data from the API');
      }
    } catch (error) {
      developer.log('Error: $error');
    }
  }

  Future<void> addUser() async {
    isLoading = true;
    notifyListeners();
    final Map<String, dynamic> data = {
      "name": name,
      "email": email,
      "mobile": mobile,
      "gender": gender
    };
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      developer.log('POST request successful: ${response.body}');
    } else {
      developer.log(
          'Failed to make POST request: ${response.body}, Status Cdoe : ${response.statusCode}');
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> deleteItemById() async {
    final apiUrl = Uri.parse(
        'https://crudcrud.com/api/711772e261334d8ca929fea5acde7ef1/gogul/$itemId');

    final response = await http.delete(
      apiUrl,
    );

    if (response.statusCode == 200) {
      developer.log('DELETE request successful. Item with ID $itemId deleted.');
    } else {
      developer.log('Failed to delete item with ID $itemId');
      developer.log('Response status code: ${response.statusCode}');
      developer.log('Response body: ${response.body}');
    }
  }
}

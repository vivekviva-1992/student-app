import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:student_app/api_services/api_endpoint.dart';

class ApiService {
  Future<Map<String,dynamic>>login(String email, String password) async {
    final url = Uri.parse("https://reqres.in/api/login");
    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
      );
      if (response.statusCode == 200) {
        print("Login Success");
        return {
          'success':true,
          'token':jsonDecode(response.body)['token'],

        };

      }
      else {
        final error=jsonDecode(response.body)['error'];
        return {
          'success':false,
          'message':error??'Unknown error occured',
        };
      }
    }
    catch (e) {
      print("Error:$e");
      return {
        'success':false,
        'message':'Network error:$e',
      };
    }
  }
}
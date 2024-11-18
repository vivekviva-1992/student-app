

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart'as http;
import 'package:student_app/api_services/api_service.dart';
import 'package:student_app/api_services/api_endpoint.dart';

class AuthProvider extends ChangeNotifier{
  String _email="";
  String _password="";
  bool _isLoading=false;
//getters
  String get email=>_email;
  String get password=>_password;
  bool get isloading=>_isLoading;
//setters
  set email(String value){
    _email=value;
  }
  set password(String value){
    _password=value;
  }

  void onChangeEmailText(String value){
    _email=value;
    notifyListeners();
  }

  void onChangePasswordText(String value){
    _password=value;
    notifyListeners();
  }
void setLoading(bool value){
    _isLoading=value;
    notifyListeners();
}

Future<bool> loginUser()async{
    setLoading(true);
    final url=Uri.parse("https://reqres.in/api/login");
    try{
      final response=await http.post(
          url,
        headers: {"Content-Type":"application/json"},
        body: jsonEncode({"email":_email,"password":_password}),
      );
      setLoading(false);
      if(response.statusCode==200){

        return true;
      }
      else
        {
          return false;
        }

    }
    catch(error){
      setLoading(false);
      return false;

    }
}
}
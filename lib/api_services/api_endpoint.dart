
import 'package:flutter/material.dart';
import 'dart:convert';


class AppResponse{
  final bool success;
  final String message;

   AppResponse({
    required this.success,required this.message
});
   factory AppResponse.fromJson(Map<String,dynamic>json){
     return AppResponse(success: json["success"], message: json["message"]
     );
   }
}
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';


import 'package:http/http.dart' as http;
class NotificationApi {

  
 Future<http.Response> sendNotification(String senderId, String recieverId, String type, String description) async {
    final response = await http.post(
      Uri.parse(ApiConstant.notification),
      body: jsonEncode({
  "receiver_id": recieverId,
  "sender_id": senderId,
  "type": type,
  "description": description

}
),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    return response;
  }

}
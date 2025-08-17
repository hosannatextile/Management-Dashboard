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

Future<http.Response> fetchReminders(String ticketId) async {
  final url = Uri.parse('${ApiConstant.baseUrl}remind/reminders/$ticketId'); // Replace with actual API base URL

  try {
    final response = await http.get(
      url,
      headers: {'Content-Type': 'application/json',
      "Authorization": "Bearer ${ApiConstant.loginData!.accessToken}",
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      print(response.body);
      print('Reminders for ${data['ticket_id']}:');
      for (var reminder in data['reminders']) {
        print('Ticket: ${reminder['ticket']['description']} | Status: ${reminder['ticket']['status']}');
        print('From: ${reminder['user_id']['name']} | Count: ${reminder['count']}');
        print('---');
      }
      return response;
    } else {
      final errorData = jsonDecode(response.body);

      print('Error: ${errorData['error']}');
      return response;
    }
  } catch (e) {
    print('Exception occurred: $e');
    return http.Response('Error', 500);
  }
}
}
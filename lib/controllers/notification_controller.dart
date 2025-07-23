import 'dart:convert';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:help_desk_hosanna/Modal/notification.dart';

import 'package:http/http.dart' as http;


class NotificationController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool notificationsLoading = false.obs;
  Future<void> fetchNotifications(String receiverId, String status) async {
  // Base URL for the API endpoint
notificationsLoading = true.obs;

  // Check for valid status
  if (status != 'read' && status != 'unread') {
    print('Invalid status. Use "read" or "unread".');
    notificationsLoading = false.obs;
    return;
  }

  // Construct the full URL with query parameters
  final Uri url = Uri.parse('${ApiConstant.notification}?receiver_id=$receiverId&status=$status');

  try {
    // Send the GET request to the server
    final response = await http.get(url);

    // Check the status code
    if (response.statusCode == 200) {
      notificationsLoading = false.obs;
      // Parse the response body as JSON
      var data = jsonDecode(response.body);
      notifications.value= data['notifications'].map<NotificationModel>((json) => NotificationModel.fromJson(json)).toList();
      // Print or use the fetched notifications
      print('Notifications: ${data['notifications']}');
    
    } else if (response.statusCode == 400) {
      notificationsLoading = false.obs;
      var errorData = jsonDecode(response.body);
      print('Error: ${errorData['error']}');
     
    } else {
      notificationsLoading = false.obs;
      print('Failed to fetch notifications. Status Code: ${response.statusCode}');
    }
  } catch (error) {
    notificationsLoading = false.obs;
    print('Error fetching notifications: $error');
  }
}
}
import 'dart:convert';
import 'dart:io';

import 'package:help_desk_hosanna/Api/api_constant.dart';


import 'package:http/http.dart' as http;

class ApiHelper{

 Future<http.Response> login(String email, String password) async {
    final response = await http.post(
      Uri.parse(ApiConstant.loginUrl),
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    return response;
  }

 getTicketByUserId(String userId) async {
    final response = await http.get(
      Uri.parse("${ApiConstant.getTicketByUserId}$userId"),
      
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    return response;
  }
  getTicketByUserIdnstatus(String userId,String status) async {
    final response = await http.get(
      Uri.parse("${ApiConstant.getTicketByUserIdnstatus}user_id=$userId&status=$status"),
      
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    return response;
  }

 getProofByUserId(String userId) async {
    final response = await http.get(
      Uri.parse("${ApiConstant.createProof}/$userId"),
      
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    return response;
  }


 Future<http.Response> getUsersByRole(String role) async {
    final response = await http.get(
      Uri.parse("${ApiConstant.getAllUsers}?role=$role"),
      
      headers: {
        'Content-Type': 'application/json',
        "authorization": "Bearer ${ApiConstant.loginData!.accessToken!}",
      },
    );

    print(response.body);

    return response;
  }

Future<http.Response> uploadProof(
  File voiceNote,
  File video,
  File image,
  String? userId,
  String? ticketId,
  String? recipientId,
  
  String? recipientName,
 
 
) async {
  final Map<String, String> defaultHeaders = {
   // 'Authorization': 'Bearer ${ApiConstant.loginData!.accessToken!}',
  };

  // Function to handle the API request
  Future<http.Response> sendRequest() async {
    // Create the multipart request
    var uri = Uri.parse(ApiConstant.createProof);
    var request = http.MultipartRequest('POST', uri);

    // Add the form fields (non-file data)
    request.fields['user_id'] = userId!;
    request.fields['recipient_id'] = recipientId!;
    request.fields['recipient_name'] = recipientName!;
    request.fields['ticket'] = ticketId!;
    
    
 
    
    request.headers.addAll(defaultHeaders);

    // Add files to the request (multipart form data)
    request.files.add(await http.MultipartFile.fromPath('voice_note', voiceNote.path));
    request.files.add(await http.MultipartFile.fromPath('video', video.path));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    // Send the request
    var response = await request.send();
    print(response);
    // Read the response
    return await http.Response.fromStream(response);
  }

  // Send initial request
  var response = await sendRequest();
print(response);
  // //If unauthorized, try refreshing the token and retry the request
  // if (response.statusCode == 401) {
  //   var refreshResponse = await http.post(
  //     Uri.parse(ApiConstant.refreshDeviceToken),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'refresh_token': ApiConstant.loginData?.refreshToken,
  //     }),
  //   );

  //   if (refreshResponse.statusCode == 200) {
  //     // Update token
  //     var data = jsonDecode(refreshResponse.body);
  //     ApiConstant.loginData?.accessToken = data['access_token'];
  //     ApiConstant.loginData?.refreshToken = data['refresh_token'];

  //     // Retry the original request with new token
  //     response = await sendRequest();
  //     return response;
  //   } else {
     
  //   }
  //}

  // Return original or last response
  return response;
}


Future<http.Response> createWorkInstruction(
  File voiceNote,
  File video,
  File image,
  String? userId,
 
  String? recipientId,
  

  String ? reviewTime,
  String ? type,
  String? remarks,
  String? orderType,
  List<String> mediaSelect
 
) async {
  final Map<String, String> defaultHeaders = {
    'Authorization': 'Bearer ${ApiConstant.loginData!.accessToken!}',
  };

  // Function to handle the API request
  Future<http.Response> sendRequest() async {
    // Create the multipart request
    var uri = Uri.parse(ApiConstant.createWorkInstructions);
    var request = http.MultipartRequest('POST', uri);

    // Add the form fields (non-file data)
    request.fields['user_id'] = userId!;
    request.fields['recipient_ids'] = recipientId!;
    request.fields['review_time'] = reviewTime!;
    request.fields['type'] = type!;
    request.fields['remarks'] = remarks!;
    request.fields['order_type'] = orderType!;
    request.fields['media_select'] = mediaSelect.join(',');
   
    
    
 
    
    request.headers.addAll(defaultHeaders);

    // Add files to the request (multipart form data)
    request.files.add(await http.MultipartFile.fromPath('audio', voiceNote.path));
    request.files.add(await http.MultipartFile.fromPath('video', video.path));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));

    // Send the request
    var response = await request.send();
    print(response);
    // Read the response
    return await http.Response.fromStream(response);
  }

  // Send initial request
  var response = await sendRequest();
print(response.statusCode);
  // //If unauthorized, try refreshing the token and retry the request
  // if (response.statusCode == 401) {
  //   var refreshResponse = await http.post(
  //     Uri.parse(ApiConstant.refreshDeviceToken),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'refresh_token': ApiConstant.loginData?.refreshToken,
  //     }),
  //   );

  //   if (refreshResponse.statusCode == 200) {
  //     // Update token
  //     var data = jsonDecode(refreshResponse.body);
  //     ApiConstant.loginData?.accessToken = data['access_token'];
  //     ApiConstant.loginData?.refreshToken = data['refresh_token'];

  //     // Retry the original request with new token
  //     response = await sendRequest();
  //     return response;
  //   } else {
     
  //   }
  //}

  // Return original or last response
  return response;
}


 getWorkInstructionByUserId(String userId) async {
    final response = await http.get(
      Uri.parse("${ApiConstant.createWorkInstructions}/$userId"),
      
      headers: {
        'Content-Type': 'application/json',
      },
    );

    print(response.body);

    return response;
  }

}
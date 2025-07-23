import 'dart:convert';
import 'dart:io';

import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:http/http.dart' as http;
class TicketApi{
 List<String> _validRights = ['View', 'Forward', 'Power'];



  
 Future<http.Response> getTicketByRecipientId() async {
    final response = await http.get(
      Uri.parse("${ApiConstant.getRecipientTicket}/${ApiConstant.loginData!.user!.id}"),
      
      headers: {
        'Content-Type': 'application/json',
      "authorization": "Bearer ${ApiConstant.loginData!.accessToken!}",
      },
     
    );
    print(response.statusCode);
    print(response.body);

    return response;
  }
  
 Future<http.Response> getTicketByRecipientIdnStatus(String type,String status) async {
    final response = await http.post(
      Uri.parse("${ApiConstant.getRecipientTicketByType}/${ApiConstant.loginData!.user!.id}?type=$type&status=$status"),
      
      headers: {
        'Content-Type': 'application/json',
      "authorization": "Bearer ${ApiConstant.loginData!.accessToken!}",
      },
    );
    print(response.statusCode);
    print(response.body);

    return response;
  }
  //Response on tickets by manager
Future<http.Response> ticketResponse(
  String? voiceNote,
  String? video,
  String? image,
  String? inchargeId,
  String? managerId,
  String? ticketType,
  String? ticketId,
  String? description,
  String? priority,
  String? deadline,
) async {
  final Map<String, String> defaultHeaders = {
   // 'Authorization': 'Bearer ${ApiConstant.loginData!.accessToken!}',
  };

  // Function to handle the API request
  Future<http.Response> sendRequest() async {
    // Create the multipart request
    var uri = Uri.parse(ApiConstant.responseRoute);
    var request = http.MultipartRequest('POST', uri);

    // Add the form fields (non-file data)
    request.fields['user_id'] = inchargeId!;
    request.fields['response_person_id'] =managerId! ;
    request.fields['ticket_id'] =ticketId! ;
    request.fields['type'] = ticketType!;
    request.fields['description'] = description!;
    request.fields['priority'] = priority!.toString();
    request.fields['deadline'] = deadline!;
    request.fields['rights']="View";

    
    request.headers.addAll(defaultHeaders);

    // Add files to the request (multipart form data)
   voiceNote!=null? request.files.add(await http.MultipartFile.fromPath('voice_note',voiceNote)):null;
  video!=null?  request.files.add(await http.MultipartFile.fromPath('video', video)):null;
   image!=null? request.files.add(await http.MultipartFile.fromPath('image', image)):null;

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

Future<void> fetchResponses(String responsePersonId, String ticketId, {String? userId}) async {
  // Constructing the base URL
 
  // Prepare the query parameters
  final Map<String, String> queryParams = {
    'response_person_id': responsePersonId,
    'ticket_id': ticketId,
    'user_id': userId ?? '',
  };

  // // If user_id is provided, add it to queryParams
  // if (userId != null) {
  //   queryParams['user_id'] = userId;
  // }

  // Construct the URL with query parameters
  Uri uri = Uri.parse(ApiConstant.responseRoute).replace(queryParameters: queryParams);

  try {
    // Making the GET request
    final response = await http.get(uri);

    // Check for a successful response
    if (response.statusCode == 200) {
      // Parse the response body
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['success']) {
        // Handle the successful response
        print('Data: ${data['data']}');
      } else {
        // Handle the failure response
        print('Error: ${data['message']}');
      }
    } else {
      // Handle the error response
      print('Error: ${response.statusCode}');
    }
  } catch (error) {
    // Handle any exceptions
    print('An error occurred: $error');
  }
}

// Get Categorized
Future<http.Response> getCategorized() async {
  final response = await http.get(Uri.parse(ApiConstant.getCategorized));
  print(response.body);
  return response;  
}

Future<Map<String, dynamic>> getRecipientTickets({
  required String recipientId,
  String? status,
  String? type,
}) async {
  final queryParameters = <String, String>{};

  if (status != null && status.isNotEmpty) {
    queryParameters['status'] = status;
  }

  if (type != null && type.isNotEmpty) {
    queryParameters['type'] = type;
  }

   Uri url = Uri.parse("${ApiConstant.baseUrl}ticket/recipient/$recipientId")
      .replace(queryParameters: queryParameters);

  try {
    final response = await http.get(
      url,
      // Optional: Add headers if needed
       headers: {
    'Content-Type': 'application/x-www-form-urlencoded',
       }
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else if (response.statusCode == 404) {
      return {'message': 'No tickets found.'};
    } else {
      throw Exception('Failed to fetch tickets: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}


}
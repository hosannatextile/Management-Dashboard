



import 'package:help_desk_hosanna/Modal/login_data.dart';

class ApiConstant {
//  static String baseUrl="http://192.168.18.19:3000/api/";
 static String baseUrl="https://desk-production.up.railway.app/api/";

 static String loginUrl="${baseUrl}login/emaillogin";
 static String getCategorized="${baseUrl}ticket/tickets/categorized";
 static String createProof="${baseUrl}proof";
 static String getTicketByUserId="${baseUrl}ticket/summary/";
 static String getTicketByUserIdnstatus="${baseUrl}ticket/filter?";
 static String createWorkInstructions="${baseUrl}workinstruction";
 static String getAllUsers="${baseUrl}users";
 static String getRecipientTicket="${baseUrl}ticket/recipient/totaltickets";
 static String getRecipientTicketByType="${baseUrl}ticket/recipient";
 static String getWorkInstructionByUserId="${baseUrl}workinstruction/";
 static String responseRoute="${baseUrl}ticketResponse/response";
 static String assignRoute="${baseUrl}assign/assign";
 static String uploads="http://192.168.18.19:3000";
  static String notification="${baseUrl}notification";


  static LoginData? loginData;
}
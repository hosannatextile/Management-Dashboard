import 'dart:convert';

import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:help_desk_hosanna/Api/api.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:help_desk_hosanna/Api/ticket_api.dart';
import 'package:help_desk_hosanna/Modal/tickets_complete_data.dart';
import 'package:http/http.dart' as http;
class TicketController extends GetxController{
  RxBool loadingComplaints = false.obs;
  RxBool loadingProblems = false.obs;
  RxBool loadingPermissions = false.obs;
  RxBool loadingRequirements = false.obs;
    RxBool loadingAllTickets = false.obs;
   Rx<TicketsCompleteData> complaintsList = TicketsCompleteData().obs;
  Rx<TicketsCompleteData> problemList = TicketsCompleteData().obs;
  Rx<TicketsCompleteData> permissionList = TicketsCompleteData().obs;
  Rx<TicketsCompleteData> requirementList = TicketsCompleteData().obs;
  Rx<TicketsCompleteData> trainingList = TicketsCompleteData().obs;
  Rx<TicketsCompleteData> reimbursementList =TicketsCompleteData().obs;
   Rx<TicketsCompleteData> assignedTicketList=TicketsCompleteData().obs;
  Rx<TicketsCompleteData> completedTicketList=TicketsCompleteData().obs;
  Rx<TicketsCompleteData> rejectedTicketList=TicketsCompleteData().obs;
  Rx<TicketsCompleteData> respondedTicketList=TicketsCompleteData().obs;
   Rx<TicketsCompleteData> allTicketsList =TicketsCompleteData().obs;
  getAllTickets(){
    getAllComplaints();
    getAllPermissions();
    getAllProblems();
    getAllRequirements();
    getAllTraining();
    getAllReimbursement();
    getCompletedTicket();
    getRejectedTicket();
    getRespondedTickets();
    update();
  }
  getRespondedTickets() async {
    loadingAllTickets.value = true;
    var response = await TicketApi().getTicketByRecipientIdnStatus(
      "",""
    );
    if (response.statusCode == 200) {
      loadingAllTickets.value = false;
      var data = TicketsCompleteData.fromJson(jsonDecode(response.body));
      // Reverse the ticketDetails list to show newest first
      if (data.ticketDetails != null) {
        data.ticketDetails = data.ticketDetails!.reversed.where((x) => x.ticket!.status != "Active" && x.ticket!.status != "Pending"  ).toList();
      }
      allTicketsList.value = data;
      // complaintsList.value = TicketsCompleteData.fromJson(jsonDecode(response.body));
      update();
      print(allTicketsList().count);
    }else{
      loadingAllTickets .value= false;
    }
  }
// RxList<Ticket> complaintsTicketList=<Ticket>[].obs;
//   RxList<Ticket> requirementsTicketList=<Ticket>[].obs;
//   RxList<Ticket> permissionTicketList=<Ticket>[].obs;
//   RxList<Ticket> problemTicketList=<Ticket>[].obs;
// Future<void> getCategorized() async {
//   final response = await http.get(Uri.parse(ApiConstant.getCategorized));
//   print(response.body);
//   if(response.statusCode == 200){
//     var jsonData = jsonDecode(response.body);
//     print(jsonData['data']['active']);
//      var filteredList = (jsonData['data']['active'] as List<dynamic>)
//       .where((item) => item['type'] == 'Requirement')
//       .toList();

//   requirementsTicketList.assignAll(
//       filteredList.map((item) => Ticket.fromJson(item)).toList()
//   );
//    // requirementsTicketList = jsonData['data']['active'].where((item) => item['type'] == 'Requirement').toList();
//    // complaintsTicketList = jsonData['data']['Active'].where((item) => item['type'] == 'Complaint').toList();
//     //permissionTicketList = jsonData['Active'].where((item) => item['type'] == 'Permission').toList();
//     //problemTicketList = jsonData['Active'].where((item) => item['type'] == 'Problem').toList();

//   }
 
// }
getAllComplaints() async {
  loadingComplaints.value = true;
    var response = await TicketApi().getTicketByRecipientIdnStatus(
      "Complaint",""
    );
    if (response.statusCode == 200) {
      complaintsList = TicketsCompleteData.fromJson(jsonDecode(response.body)).obs;
      complaintsList.value.ticketDetails=complaintsList.value.ticketDetails!.reversed.where((x) => x.ticket!.status != "completed" && x.ticket!.status != "Reject" && x.ticket!.status != "Assign").toList().obs;
      loadingComplaints.value = false;
      print(complaintsList().count);
    }
  }
  getAllPermissions() async {
    loadingPermissions.value = true;
    var response = await TicketApi().getTicketByRecipientIdnStatus(
      "Permission",""
    );
    if (response.statusCode == 200) {
      permissionList = TicketsCompleteData.fromJson(jsonDecode(response.body)).obs;
      permissionList.value.ticketDetails=permissionList.value.ticketDetails!.reversed.where((x) => x.ticket!.status != "completed" && x.ticket!.status != "Reject" && x.ticket!.status != "Assign").toList().obs;
      loadingPermissions.value = false;
      print(permissionList().count);
    }
  }
  getAllProblems() async {
    loadingProblems.value = true;
    var response = await TicketApi().getTicketByRecipientIdnStatus(
      "Problem",""
    );
    if (response.statusCode == 200) {
      problemList = TicketsCompleteData.fromJson(jsonDecode(response.body)).obs;
      problemList.value.ticketDetails=problemList.value.ticketDetails!.reversed.where((x) => x.ticket!.status != "completed" && x.ticket!.status != "Reject" && x.ticket!.status != "Assign").toList().obs;
      loadingProblems.value = false;
      print(problemList().count);
    }
  }
  getAllRequirements() async {
    loadingRequirements.value = true;
    var response = await TicketApi().getTicketByRecipientIdnStatus(
      "Requirement",""
    );
    if (response.statusCode == 200) {
      requirementList = TicketsCompleteData.fromJson(jsonDecode(response.body)).obs;
      requirementList.value.ticketDetails=requirementList.value.ticketDetails!.reversed.where((x) => x.ticket!.status != "completed" && x.ticket!.status != "Reject" && x.ticket!.status != "Assign").toList().obs;
      loadingRequirements.value = false;
      print(requirementList().count);
    }
  }
  getAllTraining() async {
    var response = await TicketApi().getTicketByRecipientIdnStatus(
      "Training",""
    );
    if (response.statusCode == 200) {
      trainingList = TicketsCompleteData.fromJson(jsonDecode(response.body)).obs;
      trainingList.value.ticketDetails=trainingList.value.ticketDetails!.reversed.where((x) => x.ticket!.status != "completed" && x.ticket!.status != "Reject" && x.ticket!.status != "Assign").toList().obs;
      print(trainingList().count);
    }
  }
  getAllReimbursement() async {
    var response = await TicketApi().getTicketByRecipientIdnStatus(
      "Reimbursement",""
    );
    if (response.statusCode == 200) {
      reimbursementList = TicketsCompleteData.fromJson(jsonDecode(response.body)).obs;
      reimbursementList.value.ticketDetails=reimbursementList.value.ticketDetails!.reversed.where((x) => x.ticket!.status != "completed" && x.ticket!.status != "Reject" && x.ticket!.status != "Assign").toList().obs;
      print(reimbursementList().count);
    }
  }
  
  getCompletedTicket() async {
    var res = await TicketApi().getTicketByRecipientIdnStatus("", "completed");
    if (res.statusCode == 200) {
      print(res.body);

     completedTicketList = TicketsCompleteData.fromJson(jsonDecode(res.body)).obs;
      completedTicketList.value.ticketDetails=completedTicketList.value.ticketDetails!.reversed.toList().obs;
      print(completedTicketList().count);
    } else {
      print("Failed to load tickets");
    }
  }

  
  
  getRejectedTicket() async {
    var res = await TicketApi().getTicketByRecipientIdnStatus("", "Reject");
    if (res.statusCode == 200) {
      print(res.body);

   
     rejectedTicketList = TicketsCompleteData.fromJson(jsonDecode(res.body)).obs;
      rejectedTicketList.value.ticketDetails=rejectedTicketList.value.ticketDetails!.reversed.toList().obs;
      print(rejectedTicketList().count);
    } else {
      print("Failed to load tickets");
    }
  }
  
  getRespondedTicket() async {
    var res = await TicketApi().getTicketByRecipientIdnStatus("", "Responded");
    if (res.statusCode == 200) {
      print(res.body);

   
     respondedTicketList = TicketsCompleteData.fromJson(jsonDecode(res.body)).obs;
      respondedTicketList.value.ticketDetails=respondedTicketList.value.ticketDetails!.reversed.toList().obs;
      print(respondedTicketList().count);
    } else {
      print("Failed to load tickets");
    }
  }

  
}
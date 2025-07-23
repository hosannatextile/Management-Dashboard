import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:help_desk_hosanna/active_screen/components/admin_activity_screen_card.dart';
import 'package:help_desk_hosanna/active_screen/components/complaint_screen_card.dart';
import 'package:help_desk_hosanna/active_screen/components/permission_screen_card.dart';
import 'package:help_desk_hosanna/active_screen/components/problems_screen_card.dart';
import 'package:help_desk_hosanna/active_screen/components/requirements_screen_card.dart';
import 'package:help_desk_hosanna/active_screen/components/ticket_data_card.dart';
import 'package:help_desk_hosanna/controllers/ticket_controller.dart';

class ActiveScreen extends StatefulWidget {
  const ActiveScreen({super.key});

  @override
  State<ActiveScreen> createState() => _ActiveScreenState();
}

class _ActiveScreenState extends State<ActiveScreen> {
  TicketController ticketController = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ticketController.getAllTickets();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Row(
        children: [
          Obx(()=>
        ticketController.loadingComplaints.value ?Expanded(child: Center(child: CircularProgressIndicator(),)): ComplaintScreenCard(background: Colors.deepOrange,title: "Complaints (2)",),),
      Obx(()=> ticketController.loadingRequirements.value ?Expanded(child: Center(child: CircularProgressIndicator(),)): RequirementScreenCard(background: Colors.blue,title: "Requirements (2)",),),
     Obx(()=> ticketController.loadingPermissions.value ?Expanded(child: Center(child: CircularProgressIndicator(),)):  PermissionScreenCard(background: Colors.green,title: "Permissions (2)",),),
      Obx(()=>ticketController.loadingProblems.value ?Expanded(child: Center(child: CircularProgressIndicator(),)):  ProblemScreenCard(background: Colors.red,title: "Problems (2)",),),
         AdminActivityScreenCard(background: Colors.purple,title: "Admin Activity",),
      ]),
    );
  }
}

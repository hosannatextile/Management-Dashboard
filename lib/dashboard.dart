import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:help_desk_hosanna/Api/api.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:help_desk_hosanna/Api/ticket_api.dart';
import 'package:help_desk_hosanna/active_screen/active_screen.dart';
import 'package:help_desk_hosanna/active_screen/components/admin_activity_screen_card.dart';
import 'package:help_desk_hosanna/completed_screen/completed_screen.dart';
import 'package:help_desk_hosanna/controllers/ticket_controller.dart';
import 'package:help_desk_hosanna/logs_screen/logs_screen.dart';
import 'package:help_desk_hosanna/pending_screen/pending_screen.dart';
import 'package:help_desk_hosanna/reimbursement_screen/reimbursement_screen.dart';
import 'package:help_desk_hosanna/rejection_screen/rejection_screen.dart';
import 'package:help_desk_hosanna/reponded_screen/responded_screen.dart';
import 'package:help_desk_hosanna/training_screens/training_screen.dart';
import 'package:intl/intl.dart';
class HelpDeskScreen extends StatefulWidget {

  @override
  State<HelpDeskScreen> createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  TicketController ticketController = Get.put(TicketController());
   late String _currentTime; // To store current time
  late Timer _timer; // To control the timer
 late String formatedDate;
 Timer? _ticketUpdater;
 List<dynamic> recepientList = [];

  getUsersByRole() async {
    final res = await ApiHelper().getUsersByRole('Management');
    if (res.statusCode == 200) {
      recepientList = jsonDecode(res.body);

      setState(() {}); // rebuild with TabBar in place
    }
   
  }

  final List<String> tabs = [
    'Active',
    'Completed',
    'Pending',
    'Rejection',
    'Training',
    'Reimbursements',
    'Logs',
  ];
    @override
  void initState() {
    super.initState();
     getUsersByRole();
    _currentTime = _getFormattedTime(); // Initialize with current time
    formatedDate=_getFormattedDate();
    // Start the timer to update the time every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = _getFormattedTime(); // Update time every second
      });
    });
   // TicketApi().getCategorized();
    ticketController.getAllTickets();
    // Call API every 10 seconds
  _ticketUpdater = Timer.periodic(Duration(seconds: 20), (timer) {
    ticketController.getAllTickets();
     getUsersByRole();
  });
  }
 @override
  void dispose() {
    _timer.cancel(); // Cancel the timer when the widget is disposed
    _ticketUpdater?.cancel();
    super.dispose();
  }

  // Function to get the current time formatted
  String _getFormattedTime() {
    final now = DateTime.now();
    return DateFormat('hh:mm:ss a').format(now);  // 12-hour format with AM/PM
    // Use 'HH:mm:ss' for 24-hour format
  }
  // Function to get the current date formatted
String _getFormattedDate() {
  final now = DateTime.now();
   return DateFormat('EEEE, yyyy-MM-dd').format(now);// Format: 'Year-Month-Day'
  // Example output: '2025-06-17'
}


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 8,
      child: Scaffold(
         backgroundColor: Colors.grey.shade900,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade900,
          foregroundColor: Colors.white,
          title: Text('Help Desk (ALERT)'),
          centerTitle: true,
         actions: [
          Container(
            margin: EdgeInsets.only(right: 10),
            color: Colors.blue,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: 
                 recepientList.map((dynamic value) {
                 // recipientName = value["_id"];
            return value["_id"] != ApiConstant.loginData!.user!.id ? Padding(
              padding:  EdgeInsets.only(right: 20.w),
              child: badges.Badge(
                    showBadge: false,
                    badgeContent: Text('3'),
                    child: Text("${value["fullName"]}"),
                  ),
            ):SizedBox();
          }).toList(),
               
              
            ),
          )
         ],
         
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                Text("Welcome Mr. ${ApiConstant.loginData!.user!.fullName}",style: TextStyle(fontSize: 25,color: Colors.white),),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                            "Time: ${_currentTime}",  // Display the real-time clock
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                    Text(
                             "Day: $formatedDate",  // Display the real-time clock
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                  ],
                ),
              ]),
               Container(
                color: Colors.grey.shade800,
                child:  TabBar(
                 
                  tabAlignment: TabAlignment.center,
                  isScrollable: true,
                  labelColor: Colors.yellow,
                  unselectedLabelColor: Colors.white,
                  indicatorColor: Colors.yellow,
                  labelStyle: TextStyle(fontSize: 18),
                  tabs: [
                     badges.Badge(
                      showBadge: false,
                      badgeContent: Text('3'),
                      child: Tab(text: "Active")),
                    Obx(()=>
                     badges.Badge(
                      showBadge: ticketController.allTicketsList.value.ticketDetails?.length!=0? true:false,
                      badgeContent: Text('${ticketController.allTicketsList.value.ticketDetails?.length??0}'),
                      child: Tab(text: "Responded")),
                    ),
                    Obx(()=>
                     badges.Badge(
                      showBadge: ticketController.completedTicketList.value.ticketDetails?.length!=0? true:false,
                      badgeContent: Text('${ticketController.completedTicketList.value.ticketDetails?.length??0}'),
                      child: Tab(text: "Completed")),
                    ),
                    //  badges.Badge(
                    //   showBadge: false,
                    //   badgeContent: Text('3'),
                    //   child: Tab(text: "Pending")),
                      Obx(()=>
                     badges.Badge(
                      showBadge: ticketController.rejectedTicketList.value.ticketDetails?.length!=0? true:false,
                      badgeContent: Text('${ticketController.rejectedTicketList.value.ticketDetails?.length??0}'),
                      child: Tab(text: "Rejection")),
                      ),
                      Obx(()=>
                     badges.Badge(
                      showBadge:ticketController.trainingList.value.ticketDetails?.length!=0? true:false,
                      badgeContent: Text('${ticketController.trainingList.value.ticketDetails?.length??0}'),
                      child: Tab(text: "Training")),
                      ),
                      Obx(()=>
                     badges.Badge(
                      showBadge: ticketController.reimbursementList.value.ticketDetails?.length!=0? true:false,
                      badgeContent: Text('${ticketController.reimbursementList.value.ticketDetails?.length??0}'),
                      child: Tab(text: "Reimbursements")),
                      ),
                     badges.Badge(
                      showBadge: false,
                      badgeContent: Text('3'),
                      child: Tab(text: "Logs")),
                
                  
                      
                  ],
                ),
              ),
              Expanded(
              child: TabBarView(
                        children: [
                      ActiveScreen(),
                        RespondedScreen(),
                          CompletedScreen(),
                          // PendingScreen(),
                           RejectionScreen(),
                            TrainingScreen(),
                             ReimbursementScreen(),
                              LogsScreen()
                         
                        ],
                      ),
            ),
            ],
          )
        ),
      ),
    );
  }
}
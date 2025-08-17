
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:help_desk_hosanna/Api/notification_api.dart';
import 'package:help_desk_hosanna/Modal/tickets_complete_data.dart';
import 'package:intl/intl.dart';

class TicketDataCard extends StatefulWidget {
  final String date;
  final String role;
  final String name;
  final String priority;
  final Media media; 
  final String profilePhoto;
  final String ticketId;
  
  const TicketDataCard({
    super.key, required this.date, required this.role, required this.name, required this.priority, required this.media, required this.profilePhoto, required this.ticketId
  });

  @override
  State<TicketDataCard> createState() => _TicketDataCardState();
}

class _TicketDataCardState extends State<TicketDataCard> {
  int reminderCount = 0;
  fetchReminderCount()  {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
   
   
      var res=await NotificationApi().fetchReminders(widget.ticketId.toString());
    reminderCount = int.parse(
  jsonDecode(res.body)['reminders'].length == 0
      ? '0'
      : jsonDecode(res.body)['reminders'][0]['count'].toString(),
);
   setState(() {
       
     });
     });
  
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchReminderCount();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 5.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(10)
          ),
          child: Text("Reminders $reminderCount",style: TextStyle(color: Colors.white),),),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           CircleAvatar(
               child: ClipOval(
                 child: FadeInImage(
                       placeholder: AssetImage("assets/images/person1.png"),
                       image: NetworkImage("${ApiConstant.baseUrl}ticket/getmedia/${widget.profilePhoto.split("/").last}"),
                       imageErrorBuilder: (context, error, stackTrace) {
                         return Image.asset("assets/images/person1.png");
                       },
                     
                 ),
               ),
                radius: 25.r,// Replace with your asset
            ),
            Flexible(child: Text(widget.name,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          Flexible(child: Text(formatDate(widget.date),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20),)),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text(widget.role,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          widget.media.voiceNoteUrl==null?SizedBox():  Icon(Icons.play_arrow),
               widget.media.imageUrl==null?SizedBox(): Icon(Icons.image),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(color:  widget.priority == "Very Urgent"
                          ? Colors.red
                          : widget.priority == "Urgent"
                          ? Colors.purple
                          : Colors.blue ,borderRadius: BorderRadius.circular(10)),
            child: Text(widget.priority,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),)),
        ]),
        
             
    ],),);
  }

 String formatDate(String deadline) {
    DateTime dateTime = DateTime.parse(deadline); // Parse the deadline into DateTime
    return DateFormat('dd-MM-yyyy').format(dateTime); // Format to "yyyy-MM-dd"
  }

  // Function to format the time
  String formatTime(String deadline) {
    DateTime dateTime = DateTime.parse(deadline); // Parse the deadline into DateTime
    return DateFormat('hh:mm:aa').format(dateTime); // Format to "HH:mm"
  }
}
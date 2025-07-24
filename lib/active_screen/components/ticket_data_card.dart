
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:help_desk_hosanna/Modal/tickets_complete_data.dart';
import 'package:intl/intl.dart';

class TicketDataCard extends StatelessWidget {
  final String date;
  final String role;
  final String name;
  final String priority;
  final Media media; 
  final String profilePhoto;
  
  const TicketDataCard({
    super.key, required this.date, required this.role, required this.name, required this.priority, required this.media, required this.profilePhoto,
  });

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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           CircleAvatar(
               child: ClipOval(
                 child: FadeInImage(
                       placeholder: AssetImage("assets/images/person1.png"),
                       image: NetworkImage("${ApiConstant.baseUrl}ticket/getmedia/${profilePhoto.split("/").last}"),
                       imageErrorBuilder: (context, error, stackTrace) {
                         return Image.asset("assets/images/person1.png");
                       },
                     
                 ),
               ),
                radius: 25.r,// Replace with your asset
            ),
            Flexible(child: Text(name,overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
          Flexible(child: Text(formatDate(date),overflow: TextOverflow.ellipsis,style: TextStyle(fontSize: 20),)),
        ],),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Text(role,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
          media.voiceNoteUrl==null?Container():  Icon(Icons.play_arrow),
               media.imageUrl==null?Container(): Icon(Icons.image),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(color:  priority == "Very Urgent"
                          ? Colors.red
                          : priority == "Urgent"
                          ? Colors.purple
                          : Colors.blue ,borderRadius: BorderRadius.circular(10)),
            child: Expanded(child: Text(priority,overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.white),))),
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
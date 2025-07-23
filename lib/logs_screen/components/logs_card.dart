import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:intl/intl.dart';

class LogsCard extends StatefulWidget {
  final String name;
  final String lastActive;
  final String status;
  final String profileImage;
  const LogsCard({super.key, required this.name, required this.lastActive, required this.status, required this.profileImage});

  @override
  State<LogsCard> createState() => _LogsCardState();
}

class _LogsCardState extends State<LogsCard> {
 

String formatTimestamp(String utcTimestamp) {
  // Parse the UTC timestamp
  final dateTime = DateTime.parse(utcTimestamp).toLocal();

  // Get current date for comparison
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final inputDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

  // Format time as "11:00 AM"
  final timeFormat = DateFormat('h:mm a');
  final formattedTime = timeFormat.format(dateTime);

  // Determine the date label (Today, Yesterday, or formatted date)
  String dateLabel;
  if (inputDate == today) {
    dateLabel = 'Today';
  } else if (inputDate == today.subtract(const Duration(days: 1))) {
    dateLabel = 'Yesterday';
  } else {
    dateLabel = DateFormat('MMM d, yyyy').format(dateTime); // e.g., Jul 14, 2025
  }

  // Return formatted string with tab
  return '$formattedTime \t $dateLabel';
}
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(color: Colors.grey.shade700,borderRadius: BorderRadius.circular(10)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
           CircleAvatar(
               child: ClipOval(
                 child: FadeInImage(
                       placeholder: AssetImage("assets/images/person1.png"),
                       image: NetworkImage("${ApiConstant.baseUrl}ticket/getmedia/${widget.profileImage.split("/").last}"),
                       imageErrorBuilder: (context, error, stackTrace) {
                         return Image.asset("assets/images/person1.png");
                       },
                     
                 ),
               ),
                radius: 30.r,// Replace with your asset
            ),
        SizedBox(width: 20.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            Text("${widget.name}",style: TextStyle(color: Colors.white,fontSize: 20),),
            Text("Last Active",style: TextStyle(color: Colors.white,fontSize: 18),),
            Text(widget.lastActive == "N/A" ? "N/A" : " ${formatTimestamp(widget.lastActive)}",style: TextStyle(color: Colors.white,fontSize: 18),),

          ]),
          Spacer(),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
            decoration: BoxDecoration(color:widget.status=='active'? Colors.green:Colors.red,borderRadius: BorderRadius.circular(10)),
            child: Text("${widget.status=='active'?"Active":"Inactive"}",style: TextStyle(color: Colors.white,fontSize: 18),),)
        ],),
      ),
    );
  }
}
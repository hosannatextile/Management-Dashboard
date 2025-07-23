
import 'package:flutter/material.dart';
import 'package:help_desk_hosanna/active_screen/components/admin_activity_data_card.dart';
import 'package:help_desk_hosanna/active_screen/components/ticket_data_card.dart';

class AdminActivityScreenCard extends StatelessWidget {
  final Color background;
  final String title;
  
  const AdminActivityScreenCard({
    super.key, required this.background, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10)
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            Text(title,style: TextStyle(color: Colors.white,fontSize: 25),),
            Column(
              children: [
                    // AdminActivityDataCard(incargeName: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",adminName: "Ahmed",),
                    // AdminActivityDataCard(incargeName: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",adminName: "Ahmed",),
                    // AdminActivityDataCard(incargeName: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",adminName: "Ahmed",),
                    // AdminActivityDataCard(incargeName: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",adminName: "Ahmed",),
                    // AdminActivityDataCard(incargeName: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",adminName: "Ahmed",),
                    Text("Comming Soon")
                
              ],
            ),
            Text("Previous Month(0)",style: TextStyle(color: Colors.white,fontSize: 25),),
          ],),
        ),
      ),
    );
  }
}


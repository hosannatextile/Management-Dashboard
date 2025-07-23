
import 'package:flutter/material.dart';

class AdminActivityDataCard extends StatelessWidget {
  final String date;
  final String role;
  final String incargeName;

  final String priority;
  final String adminName;
  const AdminActivityDataCard({
    super.key, required this.date, required this.role, required this.priority, required this.incargeName, required this.adminName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10)
      ),
      child: Column(children: [
        Row(children: [
          CircleAvatar(
            backgroundImage: AssetImage("assets/images/user.png"),
          ),
          Spacer(),
          Text(date,style: TextStyle(fontSize: 20),),
        ],),
        Row(children: [
          Column(children: [
            Text(incargeName,style: TextStyle(fontSize: 20),),
            Text(role,style: TextStyle(fontSize: 20),)
          ],),
          Spacer(),
          Column(children: [
            Text(adminName,style: TextStyle(fontSize: 20),),
            Text("Admin",style: TextStyle(fontSize: 20),)
          ],),
        ])
    ],),);
  }
}
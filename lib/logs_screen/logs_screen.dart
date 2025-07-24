import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:help_desk_hosanna/Api/api.dart';
import 'package:help_desk_hosanna/logs_screen/components/logs_card.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  List<dynamic> inchargeList = [];
  List<dynamic> adminList = [];

  getData() async {
   await ApiHelper().getUsersByRole("Admin").then((value) => setState(() => adminList = jsonDecode(value.body)));
   await ApiHelper().getUsersByRole("Incharge").then((value) => setState(() => inchargeList = jsonDecode(value.body)));
   setState(() {
     
   });
  }
  
  @override
  void initState() {
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SingleChildScrollView(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Incharge List
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "User: Incharge",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 100, // Constrain height
                    child:inchargeList.isEmpty ? const Center(child: Text("No logs")): ListView.builder(
                      shrinkWrap: true,
                      itemCount: inchargeList.length,
                      itemBuilder: (context, index) {
                        return LogsCard(
                          name: inchargeList[index]["fullName"] ?? "No Name",
                          lastActive: inchargeList[index]["lastSeen"] ?? "N/A",
                          status: inchargeList[index]["status"] ?? "Unknown",
                           profileImage: inchargeList[index]["profilePhoto"] ?? "",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Admin List
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "User: Admin",
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 100, // Constrain height
                    child:adminList.isEmpty ? const Center(child: Text("No logs")): ListView.builder(
                      shrinkWrap: true,
                      itemCount: adminList.length,
                      itemBuilder: (context, index) {
                        return LogsCard(
                          name: adminList[index]["fullName"] ?? "No Name",
                          lastActive: adminList[index]["lastSeen"] ?? "N/A",
                          status: adminList[index]["status"] ?? "Unknown",
                          profileImage: adminList[index]["profilePhoto"] ?? "",
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
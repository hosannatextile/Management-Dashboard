import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:help_desk_hosanna/Modal/admin_activity.dart';
import 'package:help_desk_hosanna/controllers/ticket_controller.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({super.key});

  @override
  State<PendingScreen> createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  TicketController ticketController = Get.put(TicketController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ticketController.getAdminActivity();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: ListView(
        children: [
           Card(
            color: Colors.grey.shade800,
              margin: EdgeInsets.all(8),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // ───────── column 0 ─────────
                    Expanded(
                      flex: 3, // <- bigger/smaller numbers tweak width
                      child: Text(
                        'Title',
                        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow),
                      ),
                    ),

                    // ───────── column 1 ─────────
                    Expanded(
                      flex: 3,
                      child: Text("Priority",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)),
                    ),

                    // // ───────── column 2 ─────────
                    // Expanded(
                    //   flex: 3,
                    //   child: Text('Type',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)),
                    // ),

                    // ───────── column 3 ─────────
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Assign By',
                        textAlign: TextAlign
                            .start, 
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)// right-align last column if you like
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Status',
                        textAlign: TextAlign
                            .start, // right-align last column if you like
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        'Date',
                        textAlign: TextAlign
                            .center, // right-align last column if you like
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)
                      ),
                    ),
                  ],
                ),
              ),
            ),
             Obx(() {
  if (ticketController.adminActivity.isEmpty) {
    return const Center(
      child: Text("No Data", style: TextStyle(color: Colors.white)),
    );
  }

  return ListView.builder(
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    itemCount: ticketController.adminActivity.length,
    itemBuilder: (context, adminIndex) {
      final admin = ticketController.adminActivity[adminIndex];
      final assignments = admin.assignments as List;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Admin Header
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "👤 ${admin.fullName} (${admin.role})",
              style: const TextStyle(
                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            ),
          ),

          // Assignments List
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: assignments.length,
            itemBuilder: (context, assignIndex) {
              final Assignments assignment = assignments[assignIndex];

              return Card(
                color: Colors.grey.shade700,
                margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          assignment.details ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    
                      Expanded(
                        flex: 3,
                        child: Text(
                          assignment.priority ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                     
                      Expanded(
                        flex: 3,
                        child: Text(
                          assignment.userId!.fullName ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          assignment.status ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Text(
                          assignment.createdAt
                              .toString()
                              .split("T")[0], // just date
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      );
    },
  );
}),

        ],
      )
    );
  }
}
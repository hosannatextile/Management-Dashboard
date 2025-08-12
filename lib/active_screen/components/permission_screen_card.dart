import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:help_desk_hosanna/Modal/tickets_complete_data.dart';
import 'package:help_desk_hosanna/active_screen/components/ticket_data_card.dart';
import 'package:help_desk_hosanna/controllers/ticket_controller.dart';

class PermissionScreenCard extends StatefulWidget {
  final Color background;
  final String title;

  const PermissionScreenCard({
    super.key,
    required this.background,
    required this.title,
  });

  @override
  State<PermissionScreenCard> createState() => _PermissionScreenCardState();
}

class _PermissionScreenCardState extends State<PermissionScreenCard> {
  TicketController ticketController = Get.put(TicketController());
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              "(${ticketController.permissionList.value.ticketDetails!.length}) Permissions",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
           Expanded(
  child: Obx(() {
    final ticketData = ticketController.permissionList.value;
    
    if (ticketData == null ||
        ticketData.ticketDetails == null ||
        ticketData.ticketDetails!.isEmpty) {
      return const Center(child: Text("No Data"));
    }

    return SizedBox(
      width: double.infinity, // ✅ fixes unbounded width error
      child: ListView.builder(
        itemCount: ticketData.ticketDetails!.length,
        itemBuilder: (context, index) {
          final ticket = ticketData.ticketDetails![index];
          if (ticket.ticket == null) return const SizedBox.shrink();

          return Tooltip(
            message: "Please check on the App",
            child: TicketDataCard(
              name: ticket.sender?.fullName ?? "No Name",
              role: ticket.sender?.role ?? "Unknown",
              date: ticket.ticket?.createdAt?.split("T").first ?? "",
              priority: ticket.ticket?.priority ?? "N/A",
              media:ticket.ticket!.media!,
              profilePhoto: ticket.sender?.profilePhoto ?? "",
             
            ),
          );
        },
      ),
    );
  }),
),

            // Column(
            //   children: [
            //     TicketDataCard(name: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",),
            //     TicketDataCard(name: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",),
            //     TicketDataCard(name: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",),
            //     TicketDataCard(name: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",),
            //     TicketDataCard(name: "Rashid",role: "Incharge",date: "26-6-2025",priority: "High",),
        
            //   ],
            // ),
            Text(
              "Previous Month(0)",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}

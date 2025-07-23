import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:help_desk_hosanna/Modal/tickets_complete_data.dart';
import 'package:help_desk_hosanna/active_screen/components/ticket_data_card.dart';
import 'package:help_desk_hosanna/controllers/ticket_controller.dart';

class ComplaintScreenCard extends StatefulWidget {
  final Color background;
  final String title;

  const ComplaintScreenCard({
    super.key,
    required this.background,
    required this.title,
  });

  @override
  State<ComplaintScreenCard> createState() => _ComplaintScreenCardState();
}

class _ComplaintScreenCardState extends State<ComplaintScreenCard> {
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
              "(${ticketController.complaintsList.value.ticketDetails!.length}) Complaints",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
           Expanded(
  child: Obx(() {
    final ticketData = ticketController.complaintsList.value;
   
    if (ticketData == null ||
        ticketData.ticketDetails == null ||
        ticketData.ticketDetails!.isEmpty) {
      return const Center(child: Text("No Data"));
    }

    return SizedBox(
      width: double.infinity, // ✅ fixes unbounded width error
      child: ListView.builder(
        // reverse: true,
        itemCount: ticketData.ticketDetails!.length,
        itemBuilder: (context, index) {
          final ticket = ticketData.ticketDetails![index];
          if (ticket.ticket == null) return const SizedBox.shrink();

          return TicketDataCard(
            name: ticket.sender?.fullName ?? "No Name",
            role: ticket.sender?.role ?? "Unknown",
            date: ticket.ticket?.createdAt?.split("T").first ?? "",
            priority: ticket.ticket?.priority ?? "N/A",
            media:ticket.ticket!.media!,
            profilePhoto: ticket.sender?.profilePhoto ?? "",
           
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

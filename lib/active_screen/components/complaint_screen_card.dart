import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  late final TicketController ticketController;

  @override
  void initState() {
    super.initState();
    ticketController = Get.find<TicketController>();
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          color: widget.background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Text(
              "(${ticketController.complaintsList.value?.ticketDetails?.length ?? 0}) Complaints",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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
                  width: double.infinity,
                  child: ListView.builder(
                    cacheExtent: 1000,
                    itemCount: ticketData.ticketDetails!.length,
                    itemBuilder: (context, index) {
                      final ticket = ticketData.ticketDetails![index];
                      if (ticket.ticket == null) return const SizedBox.shrink();

                      return Tooltip(
                        message: "Please check on the App",
                        textStyle: TextStyle(fontSize: 20),
                        child: TicketDataCard(
                          name: ticket.sender?.fullName ?? "No Name",
                          role: ticket.sender?.role ?? "Unknown",
                          date: ticket.ticket?.createdAt?.split("T").first ?? "",
                          priority: ticket.ticket?.priority ?? "N/A",
                          media: ticket.ticket?.media??Media(),
                          profilePhoto: ticket.sender?.profilePhoto ?? "",
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
            Text(
              "Previous Month(0)",
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
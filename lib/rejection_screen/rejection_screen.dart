import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:help_desk_hosanna/Api/api.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:help_desk_hosanna/Api/ticket_api.dart';
import 'package:help_desk_hosanna/controllers/ticket_controller.dart';

class RejectionScreen extends StatefulWidget {
  const RejectionScreen({super.key});

  @override
  State<RejectionScreen> createState() => _RejectionScreenState();
}

class _RejectionScreenState extends State<RejectionScreen> {
  TicketController ticketController = Get.put(TicketController());

  @override
  void initState() {
    // TODO: implement initState
    
    ticketController.getRejectedTicket();
    super.initState();
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
                      flex: 2, // <- bigger/smaller numbers tweak width
                      child: Text(
                        'Title',
                        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                      ),
                    ),

                    // ───────── column 1 ─────────
                    Expanded(
                      flex: 3,
                      child: Text("Type",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                    ),

                    // ───────── column 2 ─────────
                    Expanded(
                      flex: 3,
                      child: Text('Priority',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)),
                    ),

                    // ───────── column 3 ─────────
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Incharge Name',
                        textAlign: TextAlign
                            .start, 
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)// right-align last column if you like
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Date',
                        textAlign: TextAlign
                            .center, // right-align last column if you like
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white)
                      ),
                    ),
                  ],
                ),
              ),
            ),
             Obx(()=>
            ticketController.rejectedTicketList.value.ticketDetails==null ?Expanded(child: Center(child: Text("No Data",style: TextStyle(color: Colors.white),),)):
             ListView.builder(
              shrinkWrap: true,
              itemCount: ticketController.rejectedTicketList.value.ticketDetails!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey.shade800,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text('${ticketController.rejectedTicketList.value.ticketDetails![index].ticket!.description}',style: const TextStyle(color: Colors.white)),),
                        Expanded(
                          flex: 3,
                          child: Text('${ticketController.rejectedTicketList.value.ticketDetails![index].ticket!.type}',style: const TextStyle(color: Colors.white)),),
                        Expanded(
                          flex: 3,
                          child: Text('${ticketController.rejectedTicketList.value.ticketDetails![index].ticket!.priority}',style: const TextStyle(color: Colors.white))),
                        Expanded(
                          flex: 2,
                          child: Text('${ticketController.rejectedTicketList.value.ticketDetails![index].sender!.fullName}',style: const TextStyle(color: Colors.white))),
                        Expanded(
                        flex: 2,
                          child: Text('${ticketController.rejectedTicketList.value.ticketDetails![index].ticket!.createdAt!.split("T")[0]}',style: const TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
                      ],
                    ),
                  ),
                );
              },
            ),
            )
        ],
      )
    );
  }
}
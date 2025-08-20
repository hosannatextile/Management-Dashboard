import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:help_desk_hosanna/Api/api_constant.dart';
import 'package:help_desk_hosanna/controllers/ticket_controller.dart';
import 'package:help_desk_hosanna/knowledge_screen/audio_player_widget.dart';
import 'package:help_desk_hosanna/knowledge_screen/image_dialog.dart';
import 'package:help_desk_hosanna/knowledge_screen/video_player_widget.dart';

class KnowledgeScreen extends StatefulWidget {
  const KnowledgeScreen({super.key});

  @override
  State<KnowledgeScreen> createState() => _KnowledgeScreenState();
}

class _KnowledgeScreenState extends State<KnowledgeScreen> {
  TicketController ticketController = Get.put(TicketController());
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
                        style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow),
                      ),
                    ),

                    // ───────── column 1 ─────────
                    Expanded(
                      flex: 3,
                      child: Text("Type",style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)),
                    ),

                    // ───────── column 2 ─────────
                    Expanded(
                      flex: 3,
                      child: Text('Priority',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)),
                    ),

                    // ───────── column 3 ─────────
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Incharge Name',
                        textAlign: TextAlign
                            .start, 
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)// right-align last column if you like
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Date',
                        textAlign: TextAlign
                            .center, // right-align last column if you like
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Mark Read',
                        textAlign: TextAlign
                            .center, // right-align last column if you like
                            style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.yellow)
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Obx(()=>
            ticketController.knowledgeList.value.ticketDetails!.length==0 ?Center(child: Text("No Data",style: TextStyle(color: Colors.white),),):
             ListView.builder(
              shrinkWrap: true,
              itemCount: ticketController.knowledgeList.value.ticketDetails!.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.grey.shade700,
                  margin: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text('${ticketController.knowledgeList.value.ticketDetails![index].ticket!.description}',style: const TextStyle(color: Colors.white)),),
                            Expanded(
                              flex: 3,
                              child: Text('${ticketController.knowledgeList.value.ticketDetails![index].ticket!.type}',style: const TextStyle(color: Colors.white)),),
                            Expanded(
                              flex: 3,
                              child: Text('${ticketController.knowledgeList.value.ticketDetails![index].ticket!.priority}',style: const TextStyle(color: Colors.white))),
                            Expanded(
                              flex: 2,
                              child: Text('${ticketController.knowledgeList.value.ticketDetails![index].sender!.fullName}',style: const TextStyle(color: Colors.white))),
                            Expanded(
                            flex: 2,
                              child: Text('${ticketController.knowledgeList.value.ticketDetails![index].ticket!.createdAt!.split("T")[0]}',style: const TextStyle(color: Colors.white),textAlign: TextAlign.center,)),
                        
                              Expanded(
                              flex: 2,
                              child: Checkbox(value: ticketController.knowledgeList.value.ticketDetails![index].ticket!.status=="Seen" ? true : false, onChanged: (value){
                                ticketController.updateTicketStatus(ticketController.knowledgeList.value.ticketDetails![index].ticket!.sId!,ticketController.knowledgeList.value.ticketDetails![index].sender!.sId!,ApiConstant.loginData!.user!.id!, "Seen",);
                                ticketController.getAllTickets();
                                ticketController.update();
                              }),),
                          ],
                        ),
                       ticketController.knowledgeList.value.ticketDetails?[index].ticket?.media!=null ?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children:[
                          ticketController.knowledgeList.value.ticketDetails![index].ticket!.media!.imageUrl!=null ?Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:IconButton(onPressed: (){
                                showDialog(
                          context: context,
                          builder: (_) => ImageSliderDialog(
                            imageUrl:
                                '${ApiConstant.baseUrl}ticket/getmedia/${ticketController.knowledgeList.value.ticketDetails![index].ticket!.media!.imageUrl!.split("/").last}',
                            isFile: false,
                          ),
                                                    );
                            }, icon: Icon(Icons.image,color: Colors.white,),iconSize: 50,),
                            
                            
                          ):Container(),
                          ticketController.knowledgeList.value.ticketDetails![index].ticket!.media!.videoUrl!=null ?Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(Icons.play_arrow),
                              iconSize: 50,
                              color: Colors.white,
                              onPressed: () {
                                //return dialog
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        VideoPlayerWidget(
                                          url: "${ApiConstant.baseUrl}ticket/getmedia/${ticketController.knowledgeList.value.ticketDetails![index].ticket!.media!.videoUrl!.split("/").last}",
                                        ),
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            )
                          ):Container(),
                          ticketController.knowledgeList.value.ticketDetails![index].ticket!.media!.voiceNoteUrl!=null ?Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                             
                              child: AudioPlayerWidget(url: "${ApiConstant.baseUrl}ticket/getmedia/${ticketController.knowledgeList.value.ticketDetails![index].ticket!.media!.voiceNoteUrl!.split("/").last}",),
                            ),
                          ):Container()
                        ])
                        :SizedBox(),
                       
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
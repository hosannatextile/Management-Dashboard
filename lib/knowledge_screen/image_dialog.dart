
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageSliderDialog extends StatefulWidget {
  final String imageUrl;
  final bool isFile;
  const ImageSliderDialog({super.key, required this.imageUrl, required this.isFile});

  @override
  State<ImageSliderDialog> createState() => _ImageSliderDialogState();
}

class _ImageSliderDialogState extends State<ImageSliderDialog> {
  

  @override
  Widget build(BuildContext context) {
    bool isDark=Theme.of(context).brightness==Brightness.dark;
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      
      child: Container(
        padding: EdgeInsets.all(10),
        height: 400,
        width: 300,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Image",style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w700,color: Colors.black),),
               
                Container(
                  height: 36.h,
                  width: 36.h,
                  //padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,),
                  child: IconButton(icon:Icon(Icons.close,size: 18.sp,color: Colors.black,),onPressed: () => Navigator.pop(context),),
                )
              ],
            ),
             SizedBox(height: 15.h,),
            Expanded(
              child: 
               
                  widget.imageUrl.isEmpty?Container(child: Text("Image Not Available"),): Container(
                    width: 310.w,
                    height: 299.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image:widget.isFile?FileImage(File(widget.imageUrl)): NetworkImage(widget.imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                   ))
            
          ],
        ),
      ),
    );
  }
}
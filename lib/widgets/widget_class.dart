import 'package:flutter/material.dart';

class WidgetClass{

  Widget StatusBox(String status){
    return Container(
      alignment: Alignment.center,
      width: 150,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.white,),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Text(
        status,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  }


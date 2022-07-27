
import 'package:flutter/material.dart';

class getColors{

      getColors(){}

      static List colors=[Colors.red,Colors.yellow,Colors.black,Colors.green,Colors.tealAccent,Colors.blue];

     static Color getColor(int id){
     return colors[id];
  }

}
import 'dart:ui';

import 'package:flutter/material.dart';

Widget blury({required Widget child}) => ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
        child: child,
      ),
    );

String clockConverter(String c) {
  int h = int.parse(c.split(':').first);
  String m = c.split(':').last;
  if (h == 0) {
    return '${h + 12}:$m am';
  } else if (h == 12) {
    return '${h}:$m pm';
  } else if (h > 12) {
    return '${h - 12}:$m pm';
  } else if (h <= 11) {
    return '${h}:$m am';
  } else {
    return '';
  }
}

String clockConverter2(String c) {
  int h = int.parse(c.split(':').first);
  if (h == 0) {
    return '${h + 12} am';
  } else if (h == 12) {
    return '${h} pm';
  } else if (h > 12) {
    if(h-12 > 9){
      return '${h-12} pm';
    }else{
      return '0${h-12} pm';
    }
  } else if (h <= 11) {
    if(h > 9){
      return '${h} am';
    }else{
      return '0${h} am';
    }
  } else {
    return '';
  }
}

String dateConverter(String date) {
  List<String> l = date.split('-');
  return '${l[2]}/${l[1]}/${l[0]}';
}

Widget degree({
  required String text,
  required TextStyle style,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    textBaseline: TextBaseline.alphabetic,
    children: [
      Text(
        '$text',
        style: style,
      ),
      Icon(
        Icons.circle_outlined,
        color: style.color,
        size: style.fontSize! / 3,
      ),
    ],
  );
}

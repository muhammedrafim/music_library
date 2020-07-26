
import 'package:flutter/material.dart';

networkerror()=> Container(child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.error),
            Text("No Network Connection"),
          ],
        ),
      ));

textstyle()=>TextStyle(
  fontSize:16,
  fontWeight:FontWeight.bold
);
textstyle1()=>TextStyle(
  fontSize:18,
  fontWeight:FontWeight.w400
);
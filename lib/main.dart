import 'package:flutter/material.dart';
import 'package:music_library/connectivity_service.dart';
import 'package:music_library/enums/connectivity_status.dart';
import 'package:music_library/home.dart';
import 'package:provider/provider.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
@override

  @override
  Widget build(BuildContext context) {
    return 
    StreamProvider<ConnectivityStatus>(
      create: (context) =>
          ConnectivityService().connectionStatusController.stream,
   
       child:Home()
    
    );
  }
}
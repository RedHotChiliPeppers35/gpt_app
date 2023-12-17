import 'package:flutter/material.dart';
import 'package:flutter_application_2/chat_screen.dart';

void
    main() {
  runApp(MyApp());
}

class MyApp
    extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Hello World",
      home: ChatScreen(),
    );
  }
}

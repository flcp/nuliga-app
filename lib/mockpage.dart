import 'package:flutter/material.dart';

class Mockpage extends StatelessWidget {
  const Mockpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: Text("hello")),
          Divider(),
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(icon: Icon(Icons.edit), onPressed: () {}),
          ),
        ],
      ),
    );
  }
}

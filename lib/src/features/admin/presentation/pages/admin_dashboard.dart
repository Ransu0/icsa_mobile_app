import 'package:flutter/material.dart';

class AdminDashboardPage extends StatefulWidget {
  const AdminDashboardPage({super.key, required this.title});

  final String title;

  @override
  State<AdminDashboardPage> createState() => _AdminDashboardPage();
}

class _AdminDashboardPage extends State<AdminDashboardPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Row(
            children: [Text("HI")],
          )
        ],
      ),
    );
  }
}

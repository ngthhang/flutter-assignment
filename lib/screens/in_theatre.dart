import 'package:flutter/material.dart';

class InTheatreScreen extends StatefulWidget {
  const InTheatreScreen({Key? key}) : super(key: key);

  @override
  State<InTheatreScreen> createState() => _InTheatreScreenState();
}

class _InTheatreScreenState extends State<InTheatreScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
          child: Text('in theature', style: TextStyle(color: Colors.white)),
    ),
    );
  }
}

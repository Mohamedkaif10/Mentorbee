import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuddyDetailsPage extends StatefulWidget {
  final String buddyId;

  BuddyDetailsPage({required this.buddyId});

  @override
  _BuddyDetailsPageState createState() => _BuddyDetailsPageState();
}

class _BuddyDetailsPageState extends State<BuddyDetailsPage> {
  Map<String, dynamic> buddyDetails = {};

  @override
  void initState() {
    super.initState();
    fetchBuddyDetails();
  }

  Future<void> fetchBuddyDetails() async {
    final response = await http.get(Uri.parse('http://localhost:8010/buddies/${widget.buddyId}')); // Replace with your API endpoint
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      setState(() {
        buddyDetails = data;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buddy Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${buddyDetails['name']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Location: ${buddyDetails['location']}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Team: ${buddyDetails['team']}',
              style: TextStyle(fontSize: 18),
            ),
            // Add more details as needed
          ],
        ),
      ),
    );
  }
}
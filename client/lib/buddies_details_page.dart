import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookapnmt.dart';

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
    try {
      final response = await http
          .get(Uri.parse('http://192.168.31.173:8001/buddies/${widget.buddyId}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          buddyDetails = data;
        });
      } else {
        print('Failed to load buddy details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void bookAppointment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookAppointmentPage(buddyDetails: buddyDetails),
      ),
    );
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
              'Name: ${buddyDetails['name'] ?? 'Loading...'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Location: ${buddyDetails['location'] ?? 'Loading...'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Team: ${buddyDetails['team'] ?? 'Loading...'}',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
              onPressed: bookAppointment,
              child: Text('Book an Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}

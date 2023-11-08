import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'bookaptmenti.dart';

class MentiDetailsPage extends StatefulWidget {
  final String mentiId;

  MentiDetailsPage({required this.mentiId});

  @override
  _MentiDetailsPageState createState() => _MentiDetailsPageState();
}

class _MentiDetailsPageState extends State<MentiDetailsPage> {
  Map<String, dynamic> mentiDetails = {};

  @override
  void initState() {
    super.initState();
    fetchMentiDetails();
  }

  Future<void> fetchMentiDetails() async {
    try {
      final response = await http
          .get(Uri.parse('http://192.168.31.173:8001/mentis/${widget.mentiId}'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          mentiDetails = data;
        });
      } else {
        print('Failed to load Menti details');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void bookAppointment() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookAppointmentPageMenti(mentiDetails: mentiDetails),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menti Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Name: ${mentiDetails['name'] ?? 'Loading...'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Location: ${mentiDetails['location'] ?? 'Loading...'}',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Team: ${mentiDetails['team'] ?? 'Loading...'}',
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

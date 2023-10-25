import 'package:flutter/material.dart';
import 'main_page.dart'; // Import the ThirdPage
import 'package:http/http.dart' as http;
import 'dart:convert';

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
Future<void> makePostRequest(String otp) async {
  final url = Uri.parse('http://localhost:8010/verifyOtp'); // Replace with your API endpoint
  try {
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'otp': otp,
      }),
    );

    if (response.statusCode == 200) {
      // If the request is successful, navigate to the ThirdPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ThirdPage(),
        ),
      );
    } else if (response.statusCode == 400) {
      // Handle a 400 status code (Bad Request) by showing an error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Invalid OTP. Please enter a valid OTP.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // Handle other error status codes or display a generic error message
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to make a POST request.'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  } catch (error) {
    print('Error: $error'); // Print the error to the console
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Failed to make a POST request. Check your network connection.'),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.blue,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter text',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String otp = _textController.text;
                print("Otp: $otp");
                makePostRequest(otp);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
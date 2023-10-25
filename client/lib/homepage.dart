import 'package:flutter/material.dart';
import 'otpPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Import dart:convert

class InputBoxWithButton extends StatefulWidget {
  @override
  _InputBoxWithButtonState createState() => _InputBoxWithButtonState();
}

class _InputBoxWithButtonState extends State<InputBoxWithButton> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> makePostRequest(String email) async {
    final url = Uri.parse('http://localhost:8010'); // Replace with your API endpoint
    final response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
      }),
    );

    if (response.statusCode == 200) {
      // If the request is successful, navigate to the OTPPage
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SecondPage(),
        ),
      );
    } else {
      // Handle the error or display a message for failed requests
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Box with Button'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Wrap the TextField with a Container to add margins and background color
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0), // Adjust margins as needed
              padding: EdgeInsets.all(10.0), // Add padding for the input box
              color: Colors.blue, // Set the background color to blue
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                  labelText: 'Enter email',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String email = _textController.text;
                print("Email: $email");
                makePostRequest(email);
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

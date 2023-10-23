import 'package:flutter/material.dart';
import 'otpPage.dart'; // Import the SecondPage

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
                  labelText: 'Enter text',
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                String inputText = _textController.text;
                print("Input Text: $inputText");
                // Navigate to the SecondPage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondPage(),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

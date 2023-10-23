import 'package:flutter/material.dart';
import 'main_page.dart'; // Import the ThirdPage

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
                String inputText = _textController.text;
                print("Input Text: $inputText");
                // Navigate to the ThirdPage when the button is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ThirdPage(),
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

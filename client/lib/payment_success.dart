import 'package:flutter/material.dart';

class PaymentSuccessPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Success'),
      ),
      body: Center(
        child: Text(
          'Payment successful!',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

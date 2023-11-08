import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends StatefulWidget {
  final int amount; // Assuming the amount is an integer, adjust the type accordingly

  PaymentPage({required this.amount});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pay ${widget.amount} rupees to book the appointment',
              style: TextStyle(fontSize: 20),
            ),
            ElevatedButton(
              onPressed: () => _launchUPI(),
              child: Text('Proceed to Pay', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUPI() async {
    final Uri _url = Uri.parse('upi://pay?pa=mkaif7736@oksbi&pn=Mohamed-kaif&am=${widget.amount}&cu=INR');

    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
}

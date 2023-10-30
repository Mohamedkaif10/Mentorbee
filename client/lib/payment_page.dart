import 'package:flutter/material.dart';
import 'package:upi_india/upi_india.dart';

class PaymentPage extends StatefulWidget {
  final String amount;

  PaymentPage({required this.amount});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}
class _PaymentPageState extends State<PaymentPage> {
  UpiIndia _upiIndia = UpiIndia();
  List<UpiApp>? apps;

  @override
  void initState() {
    super.initState();
    _loadUpiApps();
  }

Future<UpiResponse> initiateTransaction(UpiApp app) async {
    return _upiIndia.startTransaction(
      app: app,
      receiverUpiId: "9078600498@ybl",
      receiverName: 'Md Azharuddin',
      transactionRefId: 'TestingUpiIndiaPlugin',
      transactionNote: 'Not actual. Just an example.',
      amount: double.parse(widget.amount), // Parse the amount to a double
    );
  }
  Future<void> _loadUpiApps() async {
    try {
      List<UpiApp>? result = await _upiIndia.getAllUpiApps(mandatoryTransactionId: false);
      if (result != null) {
        setState(() {
          apps = result;
        });
      }
    } catch (e) {
      setState(() {
        apps = [];
      });
    }
  }

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
              onPressed: () {
                // Example initiation of the UPI transaction
                initiateTransaction(UpiApp.googlePay);
              },
              child: Text('Proceed to Pay', style: TextStyle(fontSize: 18)),
            ),
            // Additional widgets and logic
          ],
        ),
      ),
    );
  }
}